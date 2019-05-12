function [Dynamics, Passive, Smooth_Corr_Phi, Treshold, Active_Phase_Temp] = Identify_active_states( General, Dynamics, par, Active_Treshold, Correlation_Window)
% IDENTIFICATION_OF_ACTIVE_STATES This function determines the active states via a correlation analysis and a randomized treshold.
% This function determines the active states of mitochondria movement within
% nerve axons in zebrafish. This functions performs the following steps:
%
%--------------------------------------------------------------------------
%
% 1. Calculation of the angular movement in the trajectory in polar
% coordinates: 
%
% The angle phi determines the movement in the xy plane and is
% used for all further calculations since the directed movement happens
% mainly in the xy plane.
%
% Variables:
% Phi: Azimuth angle 
% Theta: Polar angle
% R: radius
%
%--------------------------------------------------------------------------
%
% 2. Check for correlating movement with a sliding correlation window:
%
% Active transport of mitochondria is characterized by a high corelation of
% subsequent steps. A sliding autocorrelation window is used to create a
% correlation carpet.
%
% Variables:
% Corr_Window: Size of the sliding correlation window
% Corr_Phi: Correlation Carpet for the whole trajectory
%
%--------------------------------------------------------------------------
%
% 3. Calculate a randomized treshold for active states:
%
% To determine active phases a treshold level is needed to seperate active 
% phases from by chance correlating random walks. This threshold is
% generated by randomizing Phi and perform again then sliding
% autocorrelation window. 
%
% Variables: 
% Rnd_Phi: randomized Phi vector
% Rand_Corr_Phi: Correlation carpet of randomized Phi
%
%--------------------------------------------------------------------------
%
% 4. Select a vector along the orbit axis to reduce the carpet to a 1D
% vector:
%
% The mean value of lagtimes 2 to 12 is used to create the 1D vectors for
% the Correlation and randomized correlation. In addition the vectors are
% smoothed by 5 points to reduce spikes. The treshold for an active phase
% is then calculated by calculating 5 sigma. 
%
% Variables:
% Smooth_Corr_Phi: 1D vector of correlation values
% Smooth_Rand_Corr_Phi: 1D vector of randomized correlation values
% Treshold: 5*sigma of Smooth_Rand_Corr_Phi -> Treshold for an active phase
%
%--------------------------------------------------------------------------
%
% 5. Determine active states:
% 
% In the first step a vector with active steps is created. In the next step
% an algorithm creates two vectors with the startpoint of an active phase
% and the duration in units of the orbit time. In addition a second
% treshold is applied which sorts out active phases which duration is less
% than ~100 ms to be sure that no hopping between particles or even the
% long range tracking movement is counted as an active phase. This value
% should be around 80 to 100 ms.
%
% Variables:
% Orbit_Treshold: Min. length of active phases.
% Active_States: A boolean 1D vector indicating a passive (=0) or active
% state (=1) for each step.
% Startpoint_Active_Phase: A vector with each startpoint of each active phase
% Length_Active_Phase: A vector with the length of each active phase
%
%--------------------------------------------------------------------------

% 1. Calculate Angular Movement for Theta and Phi
Data_Points=length(General.Trajectory);
R=zeros(Data_Points,1);
Theta=zeros(Data_Points,1);
Phi=zeros(Data_Points,1);

for i=1:Data_Points-1
   dx=General.Trajectory(i+1,1)-General.Trajectory(i,1);
   dy=General.Trajectory(i+1,2)-General.Trajectory(i,2);
   dz=General.Trajectory(i+1,3)-General.Trajectory(i,3);
   
   R(i)=sqrt(dx^2+dy^2+dz^2);
   Theta(i)=acos(dz/R(i));
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

clear dx
clear dy
clear dz
clear i
%
%--------------------------------------------------------------------------
%
% 2. Check for correlating movement with a sliding correlation window:
Corr_Phi=zeros(length(Phi)-Correlation_Window,2*Correlation_Window+1);
if strcmp('Parfor',par) == true
    h=waitbar(0,'Compute Correlation','WindowStyle','modal');
    waitbar(0.25)
%     set(h,'WindowStyle','modal')
    parfor i=1:length(Phi)-Correlation_Window-1
        Corr_Phi(i,:)=xcorr(Phi(i:i+Correlation_Window),'coeff');
    end
    waitbar(0.5)
else
    h=waitbar(0,'Compute Correlation','WindowStyle','modal');
    for i=1:length(Phi)-Correlation_Window-1
        Corr_Phi(i,:)=xcorr(Phi(i:i+Correlation_Window),'coeff');
        waitbar(i/(length(Phi)-Correlation_Window-1));
    end
    close(h)
end
%
%--------------------------------------------------------------------------
%
% 3. Calculate a randomized treshold for active states:
Phi_Temp=[Phi;Phi*-1];
Rnd_Phi=Phi_Temp(randperm(length(Phi_Temp)));
Rand_Corr_Phi=zeros(length(Phi)-Correlation_Window,2*Correlation_Window+1);
if strcmp('Parfor',par) == true
    waitbar(0.75)
    parfor i=1:length(Phi)-Correlation_Window-1
        Rand_Corr_Phi(i,:)=xcorr(Rnd_Phi(i:i+Correlation_Window),'coeff');
    end
    waitbar(1)
    close(h)
else
    h=waitbar(0,'Compute Randomized Correlation','WindowStyle','modal');
    set(h,'WindowStyle','modal')
    for i=1:length(Phi)-Correlation_Window-1
        Rand_Corr_Phi(i,:)=xcorr(Rnd_Phi(i:i+Correlation_Window),'coeff');
        waitbar(i/(length(Phi)-Correlation_Window-1));
    end
    close(h)
end
%
%--------------------------------------------------------------------------
%
% 4. Select a vector along the orbit axis to reduce the carpet to a 1D
% vector:
Smooth_Corr_Phi=((mean(Corr_Phi(:,round(Correlation_Window*1.05):round(Correlation_Window*1.1)),2)));
Smooth_Rand_Corr_Phi=((mean(Rand_Corr_Phi(:,round(Correlation_Window*1.05):round(Correlation_Window*1.1)),2)));
Treshold=Active_Treshold*std(Smooth_Rand_Corr_Phi)+mean(Smooth_Rand_Corr_Phi);
%
%--------------------------------------------------------------------------
%5. Determine active states:
% Calculate Vector with active States which are longer than the treshold.
Active_Phase=Smooth_Corr_Phi>Treshold;
Active_Phase=circshift(Active_Phase,Correlation_Window/2);
Active_Phase(end)=0;
Active_Phase_Temp=Active_Phase;
i=1;
t=1;
while i <= length(Active_Phase)
   if Active_Phase(i) == 1
       
       j=1;
       while Active_Phase(i+j) == 1
           j=j+1;
            
       end
       if j >= Dynamics.Orbit_Treshold
           Dynamics.Startpoint_Active_Phase(t)=i;
           Dynamics.Length_Active_Phase(t)=j;
           t=t+1;
       else
           Active_Phase(i:i+j-1)=zeros(j,1);
       end
       i=i+1+j;
   else
        i=i+1;
   end
end
  
  
  
 

 
 % Determine Passive States
 Passive_Phase=ones(length(Active_Phase),1)-Active_Phase;
 Passive_Phase(end,1)=0;
 i=1;
 t=1;
 Passive_Treshold=1;
while i <= length(Passive_Phase)
   if Passive_Phase(i) == 1
       
       j=1;
       while Passive_Phase(i+j) == 1
           j=j+1;
            
       end
       if j >= Passive_Treshold
           Passive.Startpoint_Passive_Phase(t)=i;
           Passive.Orbit_Length_Passive_Phase(t)=j;
           t=t+1;
       else
           Passive_Phase(i:i+j-1)=zeros(j,1);
       end
       i=i+1+j;
   else
        i=i+1;
   end
end
end



