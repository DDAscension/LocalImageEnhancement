%Given an image, row of image and pixel size of local histogram region
%Perform local histogram equalization of all pixels in row X, on each pixel
%resuing computations of histograms from previous pixel for speedup
function equalizedRow = lochistrow(im, X, filter_size)
    colors = 0:255;
    Xend = filter_size+X-1;
    width = size(im, 2);
    hc = histcounts(im(X:Xend, 1:filter_size), colors);
    
    %Compute equalized pixel at first pixel of row (special case where
    %full histogram must be computed
    pixelLevel = im(floor(filter_size/2)+1, floor(filter_size/2)+1);
    equalizedRow(1) = histtrans(hc, pixelLevel, filter_size^2);
    
    for Y=1:(width-filter_size)
        hc_to_add = histcounts(im(X:Xend, Y+filter_size), colors);
        hc_to_remove = histcounts(im(X:Xend, Y), colors);
        hc = hc - hc_to_remove + hc_to_add;
        pixelLevel = im(X + floor(filter_size/2), Y + floor(filter_size/2));
        equalizedRow(Y+1) = histtrans(hc, pixelLevel, filter_size^2);
    end
end