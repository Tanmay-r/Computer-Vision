function [joint_entropy] = part_2()

% Translated by 700 pixels
no_flash_img = imread('../data/cave01_01_noflash_gray.jpg');
flash_img = imread('../data/cave01_00_flash_gray.jpg');
[transformed_image] = generateTransformedImage(no_flash_img, 28.5, -760);

imwrite(transformed_image, '../data/no_flash_transformed.jpg');

joint_entropy = zeros(51, 25);
for angle = -10:40
    for t = -772:-748
        angle
        t
        %Tdash = transformationMatrix(angle, t, 0);
        [transformed_image_dash] = generateTransformedImage(flash_img, angle, t);
        joint_entropy(angle+11, t+773) = jointEntropy(transformed_image, transformed_image_dash);
    end
end

X = -772:1:-748;
Y = -10:1:40;
surf(X, Y, joint_entropy);
pause;

min_entropy = min(joint_entropy(:))
max_entropy = max(joint_entropy(:));
joint_entropy_balanced = (joint_entropy - min_entropy)/(max_entropy - min_entropy);
imshow(joint_entropy_balanced);
pause;

