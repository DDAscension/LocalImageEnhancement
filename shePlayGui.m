 function myui
    clear;
    clc;
    % Create a figure and axes
    f = figure('Visible','off');

    labE = uicontrol('Style', 'text', 'String','Multiplicative value E [0 - 50]', 'Position', [180*0 40 140 20]);
    sldE = uicontrol('Style', 'slider', 'Min',0,'Max',50,'Value',4,'Position', [180*0 20 120 20], 'Callback', @surfzlim); 
	
    labk0 = uicontrol('Style', 'text', 'String', 'Mean coeff. k0 [0 - 10]', 'Position', [180*1 - 15 40 150 20]);
    sldk0 = uicontrol('Style', 'slider', 'Min',0,'Max',10,'Value',0.4, 'Position', [180*1 20 120 20], 'Callback', @surfzlim); 
    
    labk1 = uicontrol('Style', 'text', 'String', 'Lower limit local standard dev. k1 (1 - 10)', 'Position', [180*2 - 60 40 240 20]);
    sldk1 = uicontrol('Style', 'slider', 'Min',0,'Max',10,'Value',0.02, 'Position', [180*2 20 120 20], 'Callback', @surfzlim);     
    
    labk2 = uicontrol('Style', 'text', 'String', 'Standard dev. coeff. k2 (1 - 10)', 'Position', [180*3 40 160 20]);
    sldk2 = uicontrol('Style', 'slider', 'Min',0,'Max',10,'Value',0.4, 'Position', [180*3 20 120 20], 'Callback', @surfzlim);         
    
    f.Visible = 'on';

    loadedForest = load('forest');
    forestgray = loadedForest.forestgray;
    calculateSHE( sldE.Value, sldk0.Value, sldk1.Value, sldk2.Value, 3, f, forestgray); 

    function surfzlim(source,event)
        calculateSHE( sldE.Value, sldk0.Value, sldk1.Value, sldk2.Value, 3, f, forestgray); 
    end
 end