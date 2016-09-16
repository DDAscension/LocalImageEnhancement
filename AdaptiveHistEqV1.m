%adaptive histogram equalization version 1
function B = AdaptiveHistEqV1(A, nM, nN)
    B = zeros(size(A));
    [M, N] = size(A);
    stepX = round((M-1) / nM);
    stepY = round((N-1) / nN);
    for m = 1:stepY:M-stepX
       for n = 1:stepX:N-stepY
           m2 = m + stepY;
           n2 = n + stepX;
           S = A(m:m2, n:n2);
           SEq = histeq(S);
           B(m:m2, n:n2) = SEq;
       end
    end
    