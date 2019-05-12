function Trajectory_Selection(~,New)

%% Initialize Global Variables
%Figure Variable
global MainFig;
%Variables to save data
global M_File;
%Variable for Summary
global Summary

Temp=MainFig.Maintab.Tab4.Panel.Tab.Tab1.Table.Data;
%% Change Ticks depending on selection
if strcmp(New.NewValue.String,'Only Retrograde') == 1
    for i=1:length(Temp(:,1))
        if strcmp(Temp{i,3},'Retrograde') == 1
            Temp{i,2}=true;
        else
            Temp{i,2}=false;
        end
    end
elseif strcmp(New.NewValue.String,'Only Anterograde') == 1
    for i=1:length(Temp(:,1))
        if strcmp(Temp{i,3},'Anterograde') == 1
            Temp{i,2}=true;
        else
            Temp{i,2}=false;
        end
    end
elseif strcmp(New.NewValue.String,'All Trajectories') == 1
    for i=1:length(Temp(:,1))
        Temp{i,2}=true;
    end
end
MainFig.Maintab.Tab4.Panel.Tab.Tab1.Table.Data=Temp;

