clear all
close all

%% Load Tifstack with laserreflections
Tifstack=Read_Tifstack;

%% Find positions of laserreflections
WFPeaks=zeros(25,2);
for i=1:size(Tifstack,3)
[WFPeaks(i,1), WFPeaks(i,2)]=Find_Laserbeam_Position(Tifstack(:,:,i));
end

%% Calculate image transformation matrix
Trackingpeaks=[-1, -0.5, 0, 0.5, 1, -1, -0.5, 0, 0.5, 1, -1, -0.5, 0, 0.5, 1, -1, -0.5, 0, 0.5, 1, -1, -0.5, 0, 0.5, 1; -1, -1, -1, -1, -1, -0.5, -0.5, -0.5, -0.5, -0.5, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 0.5, 0.5, 1, 1, 1, 1, 1,]';
Scaling_Factor=0.8;
Trackingpeaks=Trackingpeaks*Scaling_Factor;
Transf=cp2tform(WFPeaks,Trackingpeaks,  'polynomial', 2);
Transfermatrix=Transf.tdata;

%% Save the Transfermatrix
[fileName,filePath]=uiputfile;
Filename=fullfile(filePath,fileName);
save(Filename, 'Transfermatrix');

