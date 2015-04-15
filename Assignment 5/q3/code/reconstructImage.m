function [reconstruct] = reconstructImage(x, y, patchesRecovered)
iter = 1;
imgReconstruct = zeros(x, y);
numPoints = zeros(x, y);
for i=1:x-7
    for j=1:y-7
        for k=0:7
            for l=0:7
                imgReconstruct(i+k, j+l) = imgReconstruct(i+k, j+l) + patchesRecovered(iter, k +8*l+1);
                numPoints(i+k, j+l) = numPoints(i+k, j+l) + 1;
            end
        end
        iter = iter + 1;
    end
end
reconstruct = imgReconstruct./numPoints;