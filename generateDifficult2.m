function img = generateDifficult2()
    X = 255;
    Y = 255;
    img = uint8(255*ones([X,Y]));
    img(1:round(X/3), 1:round(Y/3)) = 0;
    img(2*round(X/3):X, 1:round(Y/3)) = 0;
    img(1:round(X/3), 2*round(Y/3):Y) = 0;
    img(2*round(X/3):X, 2*round(Y/3):Y) = 0;
    positions = [0, 0; 2*round(X/3), 1; 1,2*round(Y/3);  2*round(X/3),2*round(Y/3)];
    text = 'RRY025';
    level = 2;
    img = rgb2gray(insertText(img,positions,text,'AnchorPoint','LeftTop',...
        'BoxColor', [0,0,0], 'TextColor', [level, level, level],...
        'FontSize', 18));
    figure
    imshow(img);
    imwrite(img, 'hiddenCode.tif');
end
