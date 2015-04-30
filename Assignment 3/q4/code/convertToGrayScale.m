function GrayFrames = convertToGrayScale(F)
    l = size(F,2);
    assert(l > 0, ' F should not be empty');
    imageSize = size(F(1).cdata);
    GrayFrames = zeros(imageSize(1),imageSize(2),l);
    for i=1:l
        GrayFrames(:,:,i) = rgb2gray(F(i).cdata);
    end
end