function [Pop] = Calculate_Passive_Stepsize_Trajectory_Data(Pop, General)
%CALCULATE_POPULATION_STEPSIZE Calculates 2D and 3D stepsizes plus a matrix containing the trajectory data for the population
XY_Stepsize=zeros(1,1);
XYZ_Stepsize=zeros(1,1);
Trajectory_Data=zeros(1,3);
Temp=zeros(1,3);

for i=1:length(Pop.Startpoint_Passive_Phase)
    dx=General.Smoothed_Trajectory(Pop.Startpoint_Passive_Phase(i):Pop.Startpoint_Passive_Phase(i)+Pop.Orbit_Length_Passive_Phase(i)-1,1)-General.Trajectory(Pop.Startpoint_Passive_Phase(i)+1:Pop.Startpoint_Passive_Phase(i)+Pop.Orbit_Length_Passive_Phase(i),1);
    dy=General.Smoothed_Trajectory(Pop.Startpoint_Passive_Phase(i):Pop.Startpoint_Passive_Phase(i)+Pop.Orbit_Length_Passive_Phase(i)-1,2)-General.Trajectory(Pop.Startpoint_Passive_Phase(i)+1:Pop.Startpoint_Passive_Phase(i)+Pop.Orbit_Length_Passive_Phase(i),2);
    dz=General.Smoothed_Trajectory(Pop.Startpoint_Passive_Phase(i):Pop.Startpoint_Passive_Phase(i)+Pop.Orbit_Length_Passive_Phase(i)-1,3)-General.Trajectory(Pop.Startpoint_Passive_Phase(i)+1:Pop.Startpoint_Passive_Phase(i)+Pop.Orbit_Length_Passive_Phase(i),3);
    Distance_Temp_XYZ=sqrt(dx.^2+dy.^2+dz.^2);
    Distance_Temp_XY=sqrt(dx.^2+dy.^2);
    XY_Stepsize=cat(1,XY_Stepsize,Distance_Temp_XY);
    XYZ_Stepsize=cat(1,XYZ_Stepsize,Distance_Temp_XYZ);
    Array_Temp=General.Trajectory(Pop.Startpoint_Passive_Phase(i):Pop.Startpoint_Passive_Phase(i)+Pop.Orbit_Length_Passive_Phase(i)-1,:);
    Array_Temp=cat(1,Array_Temp,Temp);
    Trajectory_Data=cat(1,Trajectory_Data,Array_Temp);
end
    Pop.XY_Stepsize=XY_Stepsize(2:end);
    Pop.XYZ_Stepsize=XYZ_Stepsize(2:end);
    Pop.Trajectory_Data=Trajectory_Data(2:end,:);
    
    
    Pop.XY_Stepsize_Mean=mean(Pop.XY_Stepsize); %Mean Stepsize [µm]
    Pop.XY_Stepsize_Std=std(Pop.XY_Stepsize); %Std Stepsize [µm]
end

