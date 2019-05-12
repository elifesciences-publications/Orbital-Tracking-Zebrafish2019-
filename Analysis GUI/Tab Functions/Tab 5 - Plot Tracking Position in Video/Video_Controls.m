function Video_Controls(Control,Control2)

%% Initialize Global Variables
%Figure Variable
global MainFig;
%Variables to save data
global M_File;
%Variable for Summary
global Summary
%Variable To Store Video Information
global Video_Temp


if isfield(Video_Temp,'Tifstack') == 1
    if strcmp(Control2.EventName,'Action')==1
        %% Play/Pause Button
        if strcmp(Control.String,'Play/Pause')==1
            while MainFig.Maintab.Tab5.Panel.Play_Button.Value == 1
                
                Video_Temp.Current_Frame=Video_Temp.Current_Frame+1;
                if Video_Temp.Current_Frame > Video_Temp.Frames
                    Video_Temp.Current_Frame=1;
                end
                MainFig.Maintab.Tab5.Panel.CurrentTime_Edit.String=num2str(round(Video_Temp.Current_Frame*str2double(MainFig.Maintab.Tab5.Panel.Frame_Rate_Edit.String)/1000));
                
                Plot_Video_Frame;
                if strcmp(MainFig.Maintab.Tab5.Panel.Videospeed.Handle.SelectedObject.String,'1x') == 1
                    pause(str2double(MainFig.Maintab.Tab5.Panel.Frame_Rate_Edit.String)/(1000*1))
                elseif strcmp(MainFig.Maintab.Tab5.Panel.Videospeed.Handle.SelectedObject.String,'4x') == 1
                    pause(str2double(MainFig.Maintab.Tab5.Panel.Frame_Rate_Edit.String)/(1000*4))
                elseif strcmp(MainFig.Maintab.Tab5.Panel.Videospeed.Handle.SelectedObject.String,'16x') == 1
                    pause(str2double(MainFig.Maintab.Tab5.Panel.Frame_Rate_Edit.String)/(1000*16))
                elseif strcmp(MainFig.Maintab.Tab5.Panel.Videospeed.Handle.SelectedObject.String,'64x') == 1
                    pause(str2double(MainFig.Maintab.Tab5.Panel.Frame_Rate_Edit.String)/(1000*64))
                end
                
                MainFig.Maintab.Tab5.Panel.Slider.Value=Video_Temp.Current_Frame/Video_Temp.Frames;
                
                
            end
        end
               
        %% Forward
        
        if strcmp(Control.String,'>') == 1
            Video_Temp.Current_Frame=Video_Temp.Current_Frame+1;
            if Video_Temp.Current_Frame > Video_Temp.Frames
                Video_Temp.Current_Frame=1;
            end
            MainFig.Maintab.Tab5.Panel.CurrentTime_Edit.String=num2str(round(Video_Temp.Current_Frame*str2double(MainFig.Maintab.Tab5.Panel.Frame_Rate_Edit.String)/1000));
            Plot_Video_Frame;
            MainFig.Maintab.Tab5.Panel.Slider.Value=Video_Temp.Current_Frame/Video_Temp.Frames;
        end
        
        %% Backward
        if strcmp(Control.String,'<') == 1
            Video_Temp.Current_Frame=Video_Temp.Current_Frame-1;
            if Video_Temp.Current_Frame == 0
                Video_Temp.Current_Frame=1;
            end
            MainFig.Maintab.Tab5.Panel.CurrentTime_Edit.String=num2str(round(Video_Temp.Current_Frame*str2double(MainFig.Maintab.Tab5.Panel.Frame_Rate_Edit.String)/1000));
            Plot_Video_Frame;
            MainFig.Maintab.Tab5.Panel.Slider.Value=Video_Temp.Current_Frame/Video_Temp.Frames;
        end
        
        %% Slider
        if strcmp(Control.String,'Slider') == 1
            Video_Temp.Current_Frame=round(MainFig.Maintab.Tab5.Panel.Slider.Value*Video_Temp.Frames);
            if Video_Temp.Current_Frame==0
                Video_Temp.Current_Frame=1;
            end
            MainFig.Maintab.Tab5.Panel.CurrentTime_Edit.String=num2str(round(Video_Temp.Current_Frame*str2double(MainFig.Maintab.Tab5.Panel.Frame_Rate_Edit.String)/1000));
            Plot_Video_Frame;
        end
        
        %% Unload Video
        if strcmp(Control.String,'Unload Video') == 1
            Video_Temp=[];
            MainFig.Maintab.Tab5.Panel.Fig1_Image.CData=ones(512,512,3);
            MainFig.Maintab.Tab5.Panel.Fig1_Image.HitTest = 'off';
            MainFig.Maintab.Tab5.Panel.Fig1.ButtonDownFcn = @Video_Controls;
            MainFig.Maintab.Tab5.Panel.Slider.Value=0;
        end
        
    end
end

%% Load Video
if strcmp(Control2.EventName,'Hit') == 1
    if isfield(Video_Temp,'Tifstack') == 0
        [Video_Temp.Tifstack]=Read_Tifstack;
        Video_Temp.Current_Frame=1;
        Video_Temp.Frames=length(Video_Temp.Tifstack(1,1,:));
        %% Plot first Frame into Video
        MainFig.Maintab.Tab5.Panel.Fig1_Image.CData=repmat(Video_Temp.Tifstack(:,:,1),1,1,3);
        MainFig.Maintab.Tab5.Panel.Slider.Value=Video_Temp.Current_Frame/Video_Temp.Frames;
        Plot_Video_Frame;
    end
    
end
