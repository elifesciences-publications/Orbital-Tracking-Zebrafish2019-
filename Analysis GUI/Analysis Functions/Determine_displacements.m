function [Dynamics] = Determine_displacements(Trajectory, Orbit_Time, Dynamics)
%DETERMINE_LATERAL_DISPLACEMENT Calculates the Displacement along a trajectory along XY, XYZ and ZMax-ZMin
%

if Dynamics.Enough_Data_Plus == 1

Stepsize=1;
Dynamics.Plus_XYDisplacement=zeros(size(Dynamics.Plus_Length_Active_Phase,2),1);
Dynamics.Plus_XYZDisplacement=zeros(size(Dynamics.Plus_Length_Active_Phase,2),1);
Dynamics.Plus_Weights=Dynamics.Plus_Length_Active_Phase;

for i=1:size(Dynamics.Plus_Length_Active_Phase,2)
    Distance_Points=(Dynamics.Plus_Length_Active_Phase(i)-mod(Dynamics.Plus_Length_Active_Phase(i),Stepsize))/Stepsize;
    Distance_XY_Temp=zeros(Distance_Points,1);
    Distance_XYZ_Temp=zeros(Distance_Points,1);
    for j=1:Distance_Points
        squaredx=(Trajectory(Dynamics.Plus_Startpoint_Active_Phase(i)+j*Stepsize,1)-Trajectory(Dynamics.Plus_Startpoint_Active_Phase(i)+(j-1)*Stepsize,1))^2;
        squaredy=(Trajectory(Dynamics.Plus_Startpoint_Active_Phase(i)+j*Stepsize,2)-Trajectory(Dynamics.Plus_Startpoint_Active_Phase(i)+(j-1)*Stepsize,2))^2;
        squaredz=(Trajectory(Dynamics.Plus_Startpoint_Active_Phase(i)+j*Stepsize,3)-Trajectory(Dynamics.Plus_Startpoint_Active_Phase(i)+(j-1)*Stepsize,3))^2;

        Distance_XY_Temp(j)=sqrt(squaredx+squaredy);
        Distance_XYZ_Temp(j)=sqrt(squaredx+squaredy+squaredz);
    end
    
    Dynamics.Plus_XYDisplacement(i)=sum(Distance_XY_Temp);
    Dynamics.Plus_XYZDisplacement(i)=sum(Distance_XYZ_Temp);
end

Dynamics.Plus_Duration_Active_Phase=Dynamics.Plus_Length_Active_Phase*Orbit_Time;
end

%Minus Direction.

if Dynamics.Enough_Data_Minus == 1

Stepsize=1;
Dynamics.Minus_XYDisplacement=zeros(size(Dynamics.Minus_Length_Active_Phase,2),1);
Dynamics.Minus_XYZDisplacement=zeros(size(Dynamics.Minus_Length_Active_Phase,2),1);
Dynamics.Minus_Weights=Dynamics.Minus_Length_Active_Phase;

for i=1:size(Dynamics.Minus_Length_Active_Phase,2)
    Distance_Points=(Dynamics.Minus_Length_Active_Phase(i)-mod(Dynamics.Minus_Length_Active_Phase(i),Stepsize))/Stepsize;
    Distance_XY_Temp=zeros(Distance_Points,1);
    Distance_XYZ_Temp=zeros(Distance_Points,1);
    for j=1:Distance_Points
        squaredx=(Trajectory(Dynamics.Minus_Startpoint_Active_Phase(i)+j*Stepsize,1)-Trajectory(Dynamics.Minus_Startpoint_Active_Phase(i)+(j-1)*Stepsize,1))^2;
        squaredy=(Trajectory(Dynamics.Minus_Startpoint_Active_Phase(i)+j*Stepsize,2)-Trajectory(Dynamics.Minus_Startpoint_Active_Phase(i)+(j-1)*Stepsize,2))^2;
        squaredz=(Trajectory(Dynamics.Minus_Startpoint_Active_Phase(i)+j*Stepsize,3)-Trajectory(Dynamics.Minus_Startpoint_Active_Phase(i)+(j-1)*Stepsize,3))^2;

        Distance_XY_Temp(j)=sqrt(squaredx+squaredy);
        Distance_XYZ_Temp(j)=sqrt(squaredx+squaredy+squaredz);
    end
    
    Dynamics.Minus_XYDisplacement(i)=sum(Distance_XY_Temp);
    Dynamics.Minus_XYZDisplacement(i)=sum(Distance_XYZ_Temp);
    
end

Dynamics.Minus_Duration_Active_Phase=Dynamics.Minus_Length_Active_Phase*Orbit_Time;
end



end

