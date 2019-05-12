function Load_m_File( ~,~ )
%LOAD_M_FILE Summary of this function goes here
%   Detailed explanation goes here

%% Initialize Global Variables
clearvars -global -except MainFig;
%Figure Variable
global MainFig;
%Variables to save data
global M_File;
%Variable for Summary
global Summary


%% Load File
%Select File
[fileName,filePath] = uigetfile('*.mat','Open .m File');
if filePath==0, error('None selected!'); end
Path=fullfile(filePath,fileName);
Temp=load(Path);

%% Clear Variable which is not loaded
if isfield(Temp,'M_File') == 1
    M_File=Temp.M_File;
    Summary=[];
    
elseif isfield(Temp,'Summary')==1
    M_File=[];
    Summary=Temp.Summary;
end
    

%% Update Tabs
Update_Progress;
Update_Tab1;
Update_Tab2;
Update_Tab3;
Update_Tab4;
Update_Tab5;



