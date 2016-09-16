%lie play
clear all
close all
[A, B, C]= generateDifficult(255,255,1);
subplot(3,3,1)
imshow(A)
title 'A: Low contrast detail'
subplot(3,3,2)
imshow(B)
title 'B: Background gradient'
subplot(3,3,3)
imshow(C)
title 'C: A + B'
%enhance defect
A1 = histeq(A, 255);
subplot(3,3,4)
imshow(A1)
title 'D: A after Hist.Eq.'
%equalize histogram naïve way
C1 = histeq(C, 255);
subplot(3,3,5)
imshow(C1)
title 'E: C after Hist.Eq.'
%version 1 - adaptive histogram smarter but still naïve way
C2 = AdaptiveHistEqV1(C, 81,81);
subplot(3,3,6)
imshow(C2)
title 'F: C after adaptive Hist eq 1'

%version2 - adaptive histogram equalization - sliding mean value
C3 = AdaptiveHistEqV2(C, 16, 16); 
subplot(3,3,7)
imshow(C3)
title 'G: C after adaptive Hist Eq 2'
