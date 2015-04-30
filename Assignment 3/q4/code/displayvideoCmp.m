function displayvideoCmp (vid,vid2,pausetime)

T = size(vid,3);

for i=1:T
   subplot(1,2,1)
   imshow(mat2gray(vid(:,:,i)));
   subplot(1,2,2)
   imshow(mat2gray(vid2(:,:,i)));
   pause(pausetime);
end

