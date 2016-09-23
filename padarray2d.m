%Replicate-pad a 2d matrix with a frame of thickness #padsize pixels
function paddedImage = padarray2d(image, padsize)
    paddedImage = padarray(image, [padsize padsize]);
    
