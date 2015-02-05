function [outputImg] = warpping(Img,T)
% T is the forward Transform
invT = inv(T);
outputImg = zeros(size(Img));
r  = size(outputImg,1);
c = size(outputImg,2);
for i =1:r
    for j=1:c
        pixelInd = invT*[ i j 1]';
        pixelInd = round(pixelInd);
        if(checkBoundary(pixelInd, size(Img))==true);
            outputImg(i,j) = Img(pixelInd(1),pixelInd(2));
        end
    end
end
end

function [in] = checkBoundary(pixelInd,ImageSize)
    in = true;
    if(pixelInd(1) > ImageSize(1))
        in= false;
    elseif(pixelInd(2) > ImageSize(2))
        in =false;
    elseif(pixelInd(1) <1)
        in= false;
    elseif(pixelInd(2) <1)
        in = false;
    end
end