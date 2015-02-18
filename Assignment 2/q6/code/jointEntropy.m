function [joint_entropy] = jointEntropy(image1, image2)

%Compute probability
probability = zeros(26, 26);
for i = 1:size(image1, 1)
    for j = 1:size(image1, 2)
        probability(floor(double(image1(i, j))/10.0) + 1, floor(double(image2(i, j))/10.0) + 1) = probability(floor(double(image1(i, j))/10.0) + 1, floor(double(image2(i, j))/10.0) + 1) + 1;
    end
end

probability = probability/(size(image1, 1)*size(image2, 1));
joint_entropy = 0;
for i = 1:26
    for j = 1:26
        if(probability(i,j) ~= 0)
            joint_entropy = joint_entropy - probability(i, j)*log2(probability(i, j));
        end
    end
end