%adaptive histogram equalization version 2
function B = AdaptiveHistEqV2(A, Wm, Wn)
    B = A;
    [M, N] = size(A);
    for m = 1:M - Wm
        for n = 1:N - Wn
            subimageEq = histeq(A(m:m+Wm, n:n+Wn));
            B(m+Wm/2, n+Wn/2) = subimageEq(Wm/2, Wn/2);
        end
    end
    
    