function [keepMask,rejectMask,addedMask,stats,closeFlag,skipFlag] = rT_coralGUI(I,Ioriginal,stats,coralImage,pixToCM,imgName,resizeFactor)

% This is the size of the resized image
s = size(I);
textSize = round(max(s(1),s(2))./30);

% The user can choose to display various layers of information in the
% image. I have made them modular so they can be turned on or off.

% display the image and overlay fileName on top left
Idisplay_withName = insertText(I,[ceil(0.001*s(2)), 0.001*s(1)],imgName,'Fontsize',textSize);
% display the image and overlay the scalebar
scaleImg = rT_placeScaleBar(I,pixToCM,resizeFactor,textSize);
Idisplay_withScale = Idisplay_withName + uint8(255*scaleImg);

fig = figure;
fig.Units = 'normalized';
fig.OuterPosition = [0 0 1 1];
h_im = imshow(Idisplay_withScale);

children = fig.Children;
pos = children.Position;
p = uipanel('Position',[pos(1) pos(2) 0.08 pos(4)]);
hold on

pKeep = uicontrol(p,'Style', 'pushbutton', 'String', 'KEEP','units','normalized',...
    'Position', [0.1 0.9 0.7 0.05], 'Callback', @rT_keepCallback);

pReject = uicontrol(p,'Style', 'pushbutton', 'String', 'REJECT','units','normalized',...
    'Position', [0.1 0.8 0.7 0.05], 'Callback', @rT_rejectCallback);

pEdit = uicontrol(p,'Style', 'pushbutton', 'String', 'EDIT BOUNDARY','units','normalized',...
    'Position', [0.1 0.7 0.7 0.05], 'Callback', @rT_editCallback);

% This button starts out INACTIVE, and becomes ACTIVE only when the
% automatically found blobs are cycled through
pDraw = uicontrol(p,'Style', 'pushbutton', 'String', 'DRAW','units','normalized',...
    'Position', [0.1 0.6 0.7 0.05], 'Callback', @rT_drawCallback,'enable','off');

% This button starts out INACTIVE, and becomes ACTIVE only when the
% automatically found blobs are cycled through

pNext = uicontrol(p,'Style', 'pushbutton', 'String', 'SAVE & NEXT','units','normalized',...
    'Position',[0.1 0.5 0.7 0.05] , 'Callback', @rT_nextCallback,'enable','off');


pSkip = uicontrol(p,'Style', 'pushbutton', 'String', 'SKIP IMAGE','units','normalized',...
    'Position', [0.1 0.4 0.7 0.05], 'Callback', @rT_skipCallback);

pClose = uicontrol(p,'Style', 'pushbutton', 'String', 'SAVE & QUIT','units','normalized',...
    'Position',[0.1 0.3 0.7 0.05] , 'Callback', @rT_closeCallback);

pAutoOff = uicontrol(p,'Style', 'pushbutton', 'String', 'Auto OFF','units','normalized',...
    'Position',[0.1 0.2 0.7 0.05] , 'Callback', @rT_autoOffCallback);

[keepMask,rejectMask,addedMask,stats,closeFlag,skipFlag] = rT_processCoralMask(stats,coralImage,pKeep,pReject,...
    pDraw,pClose,pSkip,pEdit,pAutoOff,Idisplay_withScale,pNext,h_im,Ioriginal,resizeFactor);

close all;