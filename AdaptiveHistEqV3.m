%adaptive histogram equalization version 3 (with zero padding) & filter odd
%size check
function B = AdaptiveHistEqV3(A, Wm, Wn)
    if (mod(Wm,2)==0)
        error 'Wm must be odd'
    end
    if (mod(Wn,2)==0)
        error 'Wn must be odd'
    end
    Apadded = padarray(A, [floor(Wm/2), floor(Wn/2)]);
    B = Apadded;