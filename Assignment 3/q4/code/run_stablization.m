% Read Video Filess
function run_stablization(num,least_square,video_file,output_file)

% 1-> translation
% 2-> translation+rotation
% 3-> affine
    [video audio] = mmread(video_file);
    GrayScaleFrames = convertToGrayScale(video.frames);
    s = size(GrayScaleFrames,3);
    R = zeros(3);
    no_of_frames=30;
    T  = zeros(3,3,no_of_frames-1);
    for i=2:no_of_frames
        if(num==1)
            if(least_square)
                 T(:,:,i-1) = estimateTranslationRotation(GrayScaleFrames(:,:,i-1),GrayScaleFrames(:,:,i),0);
            else
                T(:,:,i-1) = estimateMotionTwoFrames(GrayScaleFrames(:,:,i-1),GrayScaleFrames(:,:,i),@ransacfitRotTrans);
            end
        elseif(num==2)
            if(least_square)
                 T(:,:,i-1) = estimateTranslationRotation(GrayScaleFrames(:,:,i-1),GrayScaleFrames(:,:,i),1);
            else
                T(:,:,i-1) = estimateMotionTwoFrames(GrayScaleFrames(:,:,i-1),GrayScaleFrames(:,:,i),@ransacfitRotTrans);
            end
        elseif(num==3)
             if(least_square)
                 T(:,:,i-1) = estimateAffine(GrayScaleFrames(:,:,i-1),GrayScaleFrames(:,:,i));
            else
                T(:,:,i-1) = estimateMotionTwoFrames(GrayScaleFrames(:,:,i-1),GrayScaleFrames(:,:,i),@ransacAff);
            end
        else
            'Wrong Input Parameters'
           return; 
        end
    end

    if(num==2)
        T_smooth = averageFilterRotation(T,4);
    else
        T_smooth = averageFilter(T,4);
    end
    if(num ==1 || num==2)
        figure();
        subplot(1,2,1);
        plot_motion_sequence(T_smooth);
        subplot(1,2,2);
        plot_motion_sequence(T);
        if(num==1)
            title('Motion Sequence after and before smoothing translation');
        else
            title('Motion Sequence after and before smoothing translation+rotation');
        end
    end
    videoSmoothFiltered = applyMotionFilter(video.frames,T_smooth);
    writevideo(output_file,videoSmoothFiltered/255,video.rate);
end