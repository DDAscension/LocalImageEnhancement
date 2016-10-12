%artificial images enhancement

img1a = imread('defect3.tif');
img2a = imread('hiddenCode.tif');

img1b = lochist(img1a, 3, 'zero', 'smart', 0);
img2b = lochist(img2a, 3, 'zero', 'smart', 0);


figure
subplot(2,2,1)
imshow(img1a,[])
subplot(2,2,2)
imshow(img1b)
subplot(2,2,3)
imshow(img2a,[])
subplot(2,2,4)
imshow(img2b)
