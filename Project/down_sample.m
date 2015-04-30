for count = 1:24 
    if count<10
        filename=strcat('kodak/IMG000',int2str(count),'.bmp');
    else
        filename=strcat('kodak/IMG00',int2str(count),'.bmp');
    end
    img = imread(filename);
    img = double(img)/255;

    x = size(img, 1);
    y = size(img, 2);

    truncated_image = zeros(x/4, y/4, 3);
    for i=1:x/4
        for j=1:y/4
            truncated_image(i,j,:) = img(4*i, 4*j, :);
        end
    end

    if(size(truncated_image, 1) > size(truncated_image, 2))
        return_img(:,:,1) = truncated_image(:,:,1)';
        return_img(:,:,2) = truncated_image(:,:,2)';
        return_img(:,:,3) = truncated_image(:,:,3)';
        imwrite(return_img, strcat('down_',filename));
    else
        imwrite(truncated_image, strcat('down_',filename));
    end

    
end
