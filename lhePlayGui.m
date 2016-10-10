 function lheUI(varargin)
   
    f = figure('Visible','off');
    message='Filter size, odd numbers in range [1 499]; current value:';
    
    methodOption = uicontrol('Style', 'popup', 'String', {'Blocky','Naïve','Smart'},...
    'Position', [60 80 50 0]); 
    
    padoptionDropdown = uicontrol('Style', 'popup', 'String', {'zero','circular','replicate','symmetric'},...
    'Position', [60 40 50 0], 'Callback', @lheCallback); 
    
    sldFilterSize = uicontrol('Style', 'slider', 'Min',1,'Max',250,'Value', 21, 'Sliderstep', [1/249,10/249],...
        'Position', [150 20 300 20], 'Callback', @lheCallback);

    uicontrol('Style', 'pushbutton', 'String', 'Calculate',...
        'Position', [460 20 100 40],...
        'Callback', @calculate);    
    
    timeSummary = uicontrol('Style', 'text', 'String', 'Time elapsed: ',...
        'Position', [570, 20, 100, 40]);
 
    labFilterSize = uicontrol('Style', 'text', 'String', sprintf('%s %i', message, 21),...
        'Position', [150 40 300 20]);    
    
    
   
    if (nargin==0) 
        loadedForest = load('forest');
        loadedImage = im2uint8(mat2gray(loadedForest.forestgray));
    else
        
        loadedImage = im2uint8(imread(varargin{1}));
    end
    
    
    hold on;
    subplot(1,3,1)
    imshow(loadedImage, [])
    title('Original image')
    subplot(1,3,3)
    imshow(histeq(loadedImage, 256), []); %Matlab tricks us and default #outputColors = 64 unless explicitly specified!
    title('Globally enhanced image');
    hold off;    
    f.Visible = 'on';
    
    function calculate(source, evt)
        correctFilterSize = 2*floor(sldFilterSize.Value)-1;
        %get pad option
        allItems = get(padoptionDropdown,'string');
        selectedIndex = get(padoptionDropdown,'Value');
        selectedItem = allItems{selectedIndex};
        %get calculation option
        allItems = get(methodOption,'string');
        selectedIndex = get(methodOption,'Value');
        calcOpt = allItems{selectedIndex};
        tic
        h = waitbar(0, 'Please wait...');
        finalImage = lochist(loadedImage, correctFilterSize, selectedItem, calcOpt, h);
        close(h);
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