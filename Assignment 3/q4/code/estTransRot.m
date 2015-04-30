function H = estTransRot(varargin)

    [x1, x2] = checkargs(varargin(:));
    num = size(x1,2);
    x1Mean = mean(x1,2);
    x2Mean = mean(x2,2);
    
    x1New = x1 - x1Mean(:,ones(num,1));
    x2New = x2 - x2Mean(:,ones(num,1));
    
    temp= x1New * x2New';
    [U,~,V] = svd(temp);
    R = V*U';
    
    alpha = trace(x2New'*V*U'*x1New)/trace(x1New'*x2New);
    
    T = x2Mean - alpha*R*x1Mean;
    H = eye(3,3);
    H(1:2,1:2) = R;
    H(1:2,3) = T;
    H(3,3)=alpha;
    
end

%--------------------------------------------------------------------------
% Function to check argument values and set defaults

function [x1, x2] = checkargs(arg)
    if length(arg) == 2
	x1 = arg{1};
	x2 = arg{2};
	if ~all(size(x1)==size(x2))
	    error('x1 and x2 must have the same size');
	elseif size(x1,1) ~= 2
	    error('x1 and x2 must be 2xN');
	end
	
    elseif length(arg) == 1
	if size(arg{1},1) ~= 4
	    error('Single argument x must be 4xN');
	else
	    x1 = arg{1}(1:2,:);
	    x2 = arg{1}(3:4,:);
	end
    else
	error('Wrong number of arguments supplied');
    end
end