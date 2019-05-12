function Start_Correlation( ~,~ )
%START_CORRELATION Summary of this function goes here
%   Detailed explanation goes here

%% Global Variables
%Figure Variable
global MainFig;
%Variables to save data
global M_File;


%% Start Correlation
if isempty(M_File) == 0
    M_File.Dynamics=[];
    M_File.Dynamics.Orbit_Treshold=str2double(get(MainFig.Maintab.Tab2.Panel.OrbitTreshEdit,'String'))/1000/M_File.Trajectory.Orbit_Time;
    Temp=get(MainFig.Maintab.Tab2.Panel.ParforSelect.Handle,'SelectedObject');
    par=get(Temp,'String');
    
    [M_File.Dynamics, M_File.Passive, M_File.Correlation.Smooth_Corr_Phi, ...
        M_File.Correlation.Treshold, M_File.Correlation.Active_Phase ] = ...
        Identify_active_states( M_File.Trajectory, M_File.Dynamics, ...
        par, str2double(get(MainFig.Maintab.Tab2.Panel.ActiveTreshEdit,'String')),...
        str2double(get(MainFig.Maintab.Tab2.Panel.CorrWindEdit,'String')));
       
    %Update Progress Table in M_File
    M_File.Progress(3,1:2)={'Identify Active States', true};
    
    %Plot Active and Passive States + Correlation Amplitude
    Update_Tab2;
           
    %Update Progress Table
    Update_Progress
    
end
end

