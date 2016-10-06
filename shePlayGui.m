 function sheUI
    clear;
    clc;
    % Create a figure and axes
    f = figure('Visible','off');

    padoptionDropdown = uicontrol('Style', 'popup', 'String', {'zero','circular','replicate','symmetric'}, 'Position', [90 40 50 0], 'Callback', @sheCallback); 
    
    labFilterSize = uicontrol('Style', 'text', 'String','Filter size, odd numbers in range [1 50]', 'Position', [180*1-30 40 200 20]);
    sldFilterSize = uicontrol('Style', 'slider', 'Min',1,'Max',25,'Value',4,'Position', [180*1 20 140 20], 'Callback', @sheCallback);
    
    labE = uicontrol('Style', 'text', 'String','Multiplicative value E [0 - 20]', 'Position', [180*2 40 140 20]);
    sldE = uicontrol('Style', 'slider', 'Min',1,'Max',20,'Value',4,'Position', [180*2 20 120 20], 'Callback', @sheCallback); 
	
    labk0 = uicontrol('Style', 'text', 'String', 'Mean coeff. k0 [0 - 10]', 'Position', [180*3 - 15 40 150 20]);
    sldk0 = uicontrol('Style', 'slider', 'Min',0,'Max',10,'Value',0.4, 'Position', [180*3 20 120 20], 'Callback', @sheCallback); 
    
    labk1 = uicontrol('Style', 'text', 'String', 'Lower limit local standard dev. k1 (0 - 1)', 'Position', [180*4 - 60 40 240 20]);
    sldk1 = uicontrol('Style', 'slider', 'Min',0,'Max',1,'Value',0.02, 'Position', [180*4 20 120 20], 'Callback', @sheCallback);     
    
    labk2 = uicontrol('Style', 'text', 'String', 'Standard dev. coeff. k2 (0 - 1)', 'Position', [180*5 40 160 20]);
    sldk2 = uicontrol('Style', 'slider', 'Min',0,'Max',1,'Value',0.4, 'Position', [180*5 20 120 20], 'Callback', @sheCallback);
    
    f.Visible = 'on';

    loadedForest = load('forest');
    rawFilterSize = sldFilterSize.Value;
    correctFilterSize = 2*floor(sldFilterSize.Value)-1;
    forestgray = mat2gray(loadedForest.forestgray);
    
    allItems = get(padoptionDropdown,'string');
    selectedIndex = get(padoptionDropdown,'Value');
    selectedItem = allItems{selectedIndex};
    calculateSHE( sldE.Value, sldk0.Value, sldk1.Value, sldk2.Value, correctFilterSize, f, forestgray, selectedItem); 

    function sheCallback(source,event)
        rawFilterSize = sldFilterSize.Value;
        correctFilterSize = 2*floor(sldFilterSize.Value)-1;
        
        allItems = get(padoptionDropdown,'string');
        selectedIndex = get(padoptionDropdown,'Value');
        selectedItem = allItems{selectedIndex};
        calculateSHE( sldE.Value, sldk0.Value, sldk1.Value, sldk2.Value, correctFilterSize, f, forestgray, selectedItem); 
    end
 end