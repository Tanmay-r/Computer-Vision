function [transformed_image] = transformeImage(image)

t = generateTransformationMatrix(0, -size(image, 1)/2, -size(image, 2)/2);

