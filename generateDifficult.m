%generate difficult image
function [B, GR, C] = generateDifficult(m,n, defectLevel)
    A = uint8(zeros(m,n));
    A(round(m/4):round(3*m/4),round(n/4):round(3*n/4)) = defectLevel;
    B = mat2gray(A, [0,255]);
    [X, Y] = meshgrid(1:m, 1:n);
    G = X .* Y;
    GR = G / max(max(G));
    C = GR + B;
    