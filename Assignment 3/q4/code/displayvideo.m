function displayvideo (vid,pausetime)

T = size(vid,3);

for i=1:T
   imshow(mat2gray(vid(:,:,i)));
   pause(pausetime);
end

