function T_smooth = averageFilterRotation(T,n)
    no_of_frames= size(T,3);
    T_smooth =zeros(size(T));
    for i=1:n
        temp_angle = sum(asin(T(2,1,1:i+n)))/(i+n);
        T_smooth(:,:,i) = sum(T(:,:,1:i+n),3)/(i+n);
        T_smooth(1:2,1:2,i) = getRotationMatrix(temp_angle);
    end
    for i=n+1:no_of_frames-n
         temp_angle = sum(asin(T(2,1,i-n:i+n)))/(2*n+1);
         T_smooth(:,:,i) = sum(T(:,:,i-n:i+n),3)/(2*n+1);
         T_smooth(1:2,1:2,i) = getRotationMatrix(temp_angle);
    end
    for i=no_of_frames-n+1:no_of_frames
        temp_angle = sum(asin(T(2,1,i-n:end)))/(no_of_frames-i+n+1);
        T_smooth(:,:,i) = sum(T(:,:,i-n:end),3)/(no_of_frames-i+n+1);
        T_smooth(1:2,1:2,i) = getRotationMatrix(temp_angle);
    end
end

function A = getRotationMatrix(angle)
A = zeros(2,2);
A(1,1)= cos(angle);
A(end,end)= cos(angle);
A(2,1) = sin(angle);
A(1,2) = -sin(angle);

end