filename=strcat('test1.jpg');

img = imread(filename);
img = double(img)/255;

x = size(img, 1);
y = size(img, 2);

truncated_image = zeros(x/2, y/2, 3);
for i=1:x/2
    for j=1:y/2
        truncated_image(i,j,:) = img(2*i, 2*j, :);
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
