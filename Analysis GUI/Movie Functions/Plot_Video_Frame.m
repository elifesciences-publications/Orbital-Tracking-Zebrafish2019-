function Plot_Video_Frame(~,~)

%% Initialize Global Variables
%Figure Variable
global MainFig;
%Variables to save data
global M_File;
%Variable for Summary
global Summary
%Variable To Store Video Information
global Video_Temp

if isfield(Video_Temp,'Current_Frame') == 1
Image=Render_Image(Video_Temp.Current_Frame);
MainFig.Maintab.Tab5.Panel.Fig1_Image.CData=Image;
end

