%Statistical histogram equalization
function dummy = calculateSHE(E, k0, k1, k2, surroundingSize, fig, forestgray, padoption)

%anonymous function for mean caluclation, possibly replace by matlab native
imgMean = @(img) sum(sum(img))/(size(img,1)*size(img,2));
%anonymous function for standard deviation caluclation, possibly replace by matlab native
imgVar = @(img) sum(sum((img - imgMean(img)).^2))/(size(img,1)*size(img,2));

globalMean = imgMean(forestgray);
globalVar = imgVar(forestgray);
[M, N] = size(forestgray);
padSize = floor(surroundingSize/2);

paddedImage = padarray2d(forestgray, padSize, padoption);

xs = 1 + padSize;
xf = M + padSize;
ys = 1 + padSize;
yf = N + padSize;

conditionalMatrix = forestgray * 0 + 1;
conditionalMatrixMean = forestgray * 0;
conditionalMatrixVar = forestgray * 0;

for x = xs:xf
   for y = ys:yf 
       surrounding = paddedImage(x-padSize:x+padSize, y-padSize:y+padSize);
       surroundingMean = imgMean(surrounding);
       surroundingVar = imgVar(surrounding);
       
       meancond = surroundingMean <= k0 * globalMean;
       varcond = (k1*globalVar <=surroundingVar) && (k2*globalVar >=surroundingVar);
       if (meancond && varcond)
           conditionalMatrix(x-padSize, y-padSize) = E;
       end
       if (meancond)
           conditionalMatrixMean(x-padSize, y-padSize) = 1;
       end
       if (varcond)
           conditionalMatrixVar(x-padSize, y-padSize) = 1;
       end
   end
end

%Ensure that amplification of eligible pixels don't exceed max value of
%original image, such that other parts become darkened by matlab
finalImage = forestgray .* conditionalMatrix;
maxGray = max(max(forestgray));
finalImage(finalImage >= maxGray) = maxGray;


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

dummy = 3.14;