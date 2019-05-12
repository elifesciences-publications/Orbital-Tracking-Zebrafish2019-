function Progress_Default_Data(~,~)
%% Initialize Global Variables
%Figure Variable
global MainFig;
%Variables to save data
global M_File;

%% Update Progress Table
% Clear Data
set(MainFig.Panel.Table,'Data', ...
    {'Load Trajectory','Create .m File','Identify Active States' 'MLE Fit' 'Transfermatrix' 'Camera Trajectories' 'Colocalization Analysis'; ... 
    false false false false false false false}');

