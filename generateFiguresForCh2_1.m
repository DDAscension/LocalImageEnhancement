%script to generate histograms & images for chapter 2.

hitBins = 256;
load('forest');
imageOrg = mat2gray(forestgray);
[histOrg, x] = imhist(imageOrg,hitBins);

imageDark = imread('ch2_1_hist_Dark.png');
[histDark, x] = imhist(imageDark,hitBins);

imageBright = imread('ch2_1_hist_bright.png');
[histBright, x] = imhist(imageBright,hitBins);

imageDull = imread('ch2_1_hist_Dull.png');
[histDull, x] = imhist(imageDull,hitBins);

close all

figure
subplot(1,3,1);
imshow(imageOrg, []);
title 'Original image'
subplot(1,3,2);
bar(histOrg)
title 'Image histogram'
subplot(1,3,3);
bar(histOrg / sum(histOrg))
title 'Normalized histogram'





figure
subplot(4,2,1);
imshow(imageOrg, []);
title 'Original image'
subplot(4,2,2);
bar(histOrg / sum(histOrg))
title 'Normalized histogram'

subplot(4,2,3)
imshow(imageDark, [])
title 'Dark image'
subplot(4,2,4);
bar(histDark / sum(histDark))
title 'Normalized histogram'

subplot(4,2,5)
imshow(imageBright, [])
title 'Bright image'
subplot(4,2,6);
bar(histBright / sum(histBright))
title 'Normalized histogram'

subplot(4,2,7)
imshow(imageDull, [])
title 'Grayish image'
subplot(4,2,8);
bar(histDull / sum(histDull))
title 'Normalized histogram'