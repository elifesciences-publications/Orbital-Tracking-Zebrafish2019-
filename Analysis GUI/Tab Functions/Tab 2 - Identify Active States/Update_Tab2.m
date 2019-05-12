function Update_Tab2( ~,~)
%% Initialize Global Variables
%Figure Variable
global MainFig;
%Variables to save data
global M_File;






%% Plot Data To Trajectory Window - Identification of Active States
if isfield(M_File,'Trajectory') == 1
    
    axes(MainFig.Maintab.Tab2.Panel.Tab.Tab1.Fig1)
    plot3(M_File.Trajectory.Trajectory(:,1),M_File.Trajectory.Trajectory(:,2),M_File.Trajectory.Trajectory(:,3))
    axis equal;
    grid on;
    view([285 25]);
    [path,name,~] = fileparts(M_File.Trajectory.Trajectorypath);
    title(name);
    xlabel('X[µm]');
    ylabel('Y[µm]');
    zlabel('Z[µm]');

else
    
    cla(MainFig.Maintab.Tab2.Panel.Tab.Tab1.Fig1);
    
    
end

%% Plot active and Passive States
if isfield(M_File,'Correlation') == 1
    
    axes(MainFig.Maintab.Tab2.Panel.Tab.Tab1.Fig1)
    %Active States
    xTemp=M_File.Trajectory.Trajectory(1:end-str2double(get(MainFig.Maintab.Tab2.Panel.CorrWindEdit,'String')),1);
    xTemp(M_File.Correlation.Active_Phase==0)=[];
    yTemp=M_File.Trajectory.Trajectory(1:end-str2double(get(MainFig.Maintab.Tab2.Panel.CorrWindEdit,'String')),2);
    yTemp(M_File.Correlation.Active_Phase==0)=[];
    zTemp=M_File.Trajectory.Trajectory(1:end-str2double(get(MainFig.Maintab.Tab2.Panel.CorrWindEdit,'String')),3);
    zTemp(M_File.Correlation.Active_Phase==0)=[];
    plot3(xTemp,yTemp,zTemp,'.r')
    hold on

    %Passive States
    Passive_Phase=not(M_File.Correlation.Active_Phase);
    xTemp=M_File.Trajectory.Trajectory(1:end-str2double(get(MainFig.Maintab.Tab2.Panel.CorrWindEdit,'String')),1);
    xTemp(Passive_Phase==0)=[];
    yTemp=M_File.Trajectory.Trajectory(1:end-str2double(get(MainFig.Maintab.Tab2.Panel.CorrWindEdit,'String')),2);
    yTemp(Passive_Phase==0)=[];
    zTemp=M_File.Trajectory.Trajectory(1:end-str2double(get(MainFig.Maintab.Tab2.Panel.CorrWindEdit,'String')),3);
    zTemp(Passive_Phase==0)=[];
    plot3(xTemp,yTemp,zTemp,'.b')
    hold off
    axis equal
    view([285 25]);
    grid on
    [~,name,~] = fileparts(M_File.Trajectory.Trajectorypath);
    title(name);
    xlabel('X[µm]');
    ylabel('Y[µm]');
    zlabel('Z[µm]');   
    
    %Plot Correlation Amplitude
    axes(MainFig.Maintab.Tab2.Panel.Tab.Tab2.Fig1)
    plot(M_File.Correlation.Smooth_Corr_Phi)
    hold on
    plot(ones(length(M_File.Correlation.Smooth_Corr_Phi),1)*M_File.Correlation.Treshold,'r')
    hold off
    xlim([0 length(M_File.Correlation.Smooth_Corr_Phi)])
    ylim([min(M_File.Correlation.Smooth_Corr_Phi)*1.1 max(M_File.Correlation.Smooth_Corr_Phi)*1.1])
    
else
    cla(MainFig.Maintab.Tab2.Panel.Tab.Tab2.Fig1);
    
      
end

