%Statistical histogram equalization

%anonymous function for mean caluclation, possibly replace by matlab native
imgMean = @(img) sum(sum(img))/(size(img,1)*size(img,2));
%anonymous function for standard deviation caluclation, possibly replace by matlab native
imgVar = @(img) sum(sum((img - imgMean(img)).^2))/(size(img,1)*size(img,2));


load('forest.mat')
forestgray = double(forestgray);

globalMean = imgMean(forestgray);
globalVar = imgVar(forestgray);

[M, N] = size(forestgray);

surroundingSize = 3;
padSize = floor(surroundingSize/2);

paddedImage = padarray2d(forestgray, padSize);

xs = 1 + padSize;
xf = M + padSize;
ys = 1 + padSize;
yf = N + padSize;

conditionalMatrix = forestgray * 0 + 1;

debugMatrix = conditionalMatrix * 0;

%conditions
E = 8.0;
k0 = 10000;%0.4;
k1 = 0;%0.02;
k2 = 0.4;

for x = xs:xf
   for y = ys:yf 
       surrounding = paddedImage(x-padSize:x+padSize, y-padSize:y+padSize);
       surroundingMean = imgMean(surrounding);
       surroundingVar = imgVar(surrounding);   
       if ((surroundingMean <= k0 * globalMean) && (k1*globalVar <=surroundingVar) && (k2*globalVar >=surroundingVar))
           conditionalMatrix(x-padSize, y-padSize) = E;
           debugMatrix(x-padSize, y-padSize) = 1;
       end
   end
end

finalImage = forestgray .* conditionalMatrix;

subplot(2,2,1)
imshow(forestgray, [])

subplot(2,2,2)
imshow(finalImage, [])

subplot(2,2,3)
imshow(debugMatrix, [])

