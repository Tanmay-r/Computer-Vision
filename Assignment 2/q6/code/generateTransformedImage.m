function [transformed_image] = generateTransformedImage(image, angle, x)

rotated_image = imrotate(image, angle);
translated_image = zeros(size(rotated_image, 1), size(rotated_image,2));
if(x > 0)
    translated_image(:, x+1:size(rotated_image, 2)) = rotated_image(:,1:size(rotated_image, 2)-x); 
elseif(x < 0)
    translated_image(:, 1:size(rotated_image, 2)+x) = rotated_image(:, -x+1:size(rotated_image, 2)); 
else
    translated_image = rotated_image;
end

transformed_image = zeros(size(image, 1), size(image,2));
transformed_image(:,:) = translated_image(size(translated_image, 1)/2 - size(image, 1)/2 + 1:size(translated_image, 1)/2 + size(image, 1)/2, size(translated_image, 2)/2 + 1 - size(image, 2)/2:size(translated_image, 2)/2 + size(image, 2)/2);

r = size(image, 1);
c = size(image, 2);

transformed_image = transformed_image + randn(size(transformed_image,1),size(transformed_image,2))*5;

for i =1:r
    for j=1:c
        if(transformed_image(i, j) < 0)
            transformed_image(i, j) = 0;
        elseif(transformed_image(i, j) > 255)
            transformed_image(i, j) = 255;
        end
    end
end

transformed_image = uint8(transformed_image);