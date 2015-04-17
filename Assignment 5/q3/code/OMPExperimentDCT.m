cd% Extract all overlapping patches of size 8 × 8 from the barbara image
img  = imread('../data/barbara256.png');
img = double(img)/255;
x = size(img, 1);
y = size(img, 2);
numPatches = (x - 7)*(y - 7);
patches = zeros(numPatches, 64);
iter = 1;
'Extracting patches...'
for i=1:x-7
    for j=1:y-7
        patch(:,:) = img(i:i+7, j:j+7);
        patches(iter, :) = patch(:);
        iter = iter + 1;
    end
end

% Generate a n × n matrix Φ
n = 64;
phi = kron(dctmtx(8)', dctmtx(8)')';
 
f = [0.9, 0.8, 0.7, 0.6, 0.5, 0.4, 0.3, 0.2, 0.1, 0.05];
MSIE = zeros(size(f,2), 1);
MSPE = zeros(size(f,2), 1);

% Generate compressive measurements for each patch
for f_val=1:size(f,2)
    m = ceil(f(f_val)*n);
    phi_random = phi(randperm(size(phi,1)),:);
    phi_m = phi_random(1:m,:);
    y = zeros(numPatches, m);
    'Generating compressive measurements...'
    for i=1:numPatches
        noiseStdDev = 0.05* meanabs(patches(i, :));
        noise = noiseStdDev*randn(m, 1);
        y(i, :) = phi_m*patches(i, :)' + noise;    
    end

    % Use OMP to recover patches
    'Recovering Patches...'
    patchesRecovered = zeros(numPatches, 64);
    for i=1:numPatches
        i
        [theta] = OMP(y(i, :), phi_m, m);
        patchesRecovered(i, :) = theta;    
    end

    % Reconstruct Image
    'Reconstructing Image...'
    imgReconstructed = reconstructImage(size(img, 1), size(img, 2), patchesRecovered);
    imwrite(imgReconstructed, strcat('../data/reconstructed_DCT', int2str(f(f_val)*100), '.jpg'));
    MSIE(f_val) = norm(img - imgReconstructed)^2;
    sqErr = zeros(numPatches, 1);
    for i=1:numPatches
        sqErr = norm(patches(i, :)- patchesRecovered(i, :))^2;
    end
    MSPE(f_val) = mean(sqErr);
end
