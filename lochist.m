function new_image = lochist(image, filter_size)
    if(~mod(filter_size, 2))
        error('filter_size must not be divisble by 2\n');
        new_image = image;
        return;
    end
    %todo: check that image is of class uint8
    new_image = zeros(size(image));
    colors = 0:255;%min(min(image)):max(max(image));
    im = padarray(image, [floor(filter_size/2) floor(filter_size/2)]);
    [height, width] = size(im);
    
    %For each row in original image
    for X=1:(height-filter_size+1)
        Xend = filter_size+X-1; 
        ims = im(X:Xend, 1:filter_size);
        
        imshc = histcounts(ims, colors);
        

        %Then compute delta column-vector histograms in order to efficiently
        %compute the next histogram (dont need to recompute histogram in its
        %entirety each time it is slided across the image!)
        
        for Y=1:(width-filter_size) %  swipe along y (horizontal, matlab..)
            ims_to_add = im(X:Xend, Y+filter_size);
            ims_to_remove = im(X:Xend, Y);
            imshc_to_add = histcounts(ims_to_add, colors);
            imshc_to_remove = histcounts(ims_to_remove, colors);
            imshc = imshc - imshc_to_remove + imshc_to_add;
            pixelLevel = im(X + floor(filter_size/2), Y + floor(filter_size/2));
            new_image(X, Y) = 255 * sum(imshc(1:pixelLevel))/(filter_size^2);
        end
    end
end