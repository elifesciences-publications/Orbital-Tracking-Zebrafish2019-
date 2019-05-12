function Load_Trajectory_File(~,~)
%READ_IN_TRACKING_DATA Loads and converts Trajectory Data into Image Data and corrected data.
%% Scaling Factors
Xscale=17.30;
Yscale=17.30;
Zscale=10.00;



%% Initialize Global Variables
%Clear M_File
clearvars -global -except MainFig;

%Figure Variable
global MainFig;
%Variables to save data
global M_File;


%Initialize Variables
M_File=[];
M_File.Trajectory=[];

%Load Trajectory
[M_File.Trajectory.Image_Trajectory, M_File.Trajectory.Trajectory, M_File.Trajectory.Camera_Frame, ... 
    M_File.Trajectory.Intensities, M_File.Trajectory.Tracking, M_File.Trajectory.Orbit_Time, ...
    M_File.Trajectory.Orbit_Radius, M_File.Trajectory.Tracking_Treshold, M_File.Trajectory.Delay_Orbits, ... 
    M_File.Trajectory.Number_of_Particles, M_File.Trajectory.Long_Range_Treshold, M_File.Trajectory.Trajectorypath,...
    M_File.Trajectory.Long_Range]= Read_In_Tracking_Data(Xscale, Yscale, Zscale);


%% Create struct for analysis progress:
    M_File.Progress(1,:)={'Load Trajectory', true};
    M_File.Progress(2,:)={'Create .m File', true};

%% Update GUI
Update_Tab1;
Update_Tab2;
Update_Tab3;
Update_Tab4;
Update_Progress;








