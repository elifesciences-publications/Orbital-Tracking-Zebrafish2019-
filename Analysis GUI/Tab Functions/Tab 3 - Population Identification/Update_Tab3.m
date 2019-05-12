function Update_Tab3( ~,~ )
%% Initialize Global Variables
%Figure Variable
global MainFig;
%Variables to save data
global M_File;

%% Split Data Directionwise
if isfield(M_File,'Dynamics') == 1
    [M_File.Dynamics] = Split_Data_Directionwise(M_File.Trajectory.Trajectory, M_File.Dynamics );
end

%%Smooth Trajectory by 5 Points
if isfield(M_File,'Dynamics') == 1
    M_File.Trajectory.Smoothed_Trajectory(:,1)=smooth(M_File.Trajectory.Trajectory(:,1),5);
    M_File.Trajectory.Smoothed_Trajectory(:,2)=smooth(M_File.Trajectory.Trajectory(:,2),5);
    M_File.Trajectory.Smoothed_Trajectory(:,3)=smooth(M_File.Trajectory.Trajectory(:,3),5);
end

%% Calculate Displacement
if isfield(M_File,'Dynamics') == 1
    [M_File.Dynamics] = Determine_displacements(M_File.Trajectory.Smoothed_Trajectory,M_File.Trajectory.Orbit_Time, M_File.Dynamics);
end

%% Seperate by Velocity
if isfield(M_File,'MLE_Fit') == 1
    if isfield(M_File.MLE_Fit,'Plus') == 1 | isfield(M_File.MLE_Fit,'Minus') == 1
        [M_File.Pop1_Plus, M_File.Pop2_Plus, M_File.Pop1_Minus, M_File.Pop2_Minus]= ...
            Split_Data_To_Velocities(M_File.Dynamics, M_File.MLE_Fit, M_File.Trajectory);
        
    end
end

%% Fill Population Status Array
if isfield(M_File,'Pop1_Plus') == 1
    [ M_File.Dynamics, M_File.Transition] = Fill_Population_Status_Array(...
        M_File.Trajectory,...
        M_File.Dynamics,...
        M_File.Passive,...
        M_File.Pop1_Plus,...
        M_File.Pop2_Plus,...
        M_File.Pop1_Minus,...
        M_File.Pop2_Minus);
end

%% Calculate Stepsize Histograms and the trajectory data for each population
if isfield(M_File,'Pop1_Plus') == 1
    % Calculate Array with all stepsizes for Pop1_Plus
    if M_File.Dynamics.Enough_Data_Plus == 1
        [M_File.Pop1_Plus] = Calculate_Population_Stepsize_and_Trajectory_Data(M_File.Pop1_Plus, M_File.Trajectory);
    end
    
    % Calculate Array with all stepsizes for Pop2_Plus
    if M_File.Dynamics.Enough_Data_Plus == 1
        [M_File.Pop2_Plus] = Calculate_Population_Stepsize_and_Trajectory_Data(M_File.Pop2_Plus, M_File.Trajectory);
    end
    
    % Calculate Array with all stepsizes for Pop1_Minus
    if M_File.Dynamics.Enough_Data_Minus == 1
        [M_File.Pop1_Minus] = Calculate_Population_Stepsize_and_Trajectory_Data(M_File.Pop1_Minus, M_File.Trajectory);
    end
    
    % Calculate Array with all stepsizes for Pop2_Minus
    if M_File.Dynamics.Enough_Data_Minus == 1
        [M_File.Pop2_Minus] = Calculate_Population_Stepsize_and_Trajectory_Data(M_File.Pop2_Minus, M_File.Trajectory);
    end
    
    % Calculate Array with all stepsizes for Passive States
    [M_File.Passive] = Calculate_Passive_Stepsize_Trajectory_Data(M_File.Passive, M_File.Trajectory);
end

%% Plot Data in MLE Fit Tab
%Anterograde
if isfield(M_File,'Dynamics') == 1
    if M_File.Dynamics.Enough_Data_Plus == 1
        
        %Plot Velocity Histogram
        axes(MainFig.Maintab.Tab3.Panel.Tab.Tab1.FigAnteroVel)
        plot(M_File.Dynamics.Plus_Duration_Active_Phase,M_File.Dynamics.Plus_XYDisplacement,'.k');
        xlabel('Duration [s]');
        ylabel('XY Displacement [µm]');
        title('Anterograd Velocity');
        xlim([-0.1 max(M_File.Dynamics.Plus_Duration_Active_Phase)*1.1])
        ylim([-0.1 max(M_File.Dynamics.Plus_XYDisplacement)*1.1])
        axes(MainFig.Maintab.Tab3.Panel.Tab.Tab1.FigAnteroHist)
        bar(0:0.05:1.25,hist(M_File.Dynamics.Plus_XYDisplacement./M_File.Dynamics.Plus_Duration_Active_Phase',0:0.05:1.25))
        xlabel('Velocity [µm/s]');
        ylabel('# of Events');
        title('Anterograd Velocity Histogram');
        xlim([0 1.25])
        ylim([0 max(hist(M_File.Dynamics.Plus_XYDisplacement./M_File.Dynamics.Plus_Duration_Active_Phase',0:0.05:1.25))+1])
        
    end
    
    
    
    % Plot MLE Fit
    if M_File.Dynamics.Enough_Data_Plus==1;
        if isfield(M_File,'MLE_Fit')==1
            if M_File.MLE_Fit.Plus==2;
                axes(MainFig.Maintab.Tab3.Panel.Tab.Tab1.FigAnteroHist)
                hold on
                x=0:0.005:1.25;
                plot(x,M_File.MLE_Fit.Plus_P_Value*normpdf(x,M_File.MLE_Fit.Pop1_Plus_Velocity_Temp,M_File.MLE_Fit.Pop1_Plus_Velocity_Std_Temp) + ...
                    (1-M_File.MLE_Fit.Plus_P_Value)*normpdf(x,M_File.MLE_Fit.Pop2_Plus_Velocity_Temp,M_File.MLE_Fit.Pop2_Plus_Velocity_Std_Temp),'r','LineWidth',2)
                hold off
            else
                axes(MainFig.Maintab.Tab3.Panel.Tab.Tab1.FigAnteroHist)
                hold on
                x=0:0.05:1.25;
                if M_File.MLE_Fit.Pop1_Plus_Velocity_Temp > 0
                    plot(x,normpdf(x,M_File.MLE_Fit.Pop1_Plus_Velocity_Temp,M_File.MLE_Fit.Pop1_Plus_Velocity_Std_Temp),'r','LineWidth',2);
                else
                    plot(x,normpdf(x,M_File.MLE_Fit.Pop2_Plus_Velocity_Temp,M_File.MLE_Fit.Pop2_Plus_Velocity_Std_Temp),'r','LineWidth',2);
                end
                hold off
            end
        end
    
    end
    
    
    %Plot Point Assignement into Velocity Plot
    if M_File.Dynamics.Enough_Data_Plus==1;
        if isfield(M_File,'MLE_Fit')==1
            if M_File.MLE_Fit.Plus == 2
                axes(MainFig.Maintab.Tab3.Panel.Tab.Tab1.FigAnteroVel)
                hold on
                plot(M_File.Pop1_Plus.Duration_Active_Phase,M_File.Pop1_Plus.XY_Displacement,'og')
                plot(M_File.Pop2_Plus.Duration_Active_Phase,M_File.Pop2_Plus.XY_Displacement,'ob')
                hold off
            else
                if M_File.MLE_Fit.Pop1_Plus_Velocity_Temp > 0
                    axes(MainFig.Maintab.Tab3.Panel.Tab.Tab1.FigAnteroVel)
                    hold on
                    plot(M_File.Pop1_Plus.Duration_Active_Phase,M_File.Pop1_Plus.XY_Displacement,'og')
                    hold off
                else
                    axes(MainFig.Maintab.Tab3.Panel.Tab.Tab1.FigAnteroVel)
                    hold on
                    plot(M_File.Pop2_Plus.Duration_Active_Phase,M_File.Pop2_Plus.XY_Displacement,'ob')
                    hold off
                end
            end
        end
    else
        
    end
    
    
    
    
end

%Retrograde
if isfield(M_File,'Dynamics') == 1
    if M_File.Dynamics.Enough_Data_Minus == 1
        
        %Plot Velocity Histogram
        axes(MainFig.Maintab.Tab3.Panel.Tab.Tab1.FigRetroVel)
        plot(M_File.Dynamics.Minus_Duration_Active_Phase,M_File.Dynamics.Minus_XYDisplacement,'.k');
        xlabel('Duration [s]');
        ylabel('XY Displacement [µm]');
        title('Retrograd Velocity');
        xlim([-0.1 max(M_File.Dynamics.Minus_Duration_Active_Phase)*1.1])
        ylim([-0.1 max(M_File.Dynamics.Minus_XYDisplacement)*1.1])
        axes(MainFig.Maintab.Tab3.Panel.Tab.Tab1.FigRetroHist)
        bar(0:0.05:1.25,hist(M_File.Dynamics.Minus_XYDisplacement./M_File.Dynamics.Minus_Duration_Active_Phase',0:0.05:1.25))
        xlabel('Velocity [µm/s]');
        ylabel('# of Events');
        title('Retrograd Velocity Histogram');
        xlim([0 1.25])
        ylim([0 max(hist(M_File.Dynamics.Minus_XYDisplacement./M_File.Dynamics.Minus_Duration_Active_Phase',0:0.05:1.25))+1])
        
        
    end
    
    
    % Plot MLE Fit
    if M_File.Dynamics.Enough_Data_Minus==1;
        if isfield(M_File,'MLE_Fit')==1
            if M_File.MLE_Fit.Minus==2;
                axes(MainFig.Maintab.Tab3.Panel.Tab.Tab1.FigRetroHist)
                hold on
                x=0:0.005:1.25;
                plot(x,M_File.MLE_Fit.Minus_P_Value*normpdf(x,M_File.MLE_Fit.Pop1_Minus_Velocity_Temp,M_File.MLE_Fit.Pop1_Minus_Velocity_Std_Temp) + ...
                    (1-M_File.MLE_Fit.Minus_P_Value)*normpdf(x,M_File.MLE_Fit.Pop2_Minus_Velocity_Temp,M_File.MLE_Fit.Pop2_Minus_Velocity_Std_Temp),'r','LineWidth',2)
                hold off
            else
                axes(MainFig.Maintab.Tab3.Panel.Tab.Tab1.FigRetroHist)
                hold on
                x=0:0.005:1.25;
                if M_File.MLE_Fit.Pop1_Minus_Velocity_Temp > 0
                    plot(x,normpdf(x,M_File.MLE_Fit.Pop1_Minus_Velocity_Temp,M_File.MLE_Fit.Pop1_Minus_Velocity_Std_Temp),'r','LineWidth',2);
                else
                    plot(x,normpdf(x,M_File.MLE_Fit.Pop2_Minus_Velocity_Temp,M_File.MLE_Fit.Pop2_Minus_Velocity_Std_Temp),'r','LineWidth',2);
                end
                hold off
                
                
            end
        end
        
        
    end
    
    
    %Plot Point Assignement into Velocity Plot
    if M_File.Dynamics.Enough_Data_Minus==1;
        if isfield(M_File,'MLE_Fit')==1
            if M_File.MLE_Fit.Minus == 2
                axes(MainFig.Maintab.Tab3.Panel.Tab.Tab1.FigRetroVel)
                hold on
                plot(M_File.Pop1_Minus.Duration_Active_Phase,M_File.Pop1_Minus.XY_Displacement,'or')
                plot(M_File.Pop2_Minus.Duration_Active_Phase,M_File.Pop2_Minus.XY_Displacement,'ob')
                hold off
            else
                if M_File.MLE_Fit.Pop1_Minus_Velocity_Temp > 0
                    axes(MainFig.Maintab.Tab3.Panel.Tab.Tab1.FigRetroVel)
                    hold on
                    plot(M_File.Pop1_Minus.Duration_Active_Phase,M_File.Pop1_Minus.XY_Displacement,'or')
                    hold off
                else
                    axes(MainFig.Maintab.Tab3.Panel.Tab.Tab1.FigRetroVel)
                    hold on
                    plot(M_File.Pop2_Minus.Duration_Active_Phase,M_File.Pop2_Minus.XY_Displacement,'ob')
                    hold off
                end
            end
        end
        
        
    end
    
else
    cla(MainFig.Maintab.Tab3.Panel.Tab.Tab1.FigRetroHist)
    cla(MainFig.Maintab.Tab3.Panel.Tab.Tab1.FigAnteroVel)
    cla(MainFig.Maintab.Tab3.Panel.Tab.Tab1.FigAnteroHist)
    cla(MainFig.Maintab.Tab3.Panel.Tab.Tab1.FigRetroVel)
    
end

%% Plot Data in Population Trajectory Tab
if isfield(M_File,'Dynamics') == 1
    if isfield(M_File.Dynamics,'RGB_Population_Status') == 1
        axes(MainFig.Maintab.Tab3.Panel.Tab.Tab2.Fig1)
        scatter3(M_File.Trajectory.Trajectory(:,1),M_File.Trajectory.Trajectory(:,2),M_File.Trajectory.Trajectory(:,3),1,M_File.Dynamics.RGB_Population_Status);
        axis equal
        grid on
        view([285 25]);
    end
    
else
    cla(MainFig.Maintab.Tab3.Panel.Tab.Tab2.Fig1)
end

%% Plot Data in Histogram Tab
%Orbit Displacement
if isfield(M_File,'MLE_Fit') == 1
    axes(MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab1.Fig1)
    
    % Normalized Stepsize Histogram
    if M_File.Dynamics.Enough_Data_Plus == 1
        xhist=0:0.0005:0.03;
        M_File.Pop1_Plus.Hist_Stepsize=hist(M_File.Pop1_Plus.XY_Stepsize,xhist);
        M_File.Pop2_Plus.Hist_Stepsize=hist(M_File.Pop2_Plus.XY_Stepsize,xhist);
        bar(xhist,M_File.Pop1_Plus.Hist_Stepsize/max(M_File.Pop1_Plus.Hist_Stepsize),'BarWidth',1.0,'FaceColor','g','Linestyle','-')
        hold on
        bar(xhist,M_File.Pop2_Plus.Hist_Stepsize/max(M_File.Pop2_Plus.Hist_Stepsize),'BarWidth',0.6,'FaceColor','b','Linestyle','-')
        xlim([-0.022 0.022])
        ylim([0 1.1])
        hold off
    end
    
    
    
    if M_File.Dynamics.Enough_Data_Minus == 1
        xhist=0:0.0005:0.03;
        M_File.Pop1_Minus.Hist_Stepsize=hist(M_File.Pop1_Minus.XY_Stepsize,xhist);
        M_File.Pop2_Minus.Hist_Stepsize=hist(M_File.Pop2_Minus.XY_Stepsize,xhist);
        hold on
        bar(-xhist,M_File.Pop1_Minus.Hist_Stepsize/max(M_File.Pop1_Minus.Hist_Stepsize),'BarWidth',1.0,'FaceColor','r','Linestyle','-')
        bar(-xhist,M_File.Pop2_Minus.Hist_Stepsize/max(M_File.Pop2_Minus.Hist_Stepsize),'BarWidth',0.6,'FaceColor','b','Linestyle','-')
        xlim([-0.022 0.022])
        ylim([0 1.1])
        hold off
    end
    MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab1.Fig1.XLabel.String='Displacement [nm]';
    MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab1.Fig1.YLabel.String=('Normalized # of Events');
    MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab1.Fig1.Title.String='Orbit Displacement';
    
else
    cla(MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab1.Fig1)
end


%Run length
if isfield(M_File,'MLE_Fit') == 1
    %Fast Antero
    if M_File.Pop1_Plus.XY_Displacement(1)~=0
        axes(MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab2.Fig4)
        xhist=0:0.25:10;
        M_File.Pop1_Plus.Hist_Length=hist(M_File.Pop1_Plus.XY_Displacement,xhist);
        bar(xhist,M_File.Pop1_Plus.Hist_Length,'BarWidth',1.0,'FaceColor','g','Linestyle','-')
        xlim([0 10])
        ylim([0 1+max(M_File.Pop1_Plus.Hist_Length)])
        MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab2.Fig4.Title.String='Anterograde Fast';
        MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab2.Fig4.XLabel.String='Run length [µm]';
        MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab2.Fig4.YLabel.String='# of Events';
        MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab2.Text4.String=strcat(...
            {'Mean= '},{num2str(M_File.Pop1_Plus.XYDisplacement_Mean)},{' µm'});
    else
        cla(MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab2.Fig4)
        MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab2.Text4.String='Mean= ~ µm';
    end
    
    %Slow Antero
    if M_File.Pop2_Plus.XY_Displacement(1)~=0
        axes(MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab2.Fig3)
        xhist=0:0.25:10;
        M_File.Pop2_Plus.Hist_Length=hist(M_File.Pop2_Plus.XY_Displacement,xhist);
        bar(xhist,M_File.Pop2_Plus.Hist_Length,'BarWidth',1.0,'FaceColor','b','Linestyle','-')
        xlim([0 10])
        ylim([0 1+max(M_File.Pop2_Plus.Hist_Length)])
        MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab2.Fig3.Title.String='Anterograde Slow';
        MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab2.Fig3.XLabel.String='Run length [µm]';
        MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab2.Fig3.YLabel.String='# of Events';
        MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab2.Text3.String=strcat(...
            {'Mean= '},{num2str(M_File.Pop2_Plus.XYDisplacement_Mean)},{' µm'});
    else
        cla(MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab2.Fig3)
        MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab2.Text3.String='Mean= ~ µm';
    end
    
    
    %Fast Retro
    if M_File.Pop1_Minus.XY_Displacement(1)~=0
        axes(MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab2.Fig2)
        xhist=0:0.25:10;
        M_File.Pop1_Minus.Hist_Length=hist(M_File.Pop1_Minus.XY_Displacement,xhist);
        bar(xhist,M_File.Pop1_Minus.Hist_Length,'BarWidth',1.0,'FaceColor','r','Linestyle','-')
        xlim([0 10])
        ylim([0 1+max(M_File.Pop1_Minus.Hist_Length)])
        MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab2.Fig2.Title.String='Retrograde Fast';
        MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab2.Fig2.XLabel.String='Run length [µm]';
        MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab2.Fig2.YLabel.String='# of Events';
        MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab2.Text2.String=strcat(...
            {'Mean= '},{num2str(M_File.Pop1_Minus.XYDisplacement_Mean)},{' µm'});
    else
        cla(MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab2.Fig2)
        MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab2.Text2.String='Mean= ~ µm';
    end
    
    %Slow Antero
    if M_File.Pop2_Minus.XY_Displacement(1)~=0
        axes(MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab2.Fig1)
        xhist=0:0.25:10;
        M_File.Pop2_Minus.Hist_Length=hist(M_File.Pop2_Minus.XY_Displacement,xhist);
        bar(xhist,M_File.Pop2_Minus.Hist_Length,'BarWidth',1.0,'FaceColor','b','Linestyle','-')
        xlim([0 10])
        ylim([0 1+max(M_File.Pop2_Minus.Hist_Length)])
        MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab2.Fig1.Title.String='Retrograde Slow';
        MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab2.Fig1.XLabel.String='Run length [µm]';
        MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab2.Fig1.YLabel.String='# of Events';
        MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab2.Text1.String=strcat(...
            {'Mean= '},{num2str(M_File.Pop2_Minus.XYDisplacement_Mean)},{' µm'});
    else
        cla(MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab2.Fig1)
        MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab2.Text1.String='Mean= ~ µm';
    end
    
    
    %Duration
    %Fast Antero
    if M_File.Pop1_Plus.Duration_Active_Phase(1)~=0
        axes(MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab3.Fig4)
        xhist=0:0.25:10;
        M_File.Pop1_Plus.Hist_Dur=hist(M_File.Pop1_Plus.Duration_Active_Phase,xhist);
        bar(xhist,M_File.Pop1_Plus.Hist_Dur,'BarWidth',1.0,'FaceColor','g','Linestyle','-')
        xlim([0 10])
        ylim([0 1+max(M_File.Pop1_Plus.Hist_Dur)])
        MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab3.Fig4.Title.String='Anterograde Fast';
        MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab3.Fig4.XLabel.String='Duration [s]';
        MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab3.Fig4.YLabel.String='# of Events';
        MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab3.Text4.String=strcat(...
            {'Mean= '},{num2str(M_File.Pop1_Plus.Duration_Mean)},{' s'});
    else
        cla(MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab3.Fig4)
        MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab3.Text4.String='Mean= ~ s';
    end
    
    %Slow Antero
    if M_File.Pop2_Plus.Duration_Active_Phase(1)~=0
        axes(MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab3.Fig3)
        xhist=0:0.25:10;
        M_File.Pop2_Plus.Hist_Dur=hist(M_File.Pop2_Plus.Duration_Active_Phase,xhist);
        bar(xhist,M_File.Pop2_Plus.Hist_Dur,'BarWidth',1.0,'FaceColor','b','Linestyle','-')
        xlim([0 10])
        ylim([0 1+max(M_File.Pop2_Plus.Hist_Dur)])
        MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab3.Fig3.Title.String='Anterograde Slow';
        MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab3.Fig3.XLabel.String='Duration [s]';
        MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab3.Fig3.YLabel.String='# of Events';
        MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab3.Text3.String=strcat(...
            {'Mean= '},{num2str(M_File.Pop2_Plus.Duration_Mean)},{' s'});
    else
        cla(MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab3.Fig3)
        MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab3.Text3.String='Mean= ~ s';
    end
    
    
    %Fast Retro
    if M_File.Pop1_Minus.Duration_Active_Phase(1)~=0
        axes(MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab3.Fig2)
        xhist=0:0.25:10;
        M_File.Pop1_Minus.Hist_Dur=hist(M_File.Pop1_Minus.Duration_Active_Phase,xhist);
        bar(xhist,M_File.Pop1_Minus.Hist_Dur,'BarWidth',1.0,'FaceColor','r','Linestyle','-')
        xlim([0 10])
        ylim([0 1+max(M_File.Pop1_Minus.Hist_Dur)])
        MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab3.Fig2.Title.String='Retrograde Fast';
        MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab3.Fig2.XLabel.String='Duration [s]';
        MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab3.Fig2.YLabel.String='# of Events';
        MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab3.Text2.String=strcat(...
            {'Mean= '},{num2str(M_File.Pop1_Minus.Duration_Mean)},{' s'});
    else
        cla(MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab3.Fig2)
        MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab3.Text2.String='Mean= ~ s';
    end
    
    %Slow Antero
    if M_File.Pop2_Minus.Duration_Active_Phase(1)~=0
        axes(MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab3.Fig1)
        xhist=0:0.25:10;
        M_File.Pop2_Minus.Hist_Dur=hist(M_File.Pop2_Minus.Duration_Active_Phase,xhist);
        bar(xhist,M_File.Pop2_Minus.Hist_Dur,'BarWidth',1.0,'FaceColor','b','Linestyle','-')
        xlim([0 10])
        ylim([0 1+max(M_File.Pop2_Minus.Hist_Dur)])
        MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab3.Fig1.Title.String='Retrograde Slow';
        MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab3.Fig1.XLabel.String='Duration [s]';
        MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab3.Fig1.YLabel.String='# of Events';
        MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab3.Text1.String=strcat(...
            {'Mean= '},{num2str(M_File.Pop2_Minus.Duration_Mean)},{' s'});
    else
        cla(MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab3.Fig1)
        MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab3.Text1.String='Mean= ~ s';
    end
    
    
    
    
else
    cla(MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab2.Fig4)
    MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab2.Text4.String='Mean= ~ µm';
    cla(MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab2.Fig3)
        MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab2.Text3.String='Mean= ~ µm';
        cla(MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab2.Fig2)
        MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab2.Text2.String='Mean= ~ µm';
        cla(MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab2.Fig1)
        MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab2.Text1.String='Mean= ~ µm';
    cla(MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab3.Fig4)
        MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab3.Text4.String='Mean= ~ s';
    cla(MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab3.Fig3)
        MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab3.Text3.String='Mean= ~ s';
    cla(MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab3.Fig2)
        MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab3.Text2.String='Mean= ~ s';
    cla(MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab3.Fig1)
        MainFig.Maintab.Tab3.Panel.Tab.Tab3.Tab.Tab3.Text1.String='Mean= ~ s';
end

%% Plot Data in Movement Behaviour Tab
if isfield(M_File,'Transition')==1
    %Plot Transition Propabilities
    Temp=sum(M_File.Transition.Matrix,2);
    Temp2(1,:)=M_File.Transition.Matrix(1,:)/Temp(1)*100;
    Temp2(2,:)=M_File.Transition.Matrix(2,:)/Temp(2)*100;
    Temp2(3,:)=M_File.Transition.Matrix(3,:)/Temp(3)*100;
    Temp2(4,:)=M_File.Transition.Matrix(4,:)/Temp(4)*100;
    MainFig.Maintab.Tab3.Panel.Tab.Tab4.Panel.Table1.Data=Temp2;
    
    %Plot Transition Times
    for i=1:4
        for j=1:4
            Temp2=cell2mat(M_File.Transition.Pause(i,j));
            Temp2=Temp2(2:end);
            Temp(i,j)=mean(Temp2)*M_File.Trajectory.Orbit_Time;
        end
    end
    MainFig.Maintab.Tab3.Panel.Tab.Tab4.Panel.Table2.Data=Temp;
    
else
    MainFig.Maintab.Tab3.Panel.Tab.Tab4.Panel.Table1.Data=zeros(4,4);
    MainFig.Maintab.Tab3.Panel.Tab.Tab4.Panel.Table2.Data=zeros(4,4);
end





