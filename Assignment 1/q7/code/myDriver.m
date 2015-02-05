function [Hmodel, H, H2] = myDriver()

load('Hmodel.mat')
dataImg1 = imread('../data/goi1_downsampled.jpg');

[transformed] = warpping(dataImg1, Hmodel);
transformed = transformed/255;
imwrite(transformed, '../data/goi_transformed.jpg');

[H, out] = homography('../data/goi1_downsampled.jpg', '../data/goi_transformed.jpg');
out = out/255;
imwrite(out, '../data/goi_transformed_obtained.jpg');

Hmodel
H

[H2, out2] = homography('../data/goi1_downsampled.jpg', '../data/goi2_downsampled.jpg');
out2 = out2/255;
imwrite(out2, '../data/goi2_transformed_obtained.jpg');

H2