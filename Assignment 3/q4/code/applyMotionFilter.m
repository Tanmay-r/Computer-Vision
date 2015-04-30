function [F_gray] = applyMotionFilter(frames,T)
    no_of_frames =size(T,3);
    %F_color(1).cdata = frames.cdata;
    F_gray= zeros(size(frames(1).cdata(:,:,1),1),size(frames(1).cdata(:,:,1),2),no_of_frames);
    F_gray(:,:,1) = rgb2gray(frames(1).cdata);
    gray_img =  F_gray(:,:,1);
    for i=2:no_of_frames
        %cdata = zeros(size(F_color(i-1).cdata));
        %cdata(:,:,1) = warpping(F_color(i-1).cdata(:,:,1),T(i-1));
        %cdata(:,:,2) = warpping(F_color(i-1).cdata(:,:,2),T(i-1));
        %cdata(:,:,3) = warpping(F_color(i-1).cdata(:,:,3),T(i-1)); 
        %s.cdata = cdata;
        %F_color = [F_color s];
        F_gray(:,:,i) = warpping(gray_img,T(:,:,i-1)); 
        gray_img = rgb2gray(frames(i).cdata);
    end
end