function Start_Colocalization(~,~)

%% Initialize Global Variables
%Figure Variable
global MainFig;
%Variables to save data
global M_File;
%Variable for Summary
global Summary
%Variable To Store Video Information
global Video_Temp

if isfield(Video_Temp,'Tifstack')==1
    M_File.Colocalization=[];
    h=waitbar(0,'Colocalization Analysis','WindowStyle','modal');
    
    
    Timeshift=10;  
    
    
    
    %% Max Frame
    Max_F=length(M_File.Video_Data.Cam_Long_Range)-str2num(MainFig.Maintab.Tab5.Panel.Colocalizationpanel.End_Edit.String);
    M_File.Colocalization.Max_Frame=str2num(MainFig.Maintab.Tab5.Panel.Colocalizationpanel.End_Edit.String);
    
    %% Create Mean Image for each Phase between long Range Jumps
    %Loop over all durations
    Colocalization_Stack=zeros(512,512,length(M_File.Video_Data.Cam_Long_Range_Dur));
    for i=1:length(M_File.Video_Data.Cam_Long_Range)-Max_F
        %Loop over all Pictures between two jumps minus the number of picture
        %required for Timeshift
        TempTif=zeros(512,512,M_File.Video_Data.Cam_Long_Range_Dur(i)-Timeshift);
        for j=1:M_File.Video_Data.Cam_Long_Range_Dur(i)-Timeshift
            %Create Frameold, smooth it by 5 points in 2D and scale it to 1;
            Frameold=Video_Temp.Tifstack(:,:,M_File.Video_Data.Cam_Long_Range(i)+j);
            Frameold=smooth2a(Frameold,5,5);
            Frameold=Frameold/max(max(Frameold));
            
            %Create Framenew
            Framenew=Video_Temp.Tifstack(:,:,M_File.Video_Data.Cam_Long_Range(i)+j+Timeshift);
            Framenew=smooth2a(Framenew,5,5);
            Framenew=Framenew/max(max(Framenew));
            
            %Create Comet image
            Comet=Framenew-Frameold;
            Comet(Comet>0)=0;
            
            %Add Comet to Frameold to create Image without moving Mitos
            TempTif(:,:,j)=Frameold+Comet;
            TempTif(:,:,j)=smooth2a(TempTif(:,:,j),5,5);
            
            Progress=(M_File.Video_Data.Cam_Long_Range_Dur(1:end-Max_F)-Timeshift);
            
            waitbar((sum(Progress(1:i-1))+j)/sum(Progress));
        end
        
        M_File.Video_Data.Colocalization_Stack(:,:,i)=mean(TempTif,3);
        M_File.Video_Data.Colocalization_Stack(:,:,i)=im2bw(...
            M_File.Video_Data.Colocalization_Stack(:,:,i),...
            mean(mean(M_File.Video_Data.Colocalization_Stack(:,:,i)))+...
            5*std(std(M_File.Video_Data.Colocalization_Stack(:,:,i))));
        clear TempTif
    end
    
    
    %% Create Phase Mask to Remove Artifact beside the trajectory e.g. other mitos or cell bodys.
    
    Window_SizeX=25;
    Window_SizeY=5;
    % Loop over all Long Range Jumps phases
    for i=1:length(M_File.Video_Data.Cam_Long_Range)-Max_F
        Phase_Mask_Temp=zeros(512,512);
        %Loop over all images
        for j=1:M_File.Video_Data.Cam_Long_Range_Dur(i)
            if M_File.Video_Data.Cam_Long_Range(i)+j+M_File.Video_Data.Frame_Shift <= length(M_File.Video_Data.Camera_Trajectory(:,1));
            XCor=M_File.Video_Data.Camera_Trajectory(M_File.Video_Data.Cam_Long_Range(i)+j+M_File.Video_Data.Frame_Shift,1)-M_File.Video_Data.YShift;
            YCor=M_File.Video_Data.Camera_Trajectory(M_File.Video_Data.Cam_Long_Range(i)+j+M_File.Video_Data.Frame_Shift,2)+M_File.Video_Data.XShift;
            Phase_Mask_Temp(XCor-Window_SizeX:XCor+Window_SizeX,YCor-Window_SizeY:YCor+Window_SizeY)=ones(Window_SizeX*2+1,Window_SizeY*2+1);
            end
            
        end
        %M_File.Video_Data.Colocalization_Stack(:,:,i)=M_File.Video_Data.Colocalization_Stack(:,:,i).*Phase_Mask_Temp;
    end
    
    %% Calculate Region Probs for all images With centroids width for each image
    % Use the build-in Matlab function to extract the position and centroid
    % data for each stationary mito.
    for i=1:length(M_File.Video_Data.Colocalization_Stack(1,1,:))
        Stats=regionprops(logical(M_File.Video_Data.Colocalization_Stack(:,:,i)),'MajorAxisLength','MinorAxisLength','Centroid');
        Centroid_Temp=reshape(cell2mat({Stats.Centroid}),2,[]);
        Centroid{i}=round(Centroid_Temp(2,:));
        clear Centroid_Temp
        MajorAxis{i}=round(cell2mat({Stats.MajorAxisLength}));
        %     clear Stats
    end
    
    
    
    %% Create a true/false array for each Image
    %1: Mito at that location
    %0: No Mito
    
    Mito_Array_draft=zeros(512,1);
    %Loop over all Long Range Jumps
    for i=1:length(M_File.Video_Data.Colocalization_Stack(1,1,:))
        Mito_Array_Temp=Mito_Array_draft;
        %Loop over all Mitochondria
        for j=1:length((Centroid{i}))
            Length=MajorAxis{i}(j)-mod(MajorAxis{i}(j),2);
            Start=Centroid{i}(j)-(0.5*Length);
            if Start < 2
                Start=1;
            end
            
            Mito_Array_Temp(Start:Start+Length-1)=ones(Length,1);
        end
        M_File.Video_Data.Mito_Array{i}=Mito_Array_Temp;
        clear Length
        clear Start
        clear Mito_Array_Temp
        
    end
    clear Mito_Array_draft
    clear i
    clear j
    
    %% Create True/False Array for each Camera Frame
    M_File.Video_Data.MitoPosCam=[];
    % Loop over all Long Range Jumps phases
    for i=1:length(M_File.Video_Data.Cam_Long_Range)-Max_F
        %Loop over all images
        for j=1:M_File.Video_Data.Cam_Long_Range_Dur(i)
            if M_File.Video_Data.Cam_Long_Range(i)+j+M_File.Video_Data.Frame_Shift <= length(M_File.Video_Data.Camera_Trajectory(:,1));
            XCor=M_File.Video_Data.Camera_Trajectory(M_File.Video_Data.Cam_Long_Range(i)+j+M_File.Video_Data.Frame_Shift,1)-M_File.Video_Data.YShift;
            Temp=M_File.Video_Data.Mito_Array{i};
            if Temp(XCor) == 1
                M_File.Video_Data.MitoPosCam(M_File.Video_Data.Cam_Long_Range(i)+j-1)=1;
            else
                M_File.Video_Data.MitoPosCam(M_File.Video_Data.Cam_Long_Range(i)+j-1)=0;
            end
            end
        end
    end
    
    
    %% Expand True/False from Camera Frames to Orbits
    Start=find(M_File.Trajectory.Camera_Frame==M_File.Video_Data.Frame_Shift);
    Start=Start(1);
    M_File.Video_Data.MitoPosOrb=ones(length(M_File.Trajectory.Camera_Frame),1)*10;
    for i=Start:length(M_File.Trajectory.Camera_Frame)
        if M_File.Trajectory.Camera_Frame(i)-M_File.Video_Data.Frame_Shift+1 < M_File.Video_Data.Cam_Long_Range(end-Max_F)+M_File.Video_Data.Cam_Long_Range_Dur(end-Max_F)
            M_File.Video_Data.MitoPosOrb(i)=M_File.Video_Data.MitoPosCam(M_File.Trajectory.Camera_Frame(i)-M_File.Video_Data.Frame_Shift+1);
        end
    end
    
    %% Assign Population Points to Mito or No Mito Bins
    M_File.Colocalization.Orbits.Mito_Pop1_Plus=0;
    M_File.Colocalization.Orbits.Mito_Pop2_Plus=0;
    M_File.Colocalization.Orbits.Mito_Pop1_Minus=0;
    M_File.Colocalization.Orbits.Mito_Pop2_Minus=0;
    M_File.Colocalization.Orbits.Mito_Passive=0;
    
    M_File.Colocalization.Orbits.Track_Pop1_Plus=0;
    M_File.Colocalization.Orbits.Track_Pop2_Plus=0;
    M_File.Colocalization.Orbits.Track_Pop1_Minus=0;
    M_File.Colocalization.Orbits.Track_Pop2_Minus=0;
    M_File.Colocalization.Orbits.Track_Passive=0;
    
    for i=1:length(M_File.Video_Data.MitoPosOrb)
        
        %Increase counter if mito is on the track
        if  M_File.Video_Data.MitoPosOrb(i) == 1
            if M_File.Dynamics.Population_Status(i) == 0
                M_File.Colocalization.Orbits.Mito_Passive=M_File.Colocalization.Orbits.Mito_Passive+1;
            elseif M_File.Dynamics.Population_Status(i) == 1
                M_File.Colocalization.Orbits.Mito_Pop1_Minus=M_File.Colocalization.Orbits.Mito_Pop1_Minus+1;
            elseif M_File.Dynamics.Population_Status(i) == 2
                M_File.Colocalization.Orbits.Mito_Pop1_Plus=M_File.Colocalization.Orbits.Mito_Pop1_Plus+1;
            elseif M_File.Dynamics.Population_Status(i) == 3
                M_File.Colocalization.Orbits.Mito_Pop2_Minus=M_File.Colocalization.Orbits.Mito_Pop2_Minus+1;
            elseif M_File.Dynamics.Population_Status(i) == 4
                M_File.Colocalization.Orbits.Mito_Pop2_Plus=M_File.Colocalization.Orbits.Mito_Pop2_Plus+1;
            end
            
            %Increase counter if no mito is on the track
        elseif M_File.Video_Data.MitoPosOrb(i) == 0
            if M_File.Dynamics.Population_Status(i) == 0
                M_File.Colocalization.Orbits.Track_Passive=M_File.Colocalization.Orbits.Track_Passive+1;
            elseif M_File.Dynamics.Population_Status(i) == 1
                M_File.Colocalization.Orbits.Track_Pop1_Minus=M_File.Colocalization.Orbits.Track_Pop1_Minus+1;
            elseif M_File.Dynamics.Population_Status(i) == 2
                M_File.Colocalization.Orbits.Track_Pop1_Plus=M_File.Colocalization.Orbits.Track_Pop1_Plus+1;
            elseif M_File.Dynamics.Population_Status(i) == 3
                M_File.Colocalization.Orbits.Track_Pop2_Minus=M_File.Colocalization.Orbits.Track_Pop2_Minus+1;
            elseif M_File.Dynamics.Population_Status(i) == 4
                M_File.Colocalization.Orbits.Track_Pop2_Plus=M_File.Colocalization.Orbits.Track_Pop2_Plus+1;
            end
        else
            
        end
    end
    
    %% Create Shrinked Mito or No Mito Array
    M_File.Colocalization.Phases.Population_Status=0;
    M_File.Colocalization.Phases.Mito_Status=0;
    Start=1;
    End=1;
    for i=2:length(M_File.Dynamics.Population_Status)
        if M_File.Dynamics.Population_Status(i) == M_File.Dynamics.Population_Status(i-1)
            
        else
            M_File.Colocalization.Phases.Population_Status=...
                [M_File.Colocalization.Phases.Population_Status M_File.Dynamics.Population_Status(i)];
            Start=[Start (i)];
            End=[End (i-1)];
        end
    end
    End=End(2:end);
    End=[End length(M_File.Dynamics.Population_Status)];
    for i=1:length(Start);
        Temp=mean(M_File.Video_Data.MitoPosOrb(Start(i):End(i)));
        if Temp > 0.5 && Temp <= 1
            M_File.Colocalization.Phases.Mito_Status(i)=1;
        elseif Temp < 0.5
            M_File.Colocalization.Phases.Mito_Status(i)=0;
        else
            M_File.Colocalization.Phases.Mito_Status(i)=10;
        end
    end
    M_File.Colocalization.Phases.Population_Status=M_File.Colocalization.Phases.Population_Status(2:end);
    M_File.Colocalization.Phases.Mito_Status=M_File.Colocalization.Phases.Mito_Status(2:end);
    
    
    
    %% Assign Phases to Mito or No Mito Bins
    M_File.Colocalization.Phases.Mito_Pop1_Plus=0;
    M_File.Colocalization.Phases.Mito_Pop2_Plus=0;
    M_File.Colocalization.Phases.Mito_Pop1_Minus=0;
    M_File.Colocalization.Phases.Mito_Pop2_Minus=0;
    M_File.Colocalization.Phases.Mito_Passive=0;
    
    M_File.Colocalization.Phases.Track_Pop1_Plus=0;
    M_File.Colocalization.Phases.Track_Pop2_Plus=0;
    M_File.Colocalization.Phases.Track_Pop1_Minus=0;
    M_File.Colocalization.Phases.Track_Pop2_Minus=0;
    M_File.Colocalization.Phases.Track_Passive=0;
    
    for i=1:length(M_File.Colocalization.Phases.Population_Status)
        if M_File.Colocalization.Phases.Mito_Status(i) == 1
            if M_File.Colocalization.Phases.Population_Status(i) == 0
                M_File.Colocalization.Phases.Mito_Passive=M_File.Colocalization.Phases.Mito_Passive+1;
            elseif M_File.Colocalization.Phases.Population_Status(i) == 1
                M_File.Colocalization.Phases.Mito_Pop1_Minus=M_File.Colocalization.Phases.Mito_Pop1_Minus+1;
            elseif M_File.Colocalization.Phases.Population_Status(i) == 2
                M_File.Colocalization.Phases.Mito_Pop1_Plus=M_File.Colocalization.Phases.Mito_Pop1_Plus+1;
            elseif M_File.Colocalization.Phases.Population_Status(i) == 3
                M_File.Colocalization.Phases.Mito_Pop2_Minus=M_File.Colocalization.Phases.Mito_Pop2_Minus+1;
            elseif M_File.Colocalization.Phases.Population_Status(i) == 4
                M_File.Colocalization.Phases.Mito_Pop2_Plus=M_File.Colocalization.Phases.Mito_Pop2_Plus+1;
            end
            
        elseif M_File.Colocalization.Phases.Mito_Status(i) == 0
            if M_File.Colocalization.Phases.Population_Status(i) == 0
                M_File.Colocalization.Phases.Track_Passive=M_File.Colocalization.Phases.Track_Passive+1;
            elseif M_File.Colocalization.Phases.Population_Status(i) == 1
                M_File.Colocalization.Phases.Track_Pop1_Minus=M_File.Colocalization.Phases.Track_Pop1_Minus+1;
            elseif M_File.Colocalization.Phases.Population_Status(i) == 2
                M_File.Colocalization.Phases.Track_Pop1_Plus=M_File.Colocalization.Phases.Track_Pop1_Plus+1;
            elseif M_File.Colocalization.Phases.Population_Status(i) == 3
                M_File.Colocalization.Phases.Track_Pop2_Minus=M_File.Colocalization.Phases.Track_Pop2_Minus+1;
            elseif M_File.Colocalization.Phases.Population_Status(i) == 4
                M_File.Colocalization.Phases.Track_Pop2_Plus=M_File.Colocalization.Phases.Track_Pop2_Plus+1;
            end
            
        end
    end
    
    
    
    
    
    %% Update Progress Table
    M_File.Progress(7,:)={'Colocalization Analysis', true};
    Update_Progress;
    
    %% Update Tab 5
    Update_Tab5;
    close(h);
    
end