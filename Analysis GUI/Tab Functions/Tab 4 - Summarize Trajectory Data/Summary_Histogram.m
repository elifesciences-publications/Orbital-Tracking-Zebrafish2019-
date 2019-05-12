function Summary_Histogram(~,Eventdata)
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
Data=Summary.Transition.Pause{Coordinates(1),Coordinates(2)}*0.01;
Data=Data(Data>0);
yhist=hist(Data,xhist);
axes(MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab4.Panel.Fig1)
bar(xhist,yhist);
MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab4.Panel.Fig1.XLim=[-0.5 40.5];
MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab4.Panel.Fig1.YLim=[0 max(yhist)+1];