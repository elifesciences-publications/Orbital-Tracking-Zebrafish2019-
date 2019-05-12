function Video_Settings_Controls(Control,Control2)

%% Initialize Global Variables
%Figure Variable
global MainFig;
%Variables to save data
global M_File;
%Variable for Summary
global Summary
%Variable To Store Video Information
global Video_Temp


%% Function Selection
if strcmp(Control2.EventName,'Action') == 1
    if strcmp(Control.String,'+ X') == 1
        M_File.Video_Data.XShift=...
            str2double(MainFig.Maintab.Tab5.Panel.Videopanel.XYShiftpanel.XShift_Edit.String)+1;
        MainFig.Maintab.Tab5.Panel.Videopanel.XYShiftpanel.XShift_Edit.String=...
            num2str(str2double(MainFig.Maintab.Tab5.Panel.Videopanel.XYShiftpanel.XShift_Edit.String)+1);
        Plot_Video_Frame;
        
    elseif strcmp(Control.String,'- X') == 1
        M_File.Video_Data.XShift=...
            str2double(MainFig.Maintab.Tab5.Panel.Videopanel.XYShiftpanel.XShift_Edit.String)-1;
        MainFig.Maintab.Tab5.Panel.Videopanel.XYShiftpanel.XShift_Edit.String=...
            num2str(str2double(MainFig.Maintab.Tab5.Panel.Videopanel.XYShiftpanel.XShift_Edit.String)-1);
        Plot_Video_Frame;
        
    elseif strcmp(Control.String,'+ Y') == 1
        M_File.Video_Data.YShift=...
            str2double(MainFig.Maintab.Tab5.Panel.Videopanel.XYShiftpanel.YShift_Edit.String)+1;
        MainFig.Maintab.Tab5.Panel.Videopanel.XYShiftpanel.YShift_Edit.String=...
            num2str(str2double(MainFig.Maintab.Tab5.Panel.Videopanel.XYShiftpanel.YShift_Edit.String)+1);
        Plot_Video_Frame;
        
    elseif strcmp(Control.String,'- Y') == 1
        M_File.Video_Data.YShift=...
            str2double(MainFig.Maintab.Tab5.Panel.Videopanel.XYShiftpanel.YShift_Edit.String)-1;
        MainFig.Maintab.Tab5.Panel.Videopanel.XYShiftpanel.YShift_Edit.String=...
            num2str(str2double(MainFig.Maintab.Tab5.Panel.Videopanel.XYShiftpanel.YShift_Edit.String)-1);
        Plot_Video_Frame;
        
    end
    
    
    
    %% Frame Shift
    if strcmp(Control.String,'>') == 1
        M_File.Video_Data.Frame_Shift=...
            str2double(MainFig.Maintab.Tab5.Panel.Videopanel.Frameshift.Frameshift_Edit.String)+1;
        MainFig.Maintab.Tab5.Panel.Videopanel.Frameshift.Frameshift_Edit.String=...
            num2str(str2double(MainFig.Maintab.Tab5.Panel.Videopanel.Frameshift.Frameshift_Edit.String)+1);
        Plot_Video_Frame;
        
    elseif strcmp(Control.String,'<') == 1
        M_File.Video_Data.Frame_Shift=...
            str2double(MainFig.Maintab.Tab5.Panel.Videopanel.Frameshift.Frameshift_Edit.String)-1;
        MainFig.Maintab.Tab5.Panel.Videopanel.Frameshift.Frameshift_Edit.String=...
            num2str(str2double(MainFig.Maintab.Tab5.Panel.Videopanel.Frameshift.Frameshift_Edit.String)-1);
        Plot_Video_Frame;
    end
    
    
    %% Render Video
    if strcmp(Control.String,'Render Video') == 1
        Render_Video;
    end
    
end


%% Overlay Mode
if strcmp(Control2.EventName,'SelectionChanged') == 1
    Plot_Video_Frame;
end





