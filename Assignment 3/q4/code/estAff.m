function [H] = estAff(varargin)
    [x1, x2] = checkargs(varargin(:));
  
    A = x2*x1' * pinv(x1*x1');
    
    T = x2 - A*x1;
    T = mean(T,2);
    H = eye(3,3);
    H(1:2,1:2) = A;
    H(1:2,3) = T;
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