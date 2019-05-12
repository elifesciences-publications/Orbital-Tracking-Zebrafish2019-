function Save_m_File(~,~)
%SAVE_MFILE Summary of this function goes here
%   Detailed explanation goes here

%% Initialize Global Variables
%Figure Variable
global MainFig;
%Variables to save data
global M_File;


%% Save File
%Select FIle
[Path, Name, Ext]=fileparts(M_File.Trajectory.Trajectorypath);
Name=strcat(Name,'.mat');
[fileName,filePath] = uiputfile(Name,'Save .m File');
if filePath==0, error('None selected!'); end
Path=fullfile(filePath,fileName);
save(Path,'M_File');


