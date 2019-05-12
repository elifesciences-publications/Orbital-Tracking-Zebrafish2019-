function [ Dynamics, Transition] = Fill_Population_Status_Array(General,Dynamics, Passive,Pop1_Plus,Pop2_Plus,Pop1_Minus,Pop2_Minus);

%Fills population array with the correct phase for each timepoint:
% Passive= 'c' [0 1 1]
% Active: 
%   Pop1_Plus='g' [0 1 0]
%   Pop1_Minus='r' [1 0 0]
%   Pop2_Plus & Pop2_Minus='b' [0 0 1]
Trajectory_Length=length(General.Trajectory(:,1));

if Dynamics.Enough_Data_Plus == 0
    Pop1_Plus.Startpoint_Active_Phase=0;
    Pop1_Plus.Orbit_Length_Active_Phase=0;
    Pop2_Plus.Startpoint_Active_Phase=0;
    Pop2_Plus.Orbit_Length_Active_Phase=0;
end

if Dynamics.Enough_Data_Minus == 0
    Pop1_Minus.Startpoint_Active_Phase=0;
    Pop1_Minus.Orbit_Length_Active_Phase=0;
    Pop2_Minus.Startpoint_Active_Phase=0;
    Pop2_Minus.Orbit_Length_Active_Phase=0;
end

% Generate RGB_Population_Status Array and remove not fitted active phases
Dynamics.RGB_Population_Status=ones(Trajectory_Length,3).*1;
Dynamics.RGB_Population_Status(:,2)=ones(Trajectory_Length,1)*1;
Dynamics.RGB_Population_Status(:,3)=ones(Trajectory_Length,1)*0;

%Generate Population Status Array
Dynamics.Population_Status=zeros(Trajectory_Length,1);

%% Fill in Pop1_Plus
if Dynamics.Enough_Data_Plus == 1
    for i=1:length(Pop1_Plus.Startpoint_Active_Phase)
        TempPopRGB=[0 1 0];
        TempPopRGB=repmat(TempPopRGB,Pop1_Plus.Orbit_Length_Active_Phase(i),1);
        Dynamics.RGB_Population_Status(Pop1_Plus.Startpoint_Active_Phase(i):Pop1_Plus.Startpoint_Active_Phase(i)+Pop1_Plus.Orbit_Length_Active_Phase(i)-1,:)=TempPopRGB;   
        TempPop=ones(Pop1_Plus.Orbit_Length_Active_Phase(i),1)*2;
        Dynamics.Population_Status(Pop1_Plus.Startpoint_Active_Phase(i):Pop1_Plus.Startpoint_Active_Phase(i)+Pop1_Plus.Orbit_Length_Active_Phase(i)-1,:)=TempPop;   
    end
    
end


%% Fill in Pop1_Minus
if Dynamics.Enough_Data_Minus == 1
    for i=1:length(Pop1_Minus.Startpoint_Active_Phase)
        TempPopRGB=[1 0 0];
        TempPopRGB=repmat(TempPopRGB,Pop1_Minus.Orbit_Length_Active_Phase(i),1);
        Dynamics.RGB_Population_Status(Pop1_Minus.Startpoint_Active_Phase(i):Pop1_Minus.Startpoint_Active_Phase(i)+Pop1_Minus.Orbit_Length_Active_Phase(i)-1,:)=TempPopRGB;   
        TempPop=ones(Pop1_Minus.Orbit_Length_Active_Phase(i),1)*1;
        Dynamics.Population_Status(Pop1_Minus.Startpoint_Active_Phase(i):Pop1_Minus.Startpoint_Active_Phase(i)+Pop1_Minus.Orbit_Length_Active_Phase(i)-1,:)=TempPop;   

    end
end


%% Fill in Pop2_Plus

if Dynamics.Enough_Data_Plus == 1
    for i=1:length(Pop2_Plus.Startpoint_Active_Phase)
        TempPopRGB=[0 0 1];
        TempPopRGB=repmat(TempPopRGB,Pop2_Plus.Orbit_Length_Active_Phase(i),1);
        Dynamics.RGB_Population_Status(Pop2_Plus.Startpoint_Active_Phase(i):Pop2_Plus.Startpoint_Active_Phase(i)+Pop2_Plus.Orbit_Length_Active_Phase(i)-1,:)=TempPopRGB;   
        TempPop=ones(Pop2_Plus.Orbit_Length_Active_Phase(i),1)*4;
        Dynamics.Population_Status(Pop2_Plus.Startpoint_Active_Phase(i):Pop2_Plus.Startpoint_Active_Phase(i)+Pop2_Plus.Orbit_Length_Active_Phase(i)-1,:)=TempPop;   

    end
end



%% Fill in Pop2_Minus
if Dynamics.Enough_Data_Minus == 1
    for i=1:length(Pop2_Minus.Startpoint_Active_Phase)
        TempPopRGB=[1 0 1];
        TempPopRGB=repmat(TempPopRGB,Pop2_Minus.Orbit_Length_Active_Phase(i),1);
        Dynamics.RGB_Population_Status(Pop2_Minus.Startpoint_Active_Phase(i):Pop2_Minus.Startpoint_Active_Phase(i)+Pop2_Minus.Orbit_Length_Active_Phase(i)-1,:)=TempPopRGB;   
        TempPop=ones(Pop2_Minus.Orbit_Length_Active_Phase(i),1)*3;
        Dynamics.Population_Status(Pop2_Minus.Startpoint_Active_Phase(i):Pop2_Minus.Startpoint_Active_Phase(i)+Pop2_Minus.Orbit_Length_Active_Phase(i)-1,:)=TempPop;   

    end
end



%% Create Array with removed time length information of each phase.
Pop_Temp=Dynamics.Population_Status(1);
Dynamics.Shrinked_Population_Status=Dynamics.Population_Status(1);
for i=1:length(Dynamics.Population_Status)
    if Pop_Temp ~= Dynamics.Population_Status(i)
        Dynamics.Shrinked_Population_Status(length(Dynamics.Shrinked_Population_Status)+1)=Dynamics.Population_Status(i);
        Pop_Temp=Dynamics.Population_Status(i);
    
    end
end
Dynamics.Shrinked_Population_Status(Dynamics.Shrinked_Population_Status==0)=[];
%% Create Transitions
Transition.Matrix=zeros(4,4);
Transition.Pause=zeros(4,4);
Transition.Pause=num2cell(Transition.Pause);
if length(Passive.Orbit_Length_Passive_Phase) <length(Dynamics.Shrinked_Population_Status)
    Temp=2;
else
    Temp=1;
end
for i=1:length(Dynamics.Shrinked_Population_Status)-Temp
    Transition.Matrix(Dynamics.Shrinked_Population_Status(i),Dynamics.Shrinked_Population_Status(i+1))=Transition.Matrix(Dynamics.Shrinked_Population_Status(i),Dynamics.Shrinked_Population_Status(i+1))+1;  
    Transition.Pause(Dynamics.Shrinked_Population_Status(i),Dynamics.Shrinked_Population_Status(i+1))=mat2cell([cell2mat(Transition.Pause(Dynamics.Shrinked_Population_Status(i),Dynamics.Shrinked_Population_Status(i+1))) Passive.Orbit_Length_Passive_Phase(i+1)],1,length(cell2mat(Transition.Pause(Dynamics.Shrinked_Population_Status(i),Dynamics.Shrinked_Population_Status(i+1))))+1);


end






end

