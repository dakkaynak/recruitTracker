function rT_saveCoralData(folderName,fileNames,imgName,stats,pixToCM,resizeFactor,s,keepMask,rejectMask,addedMask,I)

% The user input has finished. Save a spreadsheet with stats.
rT_writeSpreadsheet(folderName,fileNames, imgName,stats,pixToCM,resizeFactor,s);
% Save some images to make it easy for user to visually check.
rT_writeImage(folderName,imgName, I,keepMask, rejectMask,addedMask,stats,resizeFactor,pixToCM)
% save the .MAT files containing the relevant information
rT_saveMATfiles(folderName,imgName,keepMask,rejectMask,addedMask,stats,resizeFactor,pixToCM);

% Write a confirmation message
display(['Succesfully saved files for image ',imgName,'.'])