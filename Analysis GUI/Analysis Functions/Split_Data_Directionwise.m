function [Dynamics] = Split_Data_Directionwise(Trajectory, Dynamics )
%SPLIT_DATA_DIRECTIONWISE Splits the Active Phases directionwise
%   Detailed explanation goes here



%% 1. Determine the direction of movement for each active Phase
Phi=zeros(length(Dynamics.Startpoint_Active_Phase),1);
for i=1:length(Dynamics.Startpoint_Active_Phase)
    dx=Trajectory(Dynamics.Startpoint_Active_Phase(i)+Dynamics.Length_Active_Phase(i),1)-Trajectory(Dynamics.Startpoint_Active_Phase(i),1);
    dy=Trajectory(Dynamics.Startpoint_Active_Phase(i)+Dynamics.Length_Active_Phase(i),2)-Trajectory(Dynamics.Startpoint_Active_Phase(i),2);
    
    if dx > 0
       Phi(i)=atan(dy/dx);
   elseif dx== 0
       Phi(i)=sign(dy)*pi/2;
   elseif dx < 0 && dy >= 0
       Phi(i)=atan(dy/dx)+pi;
   elseif dx < 0 && dy < 0
       Phi(i)=atan(dy/dx)-pi;
   end
    
    
    
    
end

%% 2. Seperate Active Phases into + and - direction
Dynamics.Plus_Startpoint_Active_Phase=zeros(1,1);
Dynamics.Minus_Startpoint_Active_Phase=zeros(1,1);
Dynamics.Plus_Length_Active_Phase=zeros(1,1);
Dynamics.Minus_Length_Active_Phase=zeros(1,1);
for i=1:length(Dynamics.Startpoint_Active_Phase)
   if Phi(i) > 0
       if Dynamics.Plus_Startpoint_Active_Phase(1) == 0
           Dynamics.Plus_Startpoint_Active_Phase(1)= Dynamics.Startpoint_Active_Phase(i);
       else
           Dynamics.Plus_Startpoint_Active_Phase(length(Dynamics.Plus_Startpoint_Active_Phase)+1)= Dynamics.Startpoint_Active_Phase(i);
       end
       
       if Dynamics.Plus_Length_Active_Phase(1) == 0
           Dynamics.Plus_Length_Active_Phase(1)= Dynamics.Length_Active_Phase(i);
       else
           Dynamics.Plus_Length_Active_Phase(length(Dynamics.Plus_Length_Active_Phase)+1)= Dynamics.Length_Active_Phase(i);
       end
       
       
   else
       if Dynamics.Minus_Startpoint_Active_Phase(1) == 0
           Dynamics.Minus_Startpoint_Active_Phase(1)= Dynamics.Startpoint_Active_Phase(i);
       else
           Dynamics.Minus_Startpoint_Active_Phase(length(Dynamics.Minus_Startpoint_Active_Phase)+1)= Dynamics.Startpoint_Active_Phase(i);
       end
       
       if Dynamics.Minus_Length_Active_Phase(1) == 0
           Dynamics.Minus_Length_Active_Phase(1)= Dynamics.Length_Active_Phase(i);
       else
           Dynamics.Minus_Length_Active_Phase(length(Dynamics.Minus_Length_Active_Phase)+1)= Dynamics.Length_Active_Phase(i);
       end
       
   end
    
   
end

clear x
clear y


if length(Dynamics.Plus_Startpoint_Active_Phase) >= 2
   Dynamics.Enough_Data_Plus=1;
else
   Dynamics.Enough_Data_Plus=0;  
end

if length(Dynamics.Minus_Startpoint_Active_Phase) >= 2
   Dynamics.Enough_Data_Minus=1;
else
   Dynamics.Enough_Data_Minus=0;  
end

end

