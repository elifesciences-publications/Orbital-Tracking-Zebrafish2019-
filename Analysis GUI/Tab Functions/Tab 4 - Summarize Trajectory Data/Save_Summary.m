function Save_Summary(~,~)
%% Initialize Global Variables
%Figure Variable
global MainFig;
%Variables to save data
global M_File;
%Variable for Summary
global Summary

%% Save File
%Select File
[fileName,filePath] = uiputfile('*.mat','Save Summary File');
if filePath==0, error('None selected!'); end
Path=fullfile(filePath,fileName);
save(Path,'Summary');
1



