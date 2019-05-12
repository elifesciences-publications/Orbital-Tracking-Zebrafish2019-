function Trajectory_Table_Default_Data(~,~)

%% Initialize Global Variables
%Figure Variable
global MainFig;
%Variables to save data
global M_File;

%% Set Data
set(MainFig.Maintab.Tab1.Panel.Table,'ColumnName',{'Filepath' 'Filename' 'Total # or Orbits' 'Total Time' 'Orbit Time' ... 
    'Delay Orbits' '# of Particles' 'Long Range Treshold' 'Orbit Radius'});
Temp= {[] [] [] [] [] [] [] [] []; ... 
    '-' '-' 'Orbits' 's' 'ms' '-' '-' 'µm' 'nm' };
set(MainFig.Maintab.Tab1.Panel.Table,'Data',Temp);




