function T_smooth = averageFilter(T,n)
    no_of_frames= size(T,3);
    T_smooth =zeros(size(T));
    for i=1:n
        T_smooth(:,:,i) = sum(T(:,:,1:i+n),3)/(i+n);
    end
    for i=n+1:no_of_frames-n
         T_smooth(:,:,i) = sum(T(:,:,i-n:i+n),3)/(2*n+1);
    end
    for i=no_of_frames-n+1:no_of_frames
        T_smooth(:,:,i) = sum(T(:,:,i-n:end),3)/(no_of_frames-i+n+1);
    end
end