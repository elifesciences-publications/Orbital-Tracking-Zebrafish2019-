function Select_Folder(~,~)
%% Initialize Global Variables
%Figure Variable
global MainFig;
%Variables to save data
global M_File;
%Variable for Summary
global Summary

%% Select Folder
Folder_Name=uigetdir('','Select Folder for Summary');
File_List=dir(Folder_Name);

h=waitbar(0,'Load M-Files','WindowStyle','modal');
%% Write Data to Table
%Create Data Cell for Table
j=1;
for i=1:length(File_List)
    Temp=File_List(i);
    if Temp.isdir == 0
        [~,~,ext] = fileparts(Temp.name);
        if strcmp('.mat',ext) == 1
            Data{j,1}=fullfile(Folder_Name,Temp.name);
            Data{j,2}=true;
            j=j+1;     
        end
    end    
end
if j>1
    MainFig.Maintab.Tab4.Panel.Tab.Tab1.Table.Data=Data;
else
    MainFig.Maintab.Tab4.Panel.Tab.Tab1.Table.Data={'Filename',false,''};
end

Summary.Filelist=MainFig.Maintab.Tab4.Panel.Tab.Tab1.Table.Data;


%% Load Directions and Length and Pause Freq of each File

for i=1:length(Summary.Filelist(:,1))
        load(Summary.Filelist{i,1});
        Length=M_File.Trajectory.Trajectory(end,2)-M_File.Trajectory.Trajectory(1,2);
        if Length > 0
            Summary.Filelist{i,3}='Anterograde';
            Summary.Filelist{i,4}=num2str(Length);
            Summary.Pause_Freq_Plus(i)=length(M_File.Passive.Startpoint_Passive_Phase)/Length;
        else
            Summary.Filelist{i,3}='Retrograde';
            Summary.Filelist{i,4}=num2str(Length);
            Summary.Pause_Freq_Minus(i)=length(M_File.Passive.Startpoint_Passive_Phase)/Length;
        end
        waitbar(i/length(Summary.Filelist(:,1)))
        
end
Summary.Pause_Freq_Plus(Summary.Pause_Freq_Plus==0)=[];
Summary.Pause_Freq_Minus(Summary.Pause_Freq_Minus==0)=[];
MainFig.Maintab.Tab4.Panel.Tab.Tab1.Table.Data=Summary.Filelist;

close(h)
