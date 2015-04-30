function [H,R,alpha,T] = estimateTranslationRotation(F1,F2,rotationYes)
    [num matchedPoints] = match(F1,F2);
    x1 = matchedPoints(:,1:2)';
    x2 = matchedPoints(:,3:4)';
    %x1 = x1';
    %x2 = x2';
    x1Mean = mean(x1,2);
    x2Mean = mean(x2,2);
    
    x1New = x1 - x1Mean(:,ones(num,1));
    x2New = x2 - x2Mean(:,ones(num,1));
    
    temp= x1New * x2New';
    [U,~,V] = svd(temp);
    R = V*U';
    
    alpha = trace(x2New'*V*U'*x1New)/trace(x1New'*x2New);
    if(rotationYes == false)
        R = eye(2,2);
    end
    T = x2Mean - alpha*R*x1Mean;
    H = eye(3,3);
    H(1:2,1:2) = R;
    H(1:2,3) = T;
end