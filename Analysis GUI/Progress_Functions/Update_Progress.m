function Update_Progress(~,~)
%UPDATE_PROGRESS Summary of this function goes here
%   Detailed explanation goes here

%% Initialize Global Variables
%Figure Variable
global MainFig;
%Variables to save data
global M_File;
%Variable for Summary
global Summary
%Variable To Store Video Information
global Video_Temp


%% Update Progress Table
% Clear Data
Progress_Default_Data;

if isempty(M_File) == 0
    Temp=get(MainFig.Panel.Table,'Data');
    Temp(1:size(M_File.Progress,1),1:size(M_File.Progress,2))=M_File.Progress;
    set(MainFig.Panel.Table,'Data',Temp)    
end

end

