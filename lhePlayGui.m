 function lheUI
    clear;
    clc;
    % Create a figure and axes
    f = figure('Visible','off');

    labFilterSize = uicontrol('Style', 'text', 'String','Filter size, odd numbers in range [1 500]', 'Position', [150 40 200 20]);
    sldFilterSize = uicontrol('Style', 'slider', 'Min',1,'Max',250,'Value',4,'Position', [150 20 400 20], 'Callback', @lheCallback);
    padoptionDropdown = uicontrol('Style', 'popup', 'String', {'zero','circular','replicate','symmetric'}, 'Position', [60 40 50 0], 'Callback', @lheCallback); 
    
    f.Visible = 'on';

    loadedForest = load('forest');
    rawFilterSize = sldFilterSize.Value;
    correctFilterSize = 2*floor(sldFilterSize.Value)-1;
    forestgray = im2uint8(mat2gray(loadedForest.forestgray));
    calculateLHE(correctFilterSize, forestgray, 'zero'); 

    function lheCallback(source,event)
        rawFilterSize = sldFilterSize.Value;
        correctFilterSize = 2*floor(sldFilterSize.Value)-1;
        
        allItems = get(padoptionDropdown,'string');
        selectedIndex = get(padoptionDropdown,'Value');
        selectedItem = allItems{selectedIndex};
        calculateLHE(correctFilterSize, forestgray, selectedItem); 
    end
 end