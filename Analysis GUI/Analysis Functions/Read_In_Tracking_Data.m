function [Image_Trajectory, Trajectory, Camera_Frame, Intensities, Tracking, ...
    Orbit_Time, Orbit_Radius, Tracking_Treshold, Delay_Orbits, Number_of_Particles, ...
    Long_Range_Treshold, Trajectorypath, Long_Range] = Read_In_Tracking_Data(Xscale, Yscale, Zscale)
%READ_IN_TRACKING_DATA Loads and converts Trajectory Data into Image Data and corrected data.

%% Read in Trajectory
[fileName,filePath] = uigetfile('*', 'Open Trajectory', '.');
if filePath==0, error('None selected!'); end
Trajectorypath=fullfile(filePath,fileName);
Prim_Data=textscan(fopen(Trajectorypath),'%s %s %s %s %s %s %s %s %s %s %s','delimiter','\t');
Sec_Data=Prim_Data{1};

h=waitbar(0,'Load Trajectory','WindowStyle','modal');
Data=zeros(length(Sec_Data)-13,11);
for i=1:11
    Sec_Data=Prim_Data{i};
    Data(:,i)=cellfun(@str2num,Sec_Data(14:end));
end

%% Tracking Parameters
Sec_Data=Prim_Data{2};
Orbit_Time=cellfun(@str2num,Sec_Data(5));
Orbit_Radius=cellfun(@str2num,Sec_Data(6))*((Xscale+Yscale)/2);
Tracking_Treshold=cellfun(@str2num,Sec_Data(7));
Delay_Orbits=cellfun(@str2num,Sec_Data(8));
Number_of_Particles=cellfun(@str2num,Sec_Data(9));
Long_Range_Treshold=cellfun(@str2num,Sec_Data(11))*((Xscale+Yscale)/2);
Orbit_Time=Orbit_Time*(1+Delay_Orbits)*0.001;
%% Camera Frame
Camera_Frame=Data(:,8);

%% Intensities
Intensities=Data(:,6:7);

%% Tracking
Tracking=Data(:,9);
Long_Range=Data(:,10:11);

%% Create Image Data
Image_Trajectory=Data(:,1:3);

%% Scale Raw Data

Data(:,1)=Data(:,1)*Xscale;
Data(:,2)=Data(:,2)*Yscale;
Data(:,3)=Data(:,3)*Zscale;


waitbar(1)
%% Correct the Trajectory for Long Range Tracking
Xaddition=0;
Yaddition=0;
for i=1:length(Data(:,1));
   
   if Data(i,10) ~= 0
       Xaddition=Xaddition+Data(i,10);
       Data(i,1)=Data(i,1)+Xaddition;
       Data(i,2)=Data(i,2)+Yaddition;
   elseif Data(i,11) ~= 0
       Yaddition=Yaddition+Data(i,11);
       Data(i,1)=Data(i,1)+Xaddition;
       Data(i,2)=Data(i,2)+Yaddition;
   else
       Data(i,1)=Data(i,1)+Xaddition;
       Data(i,2)=Data(i,2)+Yaddition;
   end
   
end

Trajectory=Data(:,1:3);


close(h)
end

