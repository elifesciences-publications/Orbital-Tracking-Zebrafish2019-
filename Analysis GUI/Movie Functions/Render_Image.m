function Image=Render_Image(Frame)
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
    %% Plot Crosshair with and without Population Status
    
    %Create an RGB Image
    if strcmp(MainFig.Maintab.Tab5.Panel.Videopanel.VideoMode.Image_Mode.Handle.SelectedObject.String,...
            'Raw Image') == 1
        Image=Video_Temp.Tifstack(:,:,Frame);
        
        
        
        if strcmp(MainFig.Maintab.Tab5.Panel.Videopanel.VideoMode.Transpose_Image.Handle.SelectedObject.String,...#
                'Transposed') == 1
            Image=Image';
        end
        Image=repmat(Image,[1 1 3]);
        MaxI=0.3*max(max(Video_Temp.Tifstack(:,:,Frame)));
        Image=imadjust(Image,[0 0 0; MaxI MaxI MaxI],[]);
        %Image = imcomplement(Image);
    elseif strcmp(MainFig.Maintab.Tab5.Panel.Videopanel.VideoMode.Image_Mode.Handle.SelectedObject.String,...
            'BW Image') == 1
        SmoothImage=smooth2a(Video_Temp.Tifstack(:,:,Frame),5,5);
        Treshold=mean(mean(SmoothImage))+6*std(std(SmoothImage));
        BWImage=im2bw(SmoothImage,Treshold);
        Image=repmat(BWImage,1,1,3);
        
        
    end
    
    if isfield(M_File,'Video_Data') == 1
        %Select Video Mode
        
        %Case Crosshair without Population Information
        if strcmp(MainFig.Maintab.Tab5.Panel.Videopanel.VideoMode.Overlay.Handle.SelectedObject.String,...
                'Crosshair without Population Information') == 1
            
            R=1;
            G=0;
            B=0;
            %Plot Cross in Video
            if Frame <= size(Video_Temp.Tifstack,3) && Frame >= 1
                if strcmp(MainFig.Maintab.Tab5.Panel.Videopanel.VideoMode.Transpose_Image.Handle.SelectedObject.String,...#
                        'Transposed') == 1
                    YCor=M_File.Video_Data.Camera_Trajectory(Frame+M_File.Video_Data.Frame_Shift,1)-M_File.Video_Data.YShift;
                    XCor=M_File.Video_Data.Camera_Trajectory(Frame+M_File.Video_Data.Frame_Shift,2)+M_File.Video_Data.XShift;
                else
                    XCor=M_File.Video_Data.Camera_Trajectory(Frame+M_File.Video_Data.Frame_Shift,1)-M_File.Video_Data.YShift;
                    YCor=M_File.Video_Data.Camera_Trajectory(Frame+M_File.Video_Data.Frame_Shift,2)+M_File.Video_Data.XShift;
                end
                
                %x pixel crosshair
                Image(XCor+5:XCor+12,YCor-1:YCor+1,1)=ones(8,3)*R;
                Image(XCor+5:XCor+12,YCor-1:YCor+1,2)=ones(8,3)*G;
                Image(XCor+5:XCor+12,YCor-1:YCor+1,3)=ones(8,3)*B;
                
                Image(XCor-12:XCor-5,YCor-1:YCor+1,1)=ones(8,3)*R;
                Image(XCor-12:XCor-5,YCor-1:YCor+1,2)=ones(8,3)*G;
                Image(XCor-12:XCor-5,YCor-1:YCor+1,3)=ones(8,3)*B;
                
                %y pixel crosshair
                Image(XCor-1:XCor+1,YCor+5:YCor+12,1)=ones(3,8)*R;
                Image(XCor-1:XCor+1,YCor+5:YCor+12,2)=ones(3,8)*G;
                Image(XCor-1:XCor+1,YCor+5:YCor+12,3)=ones(3,8)*B;
                
                Image(XCor-1:XCor+1,YCor-12:YCor-5,1)=ones(3,8)*R;
                Image(XCor-1:XCor+1,YCor-12:YCor-5,2)=ones(3,8)*G;
                Image(XCor-1:XCor+1,YCor-12:YCor-5,3)=ones(3,8)*B;
                
                
                %Plot Scalebar
                Image(475:478,425:425+M_File.Video_Data.Scalebarlength-1,1)=ones(4,M_File.Video_Data.Scalebarlength)*R;
                Image(475:478,425:425+M_File.Video_Data.Scalebarlength-1,2)=ones(4,M_File.Video_Data.Scalebarlength)*G;
                Image(475:478,425:425+M_File.Video_Data.Scalebarlength-1,3)=ones(4,M_File.Video_Data.Scalebarlength)*B;
                
            end
            
            %Case Crosshair with Population Information
        elseif strcmp(MainFig.Maintab.Tab5.Panel.Videopanel.VideoMode.Overlay.Handle.SelectedObject.String,...
                'Crosshair with Population Information') == 1
            
            %Write RGB Information Frome Population Array
            if Frame <= size(Video_Temp.Tifstack,3) && Frame >= 1
                R=M_File.Video_Data.Colour_Data(Frame,1);
                G=M_File.Video_Data.Colour_Data(Frame,2);
                B=M_File.Video_Data.Colour_Data(Frame,3);
            end
            %Plot Cross in Video
            if Frame <= size(Video_Temp.Tifstack,3) && Frame >= 1
                if strcmp(MainFig.Maintab.Tab5.Panel.Videopanel.VideoMode.Transpose_Image.Handle.SelectedObject.String,...#
                        'Transposed') == 1
                    YCor=M_File.Video_Data.Camera_Trajectory(Frame+M_File.Video_Data.Frame_Shift,1)-M_File.Video_Data.YShift;
                    XCor=M_File.Video_Data.Camera_Trajectory(Frame+M_File.Video_Data.Frame_Shift,2)+M_File.Video_Data.XShift;
                else
                    XCor=M_File.Video_Data.Camera_Trajectory(Frame+M_File.Video_Data.Frame_Shift,1)-M_File.Video_Data.YShift;
                    YCor=M_File.Video_Data.Camera_Trajectory(Frame+M_File.Video_Data.Frame_Shift,2)+M_File.Video_Data.XShift;
                end
                
                %x pixel crosshair
                Image(XCor+5:XCor+12,YCor-1:YCor+1,1)=ones(8,3)*R;
                Image(XCor+5:XCor+12,YCor-1:YCor+1,2)=ones(8,3)*G;
                Image(XCor+5:XCor+12,YCor-1:YCor+1,3)=ones(8,3)*B;
                
                Image(XCor-12:XCor-5,YCor-1:YCor+1,1)=ones(8,3)*R;
                Image(XCor-12:XCor-5,YCor-1:YCor+1,2)=ones(8,3)*G;
                Image(XCor-12:XCor-5,YCor-1:YCor+1,3)=ones(8,3)*B;
                
                %y pixel crosshair
                Image(XCor-1:XCor+1,YCor+5:YCor+12,1)=ones(3,8)*R;
                Image(XCor-1:XCor+1,YCor+5:YCor+12,2)=ones(3,8)*G;
                Image(XCor-1:XCor+1,YCor+5:YCor+12,3)=ones(3,8)*B;
                
                Image(XCor-1:XCor+1,YCor-12:YCor-5,1)=ones(3,8)*R;
                Image(XCor-1:XCor+1,YCor-12:YCor-5,2)=ones(3,8)*G;
                Image(XCor-1:XCor+1,YCor-12:YCor-5,3)=ones(3,8)*B;
                
                
                %Plot Scalebar
                Image(475:478,425:425+M_File.Video_Data.Scalebarlength-1,1)=ones(4,M_File.Video_Data.Scalebarlength)*R;
                Image(475:478,425:425+M_File.Video_Data.Scalebarlength-1,2)=ones(4,M_File.Video_Data.Scalebarlength)*G;
                Image(475:478,425:425+M_File.Video_Data.Scalebarlength-1,3)=ones(4,M_File.Video_Data.Scalebarlength)*B;
                
            end
            
            %Case Trailing Points With Population Information
        elseif strcmp(MainFig.Maintab.Tab5.Panel.Videopanel.VideoMode.Overlay.Handle.SelectedObject.String,...
                'Trailing Points with Population Information') == 1
            
            if Frame <= size(Video_Temp.Tifstack,3) && Frame >= 1
                %Create Temp Camera Array with previous positions from other
                %long range jumps
                X_Long_Range_Shift=M_File.Video_Data.Long_Range_Array(1:Frame+M_File.Video_Data.Frame_Shift,1)-M_File.Video_Data.Long_Range_Array(Frame+M_File.Video_Data.Frame_Shift,1);
                Y_Long_Range_Shift=M_File.Video_Data.Long_Range_Array(1:Frame+M_File.Video_Data.Frame_Shift,2)-M_File.Video_Data.Long_Range_Array(Frame+M_File.Video_Data.Frame_Shift,2);
                
                
                if strcmp(MainFig.Maintab.Tab5.Panel.Videopanel.VideoMode.Transpose_Image.Handle.SelectedObject.String,...#
                        'Transposed') == 1
                    XCor_Temp=M_File.Video_Data.Camera_Trajectory(1:Frame+M_File.Video_Data.Frame_Shift,2)+M_File.Video_Data.XShift+Y_Long_Range_Shift;
                    YCor_Temp=M_File.Video_Data.Camera_Trajectory(1:Frame+M_File.Video_Data.Frame_Shift,1)-M_File.Video_Data.YShift+X_Long_Range_Shift;
                    
                else
                    XCor_Temp=M_File.Video_Data.Camera_Trajectory(1:Frame+M_File.Video_Data.Frame_Shift,1)-M_File.Video_Data.YShift+X_Long_Range_Shift;
                    YCor_Temp=M_File.Video_Data.Camera_Trajectory(1:Frame+M_File.Video_Data.Frame_Shift,2)+M_File.Video_Data.XShift+Y_Long_Range_Shift;
                    
                end
                
                %Plot Cross for all points within the image
                j=1;
                for i=1:length(XCor_Temp)
                    if XCor_Temp(i) >= 3 && XCor_Temp(i) <= 509 && YCor_Temp(i) >= 3 && YCor_Temp(i) <= 509
                        if i == length(XCor_Temp)
                            if abs(XCor_Temp(i)-XCor_Temp(i-1)) < 10 && abs(YCor_Temp(i)-YCor_Temp(i-1)) < 10
                                Print=1;
                            else
                                Print=0;
                            end
                        else
                            if abs(XCor_Temp(i+1)-XCor_Temp(i)) < 10 && abs(YCor_Temp(i+1)-YCor_Temp(i)) < 10
                                Print=1;
                            else
                                Print=0;
                            end
                        end
                        
                        if Print== 1
                            
                            
                            %Change Color Data
                            
                            
                            
                            
                            
                            R=M_File.Video_Data.Colour_Data(i,1);
                            G=M_File.Video_Data.Colour_Data(i,2);
                            B=M_File.Video_Data.Colour_Data(i,3);
                            
                            if R == 1 && G == 0 && B == 0
                                R=9/255;
                                G=113/255;
                                B=184/255;
                                
                            elseif R == 1 && G == 1 && B == 0
                                R=197/255;
                                G=33/255;
                                B=36/255;
                                
                            elseif R == 0 && G == 0 && B == 1
                                R=229/255;
                                G=209/255;
                                B=0/255;
                                
                            elseif R == 1 && G == 0 && B == 1
                                R=243/255;
                                G=147/255;
                                B=35/255;
                                
                            elseif R == 0 && G == 1 && B == 0
                                R=71/255;
                                G=174/255;
                                B=76/255;
                            end
                            
                            
                            %Position Dot
                            Image(XCor_Temp(i)-2:XCor_Temp(i)+2,YCor_Temp(i)-2:YCor_Temp(i)+2,1)=ones(5,5)*R;
                            Image(XCor_Temp(i)-2:XCor_Temp(i)+2,YCor_Temp(i)-2:YCor_Temp(i)+2,2)=ones(5,5)*G;
                            Image(XCor_Temp(i)-2:XCor_Temp(i)+2,YCor_Temp(i)-2:YCor_Temp(i)+2,3)=ones(5,5)*B;
                            
                            %Plot Scalebar
                            Image(475:478,425:425+M_File.Video_Data.Scalebarlength-1,1)=ones(4,M_File.Video_Data.Scalebarlength)*R;
                            Image(475:478,425:425+M_File.Video_Data.Scalebarlength-1,2)=ones(4,M_File.Video_Data.Scalebarlength)*G;
                            Image(475:478,425:425+M_File.Video_Data.Scalebarlength-1,3)=ones(4,M_File.Video_Data.Scalebarlength)*B;
                        end
                        
                    end
                end
            end
            
            %Case Indication of other mitos on the track.
        elseif strcmp(MainFig.Maintab.Tab5.Panel.Videopanel.VideoMode.Overlay.Handle.SelectedObject.String,...
                'Cross with Red = Mito Green = No Mito') == 1
            
            if isfield(M_File.Video_Data,'MitoPosCam') == 1
                %Write RGB Information From MitoPos Array
                if Frame <= length(M_File.Video_Data.MitoPosCam) ...
                        && Frame >= 1
                    if M_File.Video_Data.MitoPosCam(Frame) == 1
                        R=1;
                        G=0;
                        B=0;
                    else
                        R=0;
                        G=1;
                        B=0;
                    end
                end
                
                %Plot Cross in Video
                if Frame <= length(M_File.Video_Data.MitoPosCam) ...
                        && Frame >= 1
                    if strcmp(MainFig.Maintab.Tab5.Panel.Videopanel.VideoMode.Transpose_Image.Handle.SelectedObject.String,...#
                            'Transposed') == 1
                        YCor=M_File.Video_Data.Camera_Trajectory(Frame+M_File.Video_Data.Frame_Shift,1)-M_File.Video_Data.YShift;
                        XCor=M_File.Video_Data.Camera_Trajectory(Frame+M_File.Video_Data.Frame_Shift,2)+M_File.Video_Data.XShift;
                    else
                        XCor=M_File.Video_Data.Camera_Trajectory(Frame+M_File.Video_Data.Frame_Shift,1)-M_File.Video_Data.YShift;
                        YCor=M_File.Video_Data.Camera_Trajectory(Frame+M_File.Video_Data.Frame_Shift,2)+M_File.Video_Data.XShift;
                    end
                    
                    %x pixel crosshair
                    Image(XCor+5:XCor+12,YCor-1:YCor+1,1)=ones(8,3)*R;
                    Image(XCor+5:XCor+12,YCor-1:YCor+1,2)=ones(8,3)*G;
                    Image(XCor+5:XCor+12,YCor-1:YCor+1,3)=ones(8,3)*B;
                    
                    Image(XCor-12:XCor-5,YCor-1:YCor+1,1)=ones(8,3)*R;
                    Image(XCor-12:XCor-5,YCor-1:YCor+1,2)=ones(8,3)*G;
                    Image(XCor-12:XCor-5,YCor-1:YCor+1,3)=ones(8,3)*B;
                    
                    %y pixel crosshair
                    Image(XCor-1:XCor+1,YCor+5:YCor+12,1)=ones(3,8)*R;
                    Image(XCor-1:XCor+1,YCor+5:YCor+12,2)=ones(3,8)*G;
                    Image(XCor-1:XCor+1,YCor+5:YCor+12,3)=ones(3,8)*B;
                    
                    Image(XCor-1:XCor+1,YCor-12:YCor-5,1)=ones(3,8)*R;
                    Image(XCor-1:XCor+1,YCor-12:YCor-5,2)=ones(3,8)*G;
                    Image(XCor-1:XCor+1,YCor-12:YCor-5,3)=ones(3,8)*B;
                    
                    
                    %Plot Scalebar
                    Image(475:478,425:425+M_File.Video_Data.Scalebarlength-1,1)=ones(4,M_File.Video_Data.Scalebarlength)*R;
                    Image(475:478,425:425+M_File.Video_Data.Scalebarlength-1,2)=ones(4,M_File.Video_Data.Scalebarlength)*G;
                    Image(475:478,425:425+M_File.Video_Data.Scalebarlength-1,3)=ones(4,M_File.Video_Data.Scalebarlength)*B;
                    
                end
            end
        end
    end
end
