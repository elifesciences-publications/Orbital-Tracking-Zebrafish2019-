function Render_Video(~,~)
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
    [fileName,filePath]=uiputfile('*.tif','Save Merged Video as');
    Filename=fullfile(filePath,fileName);
    if fileName ~= 0
        h=waitbar(0,'Render Video','WindowStyle','modal');
        for i=1:size(Video_Temp.Tifstack,3)
            Frame=i;
            waitbar(i/size(Video_Temp.Tifstack,3));
            try
                Image=Render_Image(Frame);
                imwrite(double(Image),Filename, 'tif','WriteMode','append','Compression','none');
            catch
            end
        end
        close(h)
    end
end


