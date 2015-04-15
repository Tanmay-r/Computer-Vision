function [theta] = OMP(signal, A, m)
    residual = signal;
    tempA = A;
    count = 0;
    T = zeros(m, 1);
    marker = zeros(size(tempA, 2), 1);  
    supportA = zeros(size(tempA, 1), size(tempA, 2));
    
    while(count < m)        
        value = zeros(size(tempA, 2), 1);
        for i=1:size(tempA, 2)
            if(marker(i) == 0)
                value(i) = abs((residual*tempA(:, i)/norm(tempA(:, i))));
            end
        end
        [~, max_index] = max(value);
        
        T(count + 1) = max_index;
        marker(max_index) = 1;
        count = count + 1;
        supportA(:, count) = tempA(:, max_index);
        S = supportA(:, 1:count)\signal';
        residual = signal - (supportA(:, 1:count)*S)';
    end
    
    theta = zeros(64, 1);
    for i = 1:size(T)
        theta(T(i), 1) = S(i);
    end
        
    