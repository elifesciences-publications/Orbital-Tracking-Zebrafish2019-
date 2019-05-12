function Create_Transfermatrix(~,~)

%% Initialize Global Variables
%Figure Variable
global MainFig;
%Variables to save data
global M_File;
%Variable for Summary
global Summary
%Variable To Store Video Information
global Video_Temp


if isfield(M_File,'Trajectory')==1
    if isfield(Video_Temp,'Tifstack') == 1
        M_File.Video_Data=[];
        %% Load Tifstack with laserreflections
        Tifstack=Read_Tifstack;
        
        %% Find positions of laserreflections
        WFPeaks=zeros(25,2);
        for i=1:size(Tifstack,3)
            [WFPeaks(i,1), WFPeaks(i,2)]=Find_Laserbeam_Position(Tifstack(:,:,i));
        end
        
        %% Calculate image transformation matrix
        Trackingpeaks=[-1, -0.5, 0, 0.5, 1, -1, -0.5, 0, 0.5, 1, -1, -0.5, 0, 0.5, 1, -1, -0.5, 0, 0.5, 1, -1, -0.5, 0, 0.5, 1; -1, -1, -1, -1, -1, -0.5, -0.5, -0.5, -0.5, -0.5, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 0.5, 0.5, 1, 1, 1, 1, 1,]';
        Scaling_Factor=str2double(MainFig.Maintab.Tab5.Panel.Videopanel.TransfermatrixVideoTrajectories.Scaling_Factor_Edit.String);
        Trackingpeaks=Trackingpeaks*Scaling_Factor;
        Transf=cp2tform(WFPeaks,Trackingpeaks,  'polynomial', 2);
        Transfermatrix=Transf.tdata;
        
        %% Save the Transfermatrix
        M_File.Video_Data.Transfermatrix=Transfermatrix;
        
        %%Update Progress Table
        M_File.Progress(5,1:2)={'Transfermatrix',true};
        Update_Progress;
        
        
        %% Calculate the average xy tracking position for each camera Frame:
        % Determine the beginning of each Frame
        Frame_old=0;
        Frame_start=zeros(size(Video_Temp.Tifstack,3),1);
        Frame_start_counter=1;
        for i=1:size(M_File.Trajectory.Image_Trajectory,1)
            if M_File.Trajectory.Camera_Frame(i) > Frame_old
                Frame_old=M_File.Trajectory.Camera_Frame(i);
                Frame_start(Frame_start_counter)=i;
                Frame_start_counter=Frame_start_counter+1;
                
            end
        end
        M_File.Video_Data.Frame_start=[1 nonzeros(Frame_start)']';
        if length(M_File.Video_Data.Frame_start) > size(Video_Temp.Tifstack,3)
            M_File.Video_Data.Frame_start=M_File.Video_Data.Frame_start(1:size(Video_Temp.Tifstack,3));
        end
        
        
        %Calculate the Long Range Jump array with the total shifts of all
        %jumps and convert them afterwards to camera coordinates
        M_File.Video_Data.Long_Range_Array=zeros(length(M_File.Video_Data.Frame_start),2);
        for i=1:length(M_File.Video_Data.Frame_start)
            if i==length(M_File.Video_Data.Frame_start)
                M_File.Video_Data.Long_Range_Array(i,:)=sum(M_File.Trajectory.Long_Range(1:end,:),1);
            else
                M_File.Video_Data.Long_Range_Array(i,:)=sum(M_File.Trajectory.Long_Range(1:M_File.Video_Data.Frame_start(i+1),:),1);
            end
        end
        
        M_File.Video_Data.Long_Range_Array=M_File.Video_Data.Long_Range_Array/17.30;
        
        for i=1:size(M_File.Video_Data.Long_Range_Array,1)
            M_File.Video_Data.Long_Range_Array(i,:)=round([1 ...
                M_File.Video_Data.Long_Range_Array(i,1) M_File.Video_Data.Long_Range_Array(i,2) ...
                M_File.Video_Data.Long_Range_Array(i,1).*M_File.Video_Data.Long_Range_Array(i,2) ...
                M_File.Video_Data.Long_Range_Array(i,1).^2 M_File.Video_Data.Long_Range_Array(i,2).^2]*Transfermatrix);
        end
        
        
        
        %Calculate average tracking Position and colour
        M_File.Video_Data.Camera_Trajectory=zeros(size(M_File.Video_Data.Frame_start,1),1);
        M_File.Video_Data.Colour_Data=zeros(size(M_File.Video_Data.Frame_start,1),3);
        for i=1:size(M_File.Video_Data.Frame_start,1)
            if i == size(M_File.Video_Data.Frame_start,1)
                x=mean(M_File.Trajectory.Image_Trajectory(M_File.Video_Data.Frame_start(i):end,1));
                y=mean(M_File.Trajectory.Image_Trajectory(M_File.Video_Data.Frame_start(i):end,2));
                M_File.Video_Data.Camera_Trajectory(i,1)=x;
                M_File.Video_Data.Camera_Trajectory(i,2)=y;
                M_File.Video_Data.Colour_Data(i,:)=mean(M_File.Dynamics.RGB_Population_Status(M_File.Video_Data.Frame_start(i):end,:),1);
            else
                x=mean(M_File.Trajectory.Image_Trajectory(M_File.Video_Data.Frame_start(i):M_File.Video_Data.Frame_start(i+1),1));
                y=mean(M_File.Trajectory.Image_Trajectory(M_File.Video_Data.Frame_start(i):M_File.Video_Data.Frame_start(i+1),2));
                M_File.Video_Data.Camera_Trajectory(i,1)=x;
                M_File.Video_Data.Camera_Trajectory(i,2)=y;
                M_File.Video_Data.Colour_Data(i,:)=mean(M_File.Dynamics.RGB_Population_Status(M_File.Video_Data.Frame_start(i):M_File.Video_Data.Frame_start(i+1),:),1);
                
            end
        end
        
        % Convert the tracking Coordinates to Camera Coordinates:
        for i=1:size(M_File.Video_Data.Camera_Trajectory,1)
            M_File.Video_Data.Camera_Trajectory(i,:)=round([1 ...
                M_File.Video_Data.Camera_Trajectory(i,1) M_File.Video_Data.Camera_Trajectory(i,2) ...
                M_File.Video_Data.Camera_Trajectory(i,1).*M_File.Video_Data.Camera_Trajectory(i,2) ...
                M_File.Video_Data.Camera_Trajectory(i,1).^2 M_File.Video_Data.Camera_Trajectory(i,2).^2]*Transfermatrix);
        end
        
        %Create XYShift and Frame Shift Variables
        M_File.Video_Data.XShift=...
            str2double(MainFig.Maintab.Tab5.Panel.Videopanel.XYShiftpanel.XShift_Edit.String);
        M_File.Video_Data.YShift=...
            str2double(MainFig.Maintab.Tab5.Panel.Videopanel.XYShiftpanel.YShift_Edit.String);
        M_File.Video_Data.Frame_Shift=...
            str2double(MainFig.Maintab.Tab5.Panel.Videopanel.Frameshift.Frameshift_Edit.String);
        
        %Create Scalebarwidth
        xscale=17.30; %µm/V
        yscale=17.30; %µm/V
        
        Meanscale=(xscale+yscale)/2;
        Scalebar=5; %µm
        Scalebarvolt=Scalebar/Meanscale;
        Scalebarstart=round([1 0 0 0 0 0]*Transfermatrix);
        Scalebarend=round([1 Scalebarvolt 0 0 Scalebarvolt^2 0]*Transfermatrix);
        if Scalebarend(2)-Scalebarstart(2) > Scalebarend(1)-Scalebarstart(1)
            M_File.Video_Data.Scalebarlength=Scalebarend(2)-Scalebarstart(2);
        else
            M_File.Video_Data.Scalebarlength=Scalebarend(1)-Scalebarstart(1);
        end
        
        
        %% Create Array with Starting points for Long Range Jumps
        j=1;
        M_File.Video_Data.Cam_Long_Range=0;
        for i=1:length(M_File.Trajectory.Long_Range(:,1));
            if M_File.Trajectory.Long_Range(i,1) ~= 0 | M_File.Trajectory.Long_Range(i,2) ~= 0
                M_File.Video_Data.Cam_Long_Range(j)=M_File.Trajectory.Camera_Frame(i)-M_File.Video_Data.Frame_Shift;
                j=j+1;
            end
        end
        
        
        
        
        
        %% Create Array with duration between two jumps and remove Phases with are shorter than 10 frames and remove last jump phase
        Timeshift=10;
        M_File.Video_Data.Cam_Long_Range_Dur=M_File.Video_Data.Cam_Long_Range(2:end)-M_File.Video_Data.Cam_Long_Range(1:end-1)-1;
        M_File.Video_Data.Cam_Long_Range_Dur=[M_File.Video_Data.Cam_Long_Range_Dur length(M_File.Video_Data.Camera_Trajectory(:,1))-M_File.Video_Data.Cam_Long_Range(end)-1]
        M_File.Video_Data.Cam_Long_Range(M_File.Video_Data.Cam_Long_Range_Dur<=Timeshift)=[];
        M_File.Video_Data.Cam_Long_Range_Dur(M_File.Video_Data.Cam_Long_Range_Dur<=Timeshift)=[];
        
        M_File.Video_Data.Cam_Long_Range(M_File.Video_Data.Cam_Long_Range<=0)=1;
        M_File.Colocalization=[];
        M_File.Colocalization.Max_Frame=length(M_File.Video_Data.Cam_Long_Range)-1;
        
        %% Update Progress Table
        M_File.Progress(6,1:2)={'Camera Trajectories',true};
        Update_Progress;
        Update_Tab5;
    end
end