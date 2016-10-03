%Replicate-pad a 2d matrix with a frame of thickness #padsize pixels
function paddedImage = padarray2d(image, padsize, padoption)
    if(strcmp(padoption, 'zero'))
        paddedImage = padarray(image, [padsize padsize]);
    else 
        paddedImage = padarray(image, [padsize padsize], padoption);
    end
    
