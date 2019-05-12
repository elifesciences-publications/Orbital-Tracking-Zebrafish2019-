function Update_Tab1(~,~)
%UPDATE_TAB1 Summary of this function goes here
%   Detailed explanation goes here

%% Initialize Global Variables
%Figure Variable
global MainFig;
%Variables to save data
global M_File;

%% Update Figure 1
if isfield(M_File,'Trajectory') == 1
    
    axes(MainFig.Maintab.Tab1.Panel.Fig1)
    plot3(M_File.Trajectory.Trajectory(:,1),M_File.Trajectory.Trajectory(:,2),M_File.Trajectory.Trajectory(:,3))
    axis equal;
    grid on;
    view([285 25]);
    [path,name,~] = fileparts(M_File.Trajectory.Trajectorypath);
    title(name);
    xlabel('X[µm]');
    ylabel('Y[µm]');
    zlabel('Z[µm]');
    
else
    
    cla(MainFig.Maintab.Tab1.Panel.Fig1);
    
    MainFig.Maintab.Tab2.Panel.Tab.Tab1.Fig1.Title.String='Trajectory';
    MainFig.Maintab.Tab2.Panel.Tab.Tab1.Fig1.XLabel.String='X [µm]';
    MainFig.Maintab.Tab2.Panel.Tab.Tab1.Fig1.YLabel.String='Y [µm]';
    MainFig.Maintab.Tab2.Panel.Tab.Tab1.Fig1.ZLabel.String='Z [µm]';
end


%% Update Table 1

if isfield(M_File,'Trajectory') == 1
    
    Temp=get(MainFig.Maintab.Tab1.Panel.Table,'Data');
    Temp(1,1)={path};
    Temp(1,2)={name};
    Temp(1,3)={length(M_File.Trajectory.Tracking)};
    Temp(1,4)={length(M_File.Trajectory.Tracking)*M_File.Trajectory.Orbit_Time};
    Temp(1,5)={M_File.Trajectory.Orbit_Time*1000};
    Temp(1,6)={M_File.Trajectory.Delay_Orbits};
    Temp(1,7)={M_File.Trajectory.Number_of_Particles};
    Temp(1,8)={M_File.Trajectory.Long_Range_Treshold};
    Temp(1,9)={M_File.Trajectory.Orbit_Radius*1000};
    set(MainFig.Maintab.Tab1.Panel.Table,'Data',Temp);

else
    Trajectory_Table_Default_Data;
    
end
