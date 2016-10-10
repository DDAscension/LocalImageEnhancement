%Function that performs local histogram equalization where each histogram
%covers filter_size*filter_size pixels
function outputImage = lochist(image, filterSize, padoption, calcOpt, wBar)
    outputImage = image; %Sensible default if any error should occur
    
    %Check if input meet requirements
    if(~mod(filterSize, 2))
        error('filter_size must not be divisble by 2\n');
        return;
    else if(~isa(image, 'uint8'))
        error('image must be of type uint8');
        return;
        end

    switch calcOpt
        case 'Blocky'
            %process image in non-overlapping blocks
            [Xmax, Ymax]=size(image);
            outputImage = image;
            for x = 1:filterSize:Xmax
                for y = 1:filterSize:Ymax
                    x2 = x + filterSize-1;
                    y2 = y + filterSize-1;
                    if (x2>Xmax)
                        x2 = Xmax;
                    end
                    if (y2>Ymax)
                        y2 = Ymax;
                    end
                    subimage = image(x:x2, y:y2);
                    subimage = histeq(subimage, 256);
                    outputImage(x:x2, y:y2) = subimage;
                end
                if (wBar~=0)
                    waitbar(x/Xmax, wBar);
                end
            end
            
        case 'Naïve'
            %process in overlapping blocks
            pad = floor(filterSize/2);
            paddedImage = padarray2d(image, pad, padoption);
            outputImage = paddedImage;
            %size(image)
            [Xmax, Ymax] = size(paddedImage);
            for x = pad + 1:Xmax-pad
                for y = pad + 1:(Ymax-pad)
                    subimage = paddedImage(x-pad:x+pad, y-pad:y+pad);
                    subimage = histeq(subimage, 256);
                    outputImage(x, y) = subimage(pad+1, pad+1);
                end
                if (wBar~=0)
                    waitbar(x/Xmax, wBar);
                end
            end
            %remove pad
            outputImage = outputImage(pad+1:Xmax-pad, pad+1:Ymax-pad);
            %size(outputImage)
            
        case 'Smart'
            %For each row in original image, compute initial histogram in that row and then
            %perform local histogram equalization
            im = padarray2d(image, floor(filterSize/2), padoption);  
            rows = (size(im, 1)-filterSize + 1);
            for X=1:rows
                outputImage(X, 1:size(outputImage, 2)) = lochistrow(im, X, filterSize);
                if (wBar~=0)
                    waitbar(X/rows, wBar);
                end
            end
    end
end