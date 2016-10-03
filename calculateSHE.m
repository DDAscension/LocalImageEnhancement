%
function dummy = calculateSHE(E, k0, k1, k2, surroundingSize, fig, forestgray)

%Statistical histogram equalization

%anonymous function for mean caluclation, possibly replace by matlab native
imgMean = @(img) sum(sum(img))/(size(img,1)*size(img,2));
%anonymous function for standard deviation caluclation, possibly replace by matlab native
imgVar = @(img) sum(sum((img - imgMean(img)).^2))/(size(img,1)*size(img,2));


%load('forest.mat')
forestgray = double(forestgray);

globalMean = imgMean(forestgray);
globalVar = imgVar(forestgray);

[M, N] = size(forestgray);

%surroundingSize = 3;
padSize = floor(surroundingSize/2);

paddedImage = padarray2d(forestgray, padSize);

xs = 1 + padSize;
xf = M + padSize;
ys = 1 + padSize;
yf = N + padSize;

conditionalMatrix = forestgray * 0 + 1;
conditionalMatrixMean = forestgray * 0 + 1; %Each cell should equal E where mean condition is satisfied
conditionalMatrixVar = forestgray * 0 + 1; %Each cell should equal E where variance condition is satisfied

debugMatrix = conditionalMatrix * 0;

%conditions
%E = 8.0;
%k0 = 10000;%0.4;
%k1 = 0;%0.02;
%k2 = 0.4;

for x = xs:xf
   for y = ys:yf 
       surrounding = paddedImage(x-padSize:x+padSize, y-padSize:y+padSize);
       surroundingMean = imgMean(surrounding);
       surroundingVar = imgVar(surrounding);
       
       meancond = surroundingMean <= k0 * globalMean;
       varcond = (k1*globalVar <=surroundingVar) && (k2*globalVar >=surroundingVar);
       if (meancond && varcond)
           conditionalMatrix(x-padSize, y-padSize) = E;
           debugMatrix(x-padSize, y-padSize) = 1;
       end
       if (meancond)
           conditionalMatrixMean(x-padSize, y-padSize) = E;
       end
       if (varcond)
           conditionalMatrixVar(x-padSize, y-padSize) = E;
       end
   end
end

finalImage = forestgray .* conditionalMatrix;

hold on;
subplot(2,2,1)
imshow(forestgray, [])
title('Original image')

subplot(2,2,2)
imshow(finalImage, [])
title('Final image')

subplot(2,2,3)
imshow(conditionalMatrixMean, [])
title('Only considering mean condition')

subplot(2,2,4)
imshow(conditionalMatrixVar, [])
title('Only considering variance condition')
hold off;


%subplot(2,2,3)
%imshow(debugMatrix, [])

dummy = 3.14;