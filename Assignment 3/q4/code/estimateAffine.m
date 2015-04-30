function [H] = estimateAffine(F1,F2)
    [num matchedPoints] = match(F1,F2);
    x1 = matchedPoints(:,1:2)';
    x2 = matchedPoints(:,3:4)';
    A = x2*x1' * pinv(x1*x1');
    
    T = x2 - A*x1;
    T = mean(T,2);
    H = eye(3,3);
    H(1:2,1:2) = A;
    H(1:2,3) = T;
end