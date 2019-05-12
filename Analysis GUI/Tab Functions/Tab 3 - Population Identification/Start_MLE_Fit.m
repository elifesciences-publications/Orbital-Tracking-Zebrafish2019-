function Start_MLE_Fit(~,~)
%% Initialize Global Variables
%Figure Variable
global MainFig;
%Variables to save data
global M_File;

%% MLE Anterograde direction
if isfield(M_File,'Dynamics') == 1
    M_File.MLE_Fit=[];
    if M_File.Dynamics.Enough_Data_Plus == 1
        %Two component MLE FIT
        if MainFig.Maintab.Tab3.Panel.Anteroselect.Select2.Value == 1
            Vel=M_File.Dynamics.Plus_XYDisplacement./M_File.Dynamics.Plus_Duration_Active_Phase';
            Vel(Vel>0.9)=[];
            [M_File.MLE_Fit.Pop1_Plus_Velocity_Temp, M_File.MLE_Fit.Pop2_Plus_Velocity_Temp, ... 
            M_File.MLE_Fit.Pop1_Plus_Velocity_Std_Temp, M_File.MLE_Fit.Pop2_Plus_Velocity_Std_Temp,...
            M_File.MLE_Fit.Plus_P_Value] = ...
            Two_component_Normal_Distribution_MlE(Vel);
            M_File.MLE_Fit.Plus=2;



        %One Component MLE Fit
        else
        [Mean,Var] = One_component_Normal_Distribution_MlE(M_File.Dynamics.Plus_XYDisplacement./M_File.Dynamics.Plus_Duration_Active_Phase');
        if MainFig.Maintab.Tab3.Panel.Anterospeed.Fast.Value == 1
            M_File.MLE_Fit.Pop1_Plus_Velocity_Temp=Mean;
            M_File.MLE_Fit.Pop1_Plus_Velocity_Std_Temp=Var;
            M_File.MLE_Fit.Pop2_Plus_Velocity_Temp=-10;
            M_File.MLE_Fit.Pop2_Plus_Velocity_Std_Temp=-10;
        else 
            M_File.MLE_Fit.Pop1_Plus_Velocity_Temp=-10;
            M_File.MLE_Fit.Pop1_Plus_Velocity_Std_Temp=-10;
            M_File.MLE_Fit.Pop2_Plus_Velocity_Temp=Mean;
            M_File.MLE_Fit.Pop2_Plus_Velocity_Std_Temp=Var;   
        end
        M_File.MLE_Fit.Plus=1;
        end
    end
end

%% MLE Retrograde direction
if isfield(M_File,'Dynamics') == 1
    if M_File.Dynamics.Enough_Data_Minus == 1
        %Two component MLE FIT
        if MainFig.Maintab.Tab3.Panel.Retroselect.Select2.Value == 1
            Vel=M_File.Dynamics.Minus_XYDisplacement./M_File.Dynamics.Minus_Duration_Active_Phase';
            Vel(Vel>0.9)=[];
            [M_File.MLE_Fit.Pop1_Minus_Velocity_Temp, M_File.MLE_Fit.Pop2_Minus_Velocity_Temp, ... 
            M_File.MLE_Fit.Pop1_Minus_Velocity_Std_Temp, M_File.MLE_Fit.Pop2_Minus_Velocity_Std_Temp,...
            M_File.MLE_Fit.Minus_P_Value] = ...
            Two_component_Normal_Distribution_MlE(Vel);
            M_File.MLE_Fit.Minus=2;



        %One Component MLE Fit
        else
        [Mean,Var] = One_component_Normal_Distribution_MlE(M_File.Dynamics.Minus_XYDisplacement./M_File.Dynamics.Minus_Duration_Active_Phase');

        if MainFig.Maintab.Tab3.Panel.Retrospeed.Fast.Value == 1
            M_File.MLE_Fit.Pop1_Minus_Velocity_Temp=Mean;
            M_File.MLE_Fit.Pop1_Minus_Velocity_Std_Temp=Var;
            M_File.MLE_Fit.Pop2_Minus_Velocity_Temp=-10;
            M_File.MLE_Fit.Pop2_Minus_Velocity_Std_Temp=-10;
        else 
            M_File.MLE_Fit.Pop1_Minus_Velocity_Temp=-10;
            M_File.MLE_Fit.Pop1_Minus_Velocity_Std_Temp=-10;
            M_File.MLE_Fit.Pop2_Minus_Velocity_Temp=Mean;
            M_File.MLE_Fit.Pop2_Minus_Velocity_Std_Temp=Var;   
        end
        M_File.MLE_Fit.Minus=1;
        end
    end
end

%% Update Progress Table
if isfield(M_File,'Dynamics') == 1
    M_File.Progress(4,:)={'MLE_Fit', true};
    Update_Progress;
end
%% Update Tab Population Identification
Update_Tab3;