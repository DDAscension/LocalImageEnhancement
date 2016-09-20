%lieplayJ
clear;
clc;
load('forest.mat');

subplot(3,3,1)
imshow(forestgray, []);

forest1 = lochist(im2uint8(mat2gray(forestgray)), 3);
subplot(3,3,2)
imshow(forest1, []);

forest3 = lochist(im2uint8(mat2gray(forestgray)), 71);
subplot(3,3,3)
imshow(forest3, []);

forest3 = lochist(im2uint8(mat2gray(forestgray)), 301);
subplot(3,3,4)
imshow(forest3, []);

forest3 = histeq(im2uint8(mat2gray(forestgray)));
subplot(3,3,5)
imshow(forest3, []);
