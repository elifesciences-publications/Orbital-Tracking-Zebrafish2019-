function Transition_Histogram(~,Eventdata)
%% Initialize Global Variables
%Figure Variable
global MainFig;
%Variables to save data
global M_File;
%Variable for Summary
global Summary
%Variable To Store Video Information
global Video_Temp

Coordinates=Eventdata.Indices;

%Create Histogram

xhist=0:1:40;
Data=M_File.Transition.Pause{Coordinates(1),Coordinates(2)}*M_File.Trajectory.Orbit_Time;
Data=Data(Data>0);
yhist=hist(Data,xhist);
axes(MainFig.Maintab.Tab3.Panel.Tab.Tab4.Panel.Fig1)
bar(xhist,yhist);
MainFig.Maintab.Tab3.Panel.Tab.Tab4.Panel.Fig1.XLim=[-0.5 40.5];
MainFig.Maintab.Tab3.Panel.Tab.Tab4.Panel.Fig1.YLim=[0 max(yhist)+1];


