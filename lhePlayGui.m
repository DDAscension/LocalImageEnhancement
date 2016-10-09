 function lheUI
    clear;
    clc;
    % Create a figure and axes
    f = figure('Visible','off');
    message='Filter size, odd numbers in range [1 499]; current value:';
    labFilterSize = uicontrol('Style', 'text', 'String', sprintf('%s %i', message, 4), 'Position', [150 40 300 20]);
    sldFilterSize = uicontrol('Style', 'slider', 'Min',1,'Max',250,'Value',4, 'Sliderstep', [1/249,10/249],  'Position', [150 20 300 20], 'Callback', @lheCallback);
    padoptionDropdown = uicontrol('Style', 'popup', 'String', {'zero','circular','replicate','symmetric'}, 'Position', [60 40 50 0], 'Callback', @lheCallback); 
    uicontrol('Style', 'pushbutton', 'String', 'Calculate',...
        'Position', [460 20 100 40],...
        'Callback', @calculate);    
    timeSummary = uicontrol('Style', 'text', 'String', 'Time elapsed: ', 'Position', [570, 20, 100, 40]);
    loadedForest = load('forest');
    forestgray = im2uint8(mat2gray(loadedForest.forestgray));
    hold on;
    subplot(1,3,1)
    imshow(forestgray, [])
    title('Original image')
    subplot(1,3,3)
    imshow(histeq(forestgray, 256), []); %Matlab tricks us and default #outputColors = 64 unless explicitly specified!
    title('Globally enhanced image');
    hold off;    
    f.Visible = 'on';
    
    function calculate(source, evt)
        correctFilterSize = 2*floor(sldFilterSize.Value)-1;
        allItems = get(padoptionDropdown,'string');
        selectedIndex = get(padoptionDropdown,'Value');
        selectedItem = allItems{selectedIndex};
        tic
        finalImage = lochist(forestgray, correctFilterSize, selectedItem);
        subplot(1,3,2)
        imshow(finalImage, [])
        title('Locally enhanced image')
        t = toc;
        set(timeSummary, 'String', sprintf('Time elapsed %.2f s', t));
    end
 
    function lheCallback(source,event)
        correctFilterSize = 2*floor(sldFilterSize.Value)-1;
        set(labFilterSize, 'String', sprintf('%s %i', message, correctFilterSize));
    end
 end