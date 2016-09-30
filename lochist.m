%Function that performs local histogram equalization where each histogram
%covers filter_size*filter_size pixels
function new_image = lochist(image, filter_size)
    new_image = image; %Sensible default if any error should occur
    
    %Check if input meet requirements
    if(~mod(filter_size, 2))
        error('filter_size must not be divisble by 2\n');
        return;
    else if(~isa(image, 'uint8'))
        error('image must be of type uint8');
        return;
    end

    im = padarray2d(image, floor(filter_size/2));    
    
    %For each row in original image, compute initial histogram in that row and then
    %perform local histogram equalization
    for X=1:(size(im, 1)-filter_size + 1)
        new_image(X, 1:size(new_image, 2)) = lochistrow(im, X, filter_size);
    end
end