function [H,out] = homography(img1,img2)
%% img1 and img2 are paths to the images.

DataImg1 =  imread(img1);
DataImg2 = imread(img2);
[num matchedPoints] = match(img1,img2);
matrixA = zeros(2*num , 9);
matrixA(1:2:end,1:2) = - matchedPoints(:,1:2);
matrixA(1:2:end,3) = -1*ones(size(matrixA(1:2:end,3)));
matrixA(1:2:end,7) = matchedPoints(:,3).*matchedPoints(:,1);
matrixA(1:2:end,8) = matchedPoints(:,3).*matchedPoints(:,2);
matrixA(1:2:end,9) = matchedPoints(:,3);

matrixA(2:2:end,4:5) = - matchedPoints(:,1:2);
matrixA(2:2:end,6) = -1*ones(size(matrixA(1:2:end,3)));
matrixA(2:2:end,7) = matchedPoints(:,4).*matchedPoints(:,1);
matrixA(2:2:end,8) = matchedPoints(:,4).*matchedPoints(:,2);
matrixA(2:2:end,9) = matchedPoints(:,4);

[U S V] = svd(matrixA);
c=reshape(V(:,end)',1,9);
H=reshape(c,3,3)';
H = H/H(end, end);
out =  warpping(DataImg1,H);
end