 function myui
    % Create a figure and axes
    f = figure('Visible','off');

    sldE = uicontrol('Style', 'slider', 'Min',0,'Max',50,'Value',4,'Position', [000 20 120 20], 'Callback', @surfzlim); 
					
   
    sldk0 = uicontrol('Style', 'slider', 'Min',0,'Max',10,'Value',0.4, 'Position', [140 20 120 20], 'Callback', @surfzlim); 
    
    sldk1 = uicontrol('Style', 'slider', 'Min',0,'Max',10,'Value',0.02, 'Position', [280 20 120 20], 'Callback', @surfzlim);     
    
    sldk2 = uicontrol('Style', 'slider', 'Min',0,'Max',10,'Value',0.4, 'Position', [420 20 120 20], 'Callback', @surfzlim);         
    
    f.Visible = 'on';

    


    function surfzlim(source,event)
        
        sldE.Value;
    end
end