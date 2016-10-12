%performanceAnalysis1

filters = [3 5 9 21 65 101];



loadedForest = load('forest');
loadedImage = im2uint8(mat2gray(loadedForest.forestgray));


method = 'Smart';
timesS = [];%10, 10, 10, 10]
for filter = filters
    tic
    %h  = waitbar(0, sprintf('Please wait... method=%s filtersize=%i', method , filter));
    h = 0;
    method
    filter
    finalImage = lochist(loadedImage, filter, 'zero', method, h);
    %close(h);
    t = toc;
    timesS = [timesS, t];
end

method = 'Blocky';
timesB = [];%10, 12, 13, 14]
for filter = filters
    tic
    %h  = waitbar(0, sprintf('Please wait... method=%s filtersize=%i', method , filter));
    h = 0;
    method
    filter
    finalImage = lochist(loadedImage, filter, 'zero', method, h);
    %close(h);
    t = toc;
    timesB = [timesB, t];
end

method = 'Naïve';
timesN = [];%100, 140, 180, 200]
for filter = filters
    tic
    %h  = waitbar(0, sprintf('Please wait... method=%s filtersize=%i', method , filter));
    h = 0;
    method
    filter
    finalImage = lochist(loadedImage, filter, 'zero', method, h);
    %close(h);
    t = toc;
    timesN = [timesN, t];
end

figure
plot(filters, timesB, 'b*-')
hold on
plot(filters, timesN, 'r*-')
plot(filters, timesS, 'g*-')
title 'Local histogram equalization execution time analysis'
ylabel 'time [s]'
xlabel 'filter size (NxN) [pixels]'
legend('Blocks', 'Unoptimized', 'Optimized')
hold off