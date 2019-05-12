clear all
close all

%% Select Folder
Folder_Name=uigetdir('','Select Folder for Summary');
File_List=dir(Folder_Name);

%% Select Files to laod
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

%% Orbit TIme
Orbit_Time=0.01;
%% Create n*m Matrix with n-sized bins for all m trajectories
Binsize=0.1; %Spatial Binsize [µm]
X_Min=-25; %[µm]
X_Max=25; %[µm]
Bins=((X_Max-X_Min)/Binsize)+1;
X_Axis=X_Min:Binsize:X_Max;
Travel_Time_Mat=zeros(length(Data(:,1)),Bins)-0.1;


%% Fill Traveltime per bin.
% Check start and endpoint in matrix depending on y-min and y-max of the
% trajectory.

figure(1)
hold on
for i=1:length(Data(:,1))
    %Load Data File
    load(Data{i,1});
    
    Temp.X_Min=min(M_File.Trajectory.Trajectory(:,2));
    Temp.X_Max=max(M_File.Trajectory.Trajectory(:,2));
    Temp.Startpoint=find(X_Axis < Temp.X_Min);
    Temp.Startpoint=Temp.Startpoint(end);
    Temp.Endpoint=find(X_Axis > Temp.X_Max);
    Temp.Endpoint=Temp.Endpoint(1);
    
    %Calculate persistence time for each bin
    for j=Temp.Startpoint:1:Temp.Endpoint-1
        
        Travel_Time_Mat(i,j)=length(find(M_File.Trajectory.Trajectory(:,2) < X_Axis(j+1)))-...
            length(find(M_File.Trajectory.Trajectory(:,2) < X_Axis(j)));
        
        
        
    end
    %Travel_Time_Mat(i,:)=Travel_Time_Mat(i,:)/sum(Travel_Time_Mat(i,:));
    
    
    
end
hold off


%% Load First Movie of the repetitive data
Tifstack=Read_Tifstack;

%% Smooth Tifstack
for i=1:size(Tifstack,3)
   Tifstack(:,:,i)=smooth2a(Tifstack(:,:,i),5,5); 
    i
end

%% Remove moving Mitos
Timeshift=10;


for i=1:length(Tifstack(1,1,:))-Timeshift
    Comet=Tifstack(:,:,i+Timeshift)-Tifstack(:,:,i);
    Comet(Comet>0)=0;
    TempTif(:,:,i)=Tifstack(:,:,i)+Comet;
    i
end

FinalTif=mean(TempTif,3);
FinalTif=im2bw(FinalTif,mean(mean((FinalTif))+3*std(std(FinalTif))));


%% Play FInaltifstack
% 
% for i=1:length(TempTif(1,1,:))
%    figure(3)
%    image(im2bw(TempTif(:,:,i),mean(mean((TempTif(:,:,i)))+3*std(std(TempTif(:,:,i))))));
%    pause(0.2)
%    i
%     
%     
% end
% 
% 
% 
% figure(3)
% imshow(im2bw(FinalTif,mean(mean((FinalTif))+3*std(std(FinalTif)))));

%% Convert X_Axis to Camera Coordinates
Temp_X_Axis=repmat(X_Axis,2,1)'/17.30;
load('Transformation_Matrix.mat')

for i=1:size(Temp_X_Axis,1)
    Cam_X_Axis(i,:)=round([1 Temp_X_Axis(i,1) Temp_X_Axis(i,2) Temp_X_Axis(i,1).*Temp_X_Axis(i,2) Temp_X_Axis(i,1).^2 Temp_X_Axis(i,2).^2]*Transfermatrix);
end


Cam_X_Axis=Cam_X_Axis(:,1);

%% Create Array to display X positions of mitochondria
Mito_Array=zeros(length(X_Axis),1);

for i=1:length(Cam_X_Axis);
    if Cam_X_Axis(i) > 0 && Cam_X_Axis(i) < 513
        if sum(FinalTif(:,Cam_X_Axis(i))) > 0
    Mito_Array(i)=1;
        end
    end
end

figure(1)
hold on
bar(X_Axis,Mito_Array*12,'r')

for i=1:size(Travel_Time_Mat,1)

        scatter(X_Axis,Travel_Time_Mat(i,:)*0.01,'filled')
    
        

end

hold off