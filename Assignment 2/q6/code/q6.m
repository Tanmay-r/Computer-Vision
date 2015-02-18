function [joint_entropy] = q6(angle, t)

no_flash_img = imread('../data/cave01_01_noflash_gray.jpg');
flash_img = imread('../data/cave01_00_flash_gray.jpg');
[transformed_image] = generateTransformedImage(no_flash_img, angle, t);

joint_entropy = zeros(121, 25);
for angle = -60:60
    for t = -12:12
        angle
        t
        %Tdash = transformationMatrix(angle, t, 0);
        [transformed_image_dash] = generateTransformedImage(flash_img, angle, t);
        joint_entropy(angle+61, t+13) = jointEntropy(transformed_image, transformed_image_dash);
    end
end

X = -12:1:12;
Y = -60:1:60;
surf(X, Y, joint_entropy);
pause;

min_entropy = min(joint_entropy(:))
max_entropy = max(joint_entropy(:));
joint_entropy_balanced = (joint_entropy - min_entropy)/(max_entropy - min_entropy);
imshow(joint_entropy_balanced);
pause;