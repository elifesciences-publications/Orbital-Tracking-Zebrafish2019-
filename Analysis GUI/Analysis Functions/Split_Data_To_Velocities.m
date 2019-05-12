function [Pop1_Plus, Pop2_Plus, Pop1_Minus, Pop2_Minus]=Split_Data_To_Velocities(Dynamics, Temp, General)


Pop1_Plus.Duration_Active_Phase=zeros(1,1);
    Pop2_Plus.Duration_Active_Phase=zeros(1,1);
    Pop1_Plus.Startpoint_Active_Phase=zeros(1,1);
    Pop2_Plus.Startpoint_Active_Phase=zeros(1,1);
    Pop1_Plus.XY_Displacement=zeros(1,1);
    Pop2_Plus.XY_Displacement=zeros(1,1);

if Dynamics.Enough_Data_Plus == 1
    


    delta_Pop1=abs(Temp.Pop1_Plus_Velocity_Temp*Dynamics.Plus_Duration_Active_Phase-Dynamics.Plus_XYDisplacement');
    delta_Pop2=abs(Temp.Pop2_Plus_Velocity_Temp*Dynamics.Plus_Duration_Active_Phase-Dynamics.Plus_XYDisplacement');
   

    for i=1:length(Dynamics.Plus_Duration_Active_Phase)

        %To be filled in Pop1 datapoint has to fulfill the following
        %requirements:
        % 1. delta_Pop1 has to smaller than delta_Pop2
        % 2. Has to be within 3 sigma of the velocity*distance.

        if delta_Pop1(i) < delta_Pop2(i) 

           if Pop1_Plus.Duration_Active_Phase(1) == 0
               Pop1_Plus.Duration_Active_Phase(1)=Dynamics.Plus_Duration_Active_Phase(i); 
               Pop1_Plus.Startpoint_Active_Phase(1)=Dynamics.Plus_Startpoint_Active_Phase(i); 
               Pop1_Plus.XY_Displacement(1)=Dynamics.Plus_XYDisplacement(i);
            else
               Pop1_Plus.Duration_Active_Phase(length(Pop1_Plus.Duration_Active_Phase)+1)=Dynamics.Plus_Duration_Active_Phase(i);
               Pop1_Plus.Startpoint_Active_Phase(length(Pop1_Plus.Startpoint_Active_Phase)+1)=Dynamics.Plus_Startpoint_Active_Phase(i);
               Pop1_Plus.XY_Displacement(length(Pop1_Plus.XY_Displacement)+1)=Dynamics.Plus_XYDisplacement(i);
           end

        %To be filled in Pop2 datapoint has to fulfill the following
        %requirements:
        % 1. delta_Pop has to greater than delta_Pop2
        % 2. Has to be within 3 sigma of the velocity*distance.
        elseif delta_Pop1(i) > delta_Pop2(i) 
            
            if Pop2_Plus.Duration_Active_Phase(1) == 0
               Pop2_Plus.Duration_Active_Phase(1)=Dynamics.Plus_Duration_Active_Phase(i); 
               Pop2_Plus.Startpoint_Active_Phase(1)=Dynamics.Plus_Startpoint_Active_Phase(i); 
               Pop2_Plus.XY_Displacement(1)=Dynamics.Plus_XYDisplacement(i);
            else
               Pop2_Plus.Duration_Active_Phase(length(Pop2_Plus.Duration_Active_Phase)+1)=Dynamics.Plus_Duration_Active_Phase(i);
               Pop2_Plus.Startpoint_Active_Phase(length(Pop2_Plus.Startpoint_Active_Phase)+1)=Dynamics.Plus_Startpoint_Active_Phase(i);
               Pop2_Plus.XY_Displacement(length(Pop2_Plus.XY_Displacement)+1)=Dynamics.Plus_XYDisplacement(i);
           end

        % All other data points are not considered    
        else

        end
    end




    Pop1_Plus.XYDisplacement_Mean=mean(Pop1_Plus.XY_Displacement);
    Pop1_Plus.XYDisplacement_Std=std(Pop1_Plus.XY_Displacement);
    Pop2_Plus.XYDisplacement_Mean=mean(Pop2_Plus.XY_Displacement);
    Pop2_Plus.XYDisplacement_Std=std(Pop2_Plus.XY_Displacement);
    
    Pop1_Plus.Duration_Mean=mean(Pop1_Plus.Duration_Active_Phase);
    Pop1_Plus.Duration_Std=std(Pop1_Plus.Duration_Active_Phase);
    Pop2_Plus.Duration_Mean=mean(Pop2_Plus.Duration_Active_Phase);
    Pop2_Plus.Duration_Std=std(Pop2_Plus.Duration_Active_Phase);
    
    Pop1_Plus.Velocity=mean(Pop1_Plus.XY_Displacement./Pop1_Plus.Duration_Active_Phase);
    Pop2_Plus.Velocity=mean(Pop2_Plus.XY_Displacement./Pop2_Plus.Duration_Active_Phase);
    Pop1_Plus.Velocity_std=std(Pop1_Plus.XY_Displacement./Pop1_Plus.Duration_Active_Phase);
    Pop2_Plus.Velocity_std=std(Pop2_Plus.XY_Displacement./Pop2_Plus.Duration_Active_Phase);
    
    Pop1_Plus.Orbit_Length_Active_Phase=round(Pop1_Plus.Duration_Active_Phase/General.Orbit_Time);
    Pop2_Plus.Orbit_Length_Active_Phase=round(Pop2_Plus.Duration_Active_Phase/General.Orbit_Time);
    
end



%% Minus Direction

Pop1_Minus.Duration_Active_Phase=zeros(1,1);
    Pop2_Minus.Duration_Active_Phase=zeros(1,1);
    Pop1_Minus.Startpoint_Active_Phase=zeros(1,1);
    Pop2_Minus.Startpoint_Active_Phase=zeros(1,1);
    Pop1_Minus.XY_Displacement=zeros(1,1);
    Pop2_Minus.XY_Displacement=zeros(1,1);

if Dynamics.Enough_Data_Minus == 1
    


    delta_Pop1=abs(Temp.Pop1_Minus_Velocity_Temp*Dynamics.Minus_Duration_Active_Phase-Dynamics.Minus_XYDisplacement');
    delta_Pop2=abs(Temp.Pop2_Minus_Velocity_Temp*Dynamics.Minus_Duration_Active_Phase-Dynamics.Minus_XYDisplacement');
   

    for i=1:length(Dynamics.Minus_Duration_Active_Phase)

        %To be filled in Pop1 datapoint has to fulfill the following
        %requirements:
        % 1. delta_Pop1 has to smaller than delta_Pop2
        % 2. Has to be within 3 sigma of the velocity*distance.

        if delta_Pop1(i) < delta_Pop2(i) 
            
           if Pop1_Minus.Duration_Active_Phase(1) == 0
               Pop1_Minus.Duration_Active_Phase(1)=Dynamics.Minus_Duration_Active_Phase(i); 
               Pop1_Minus.Startpoint_Active_Phase(1)=Dynamics.Minus_Startpoint_Active_Phase(i); 
               Pop1_Minus.XY_Displacement(1)=Dynamics.Minus_XYDisplacement(i);
            else
               Pop1_Minus.Duration_Active_Phase(length(Pop1_Minus.Duration_Active_Phase)+1)=Dynamics.Minus_Duration_Active_Phase(i);
               Pop1_Minus.Startpoint_Active_Phase(length(Pop1_Minus.Startpoint_Active_Phase)+1)=Dynamics.Minus_Startpoint_Active_Phase(i);
               Pop1_Minus.XY_Displacement(length(Pop1_Minus.XY_Displacement)+1)=Dynamics.Minus_XYDisplacement(i);
           end

        %To be filled in Pop2 datapoint has to fulfill the following
        %requirements:
        % 1. delta_Pop has to greater than delta_Pop2
        % 2. Has to be within 3 sigma of the velocity*distance.
        elseif delta_Pop1(i) > delta_Pop2(i) 
            
            if Pop2_Minus.Duration_Active_Phase(1) == 0
               Pop2_Minus.Duration_Active_Phase(1)=Dynamics.Minus_Duration_Active_Phase(i); 
               Pop2_Minus.Startpoint_Active_Phase(1)=Dynamics.Minus_Startpoint_Active_Phase(i); 
               Pop2_Minus.XY_Displacement(1)=Dynamics.Minus_XYDisplacement(i);
            else
               Pop2_Minus.Duration_Active_Phase(length(Pop2_Minus.Duration_Active_Phase)+1)=Dynamics.Minus_Duration_Active_Phase(i);
               Pop2_Minus.Startpoint_Active_Phase(length(Pop2_Minus.Startpoint_Active_Phase)+1)=Dynamics.Minus_Startpoint_Active_Phase(i);
               Pop2_Minus.XY_Displacement(length(Pop2_Minus.XY_Displacement)+1)=Dynamics.Minus_XYDisplacement(i);
           end

        % All other data points are not considered    
        else

        end
    end
    
    Pop1_Minus.XYDisplacement_Mean=mean(Pop1_Minus.XY_Displacement);
    Pop1_Minus.XYDisplacement_Std=std(Pop1_Minus.XY_Displacement);
    Pop2_Minus.XYDisplacement_Mean=mean(Pop2_Minus.XY_Displacement);
    Pop2_Minus.XYDisplacement_Std=std(Pop2_Minus.XY_Displacement);
    
    Pop1_Minus.Duration_Mean=mean(Pop1_Minus.Duration_Active_Phase);
    Pop1_Minus.Duration_Std=std(Pop1_Minus.Duration_Active_Phase);
    Pop2_Minus.Duration_Mean=mean(Pop2_Minus.Duration_Active_Phase);
    Pop2_Minus.Duration_Std=std(Pop2_Minus.Duration_Active_Phase);
    
    Pop1_Minus.Velocity=mean(Pop1_Minus.XY_Displacement./Pop1_Minus.Duration_Active_Phase);
    Pop2_Minus.Velocity=mean(Pop2_Minus.XY_Displacement./Pop2_Minus.Duration_Active_Phase);
    Pop1_Minus.Velocity_std=std(Pop1_Minus.XY_Displacement./Pop1_Minus.Duration_Active_Phase);
    Pop2_Minus.Velocity_std=std(Pop2_Minus.XY_Displacement./Pop2_Minus.Duration_Active_Phase);
    
    Pop1_Minus.Orbit_Length_Active_Phase=round(Pop1_Minus.Duration_Active_Phase/General.Orbit_Time);
    Pop2_Minus.Orbit_Length_Active_Phase=round(Pop2_Minus.Duration_Active_Phase/General.Orbit_Time);
    
end


end

