function Update_Tab4(~,~)
%% Initialize Global Variables
%Figure Variable
global MainFig;
%Variables to save data
global M_File;
%Variable for Summary
global Summary

%% Write Data to "Summarize Data"
if isfield(Summary,'Filelist')==1
    MainFig.Maintab.Tab4.Panel.Tab.Tab1.Table.Data=Summary.Filelist;
else
    MainFig.Maintab.Tab4.Panel.Tab.Tab1.Table.Data={'Filename',false, 'Retrograde/Anterograde' '0'};
end

%% Write Data to "Results"
%Write Data to "Orbit Displacement"
if isfield(Summary,'Pop1_Plus') == 1
    axes(MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab1.Fig1)
    
    % Anterograd
    xhist=0:0.0005:0.03;
    Summary.Pop1_Plus.Hist_Stepsize=hist(Summary.Pop1_Plus.XY_Stepsize,xhist);
    Summary.Pop2_Plus.Hist_Stepsize=hist(Summary.Pop2_Plus.XY_Stepsize,xhist);
    bar(xhist,Summary.Pop1_Plus.Hist_Stepsize/max(Summary.Pop1_Plus.Hist_Stepsize),'BarWidth',1.0,'FaceColor','g','Linestyle','-')
    hold on
    bar(xhist,Summary.Pop2_Plus.Hist_Stepsize/max(Summary.Pop2_Plus.Hist_Stepsize),'BarWidth',0.6,'FaceColor','b','Linestyle','-')
    xlim([-0.022 0.022])
    ylim([0 1.1])
    hold off
    
    %Retrograd
    xhist=0:0.0005:0.03;
    Summary.Pop1_Minus.Hist_Stepsize=hist(Summary.Pop1_Minus.XY_Stepsize,xhist);
    Summary.Pop2_Minus.Hist_Stepsize=hist(Summary.Pop2_Minus.XY_Stepsize,xhist);
    hold on
    bar(-xhist,Summary.Pop1_Minus.Hist_Stepsize/max(Summary.Pop1_Minus.Hist_Stepsize),'BarWidth',1.0,'FaceColor','r','Linestyle','-')
    bar(-xhist,Summary.Pop2_Minus.Hist_Stepsize/max(Summary.Pop2_Minus.Hist_Stepsize),'BarWidth',0.6,'FaceColor','b','Linestyle','-')
    xlim([-0.022 0.022])
    ylim([0 1.1])
    hold off
    
    MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab1.Fig1.XLabel.String='Displacement [nm]';
    MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab1.Fig1.YLabel.String=('Normalized # of Events');
    MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab1.Fig1.Title.String='Orbit Displacement';
    
else
    cla(MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab1.Fig1)
end


%Write data to "Run length[µm]"
if isfield(Summary,'Pop1_Plus') == 1
    %Fast Antero
    if mean(Summary.Pop1_Plus.XY_Displacement)~=0
        axes(MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab2.Fig4)
        xhist=0:0.25:10;
        Summary.Pop1_Plus.Hist_Length=hist(Summary.Pop1_Plus.XY_Displacement,xhist);
        bar(xhist,Summary.Pop1_Plus.Hist_Length,'BarWidth',1.0,'FaceColor','g','Linestyle','-')
        xlim([0 10])
        ylim([0 1+max(Summary.Pop1_Plus.Hist_Length)])
        MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab2.Fig4.Title.String='Anterograde Fast';
        MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab2.Fig4.XLabel.String='Run length [µm]';
        MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab2.Fig4.YLabel.String='# of Events';
        MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab2.Text4.String=strcat(...
            {'Mean= '},{num2str(mean(Summary.Pop1_Plus.XY_Displacement))},{' µm'});
    else
        cla(MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab2.Fig4)
        MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab2.Text4.String='Mean= ~ µm';
    end
    
    %Slow Antero
    if mean(Summary.Pop2_Plus.XY_Displacement)~=0
        axes(MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab2.Fig3)
        xhist=0:0.25:10;
        Summary.Pop2_Plus.Hist_Length=hist(Summary.Pop2_Plus.XY_Displacement,xhist);
        bar(xhist,Summary.Pop2_Plus.Hist_Length,'BarWidth',1.0,'FaceColor','b','Linestyle','-')
        xlim([0 10])
        ylim([0 1+max(Summary.Pop2_Plus.Hist_Length)])
        MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab2.Fig3.Title.String='Anterograde Slow';
        MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab2.Fig3.XLabel.String='Run length [µm]';
        MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab2.Fig3.YLabel.String='# of Events';
        MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab2.Text3.String=strcat(...
            {'Mean= '},{num2str(mean(Summary.Pop2_Plus.XY_Displacement))},{' µm'});
    else
        cla(MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab2.Fig3)
        MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab2.Text3.String='Mean= ~ µm';
    end
    
    
    %Fast Retro
    if mean(Summary.Pop1_Minus.XY_Displacement)~=0
        axes(MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab2.Fig2)
        xhist=0:0.25:10;
        Summary.Pop1_Minus.Hist_Length=hist(Summary.Pop1_Minus.XY_Displacement,xhist);
        bar(xhist,Summary.Pop1_Minus.Hist_Length,'BarWidth',1.0,'FaceColor','r','Linestyle','-')
        xlim([0 10])
        ylim([0 1+max(Summary.Pop1_Minus.Hist_Length)])
        MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab2.Fig2.Title.String='Retrograde Fast';
        MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab2.Fig2.XLabel.String='Run length [µm]';
        MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab2.Fig2.YLabel.String='# of Events';
        MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab2.Text2.String=strcat(...
            {'Mean= '},{num2str(mean(Summary.Pop1_Minus.XY_Displacement))},{' µm'});
    else
        cla(MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab2.Fig2)
        MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab2.Text2.String='Mean= ~ µm';
    end
    
    %Slow Antero
    if mean(Summary.Pop2_Minus.XY_Displacement)~=0
        axes(MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab2.Fig1)
        xhist=0:0.25:10;
        Summary.Pop2_Minus.Hist_Length=hist(Summary.Pop2_Minus.XY_Displacement,xhist);
        bar(xhist,Summary.Pop2_Minus.Hist_Length,'BarWidth',1.0,'FaceColor','b','Linestyle','-')
        xlim([0 10])
        ylim([0 1+max(Summary.Pop2_Minus.Hist_Length)])
        MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab2.Fig1.Title.String='Retrograde Slow';
        MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab2.Fig1.XLabel.String='Run length [µm]';
        MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab2.Fig1.YLabel.String='# of Events';
        MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab2.Text1.String=strcat(...
            {'Mean= '},{num2str(mean(Summary.Pop2_Minus.XY_Displacement))},{' µm'});
    else
        cla(MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab2.Fig1)
        MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab2.Text1.String='Mean= ~ µm';
    end
    
    
    
    
    %Duration
    %Fast Antero
    if mean(Summary.Pop1_Plus.Duration_Active_Phase)~=0
        axes(MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab3.Fig4)
        xhist=0:0.25:10;
        Summary.Pop1_Plus.Hist_Dur=hist(Summary.Pop1_Plus.Duration_Active_Phase,xhist);
        bar(xhist,Summary.Pop1_Plus.Hist_Dur,'BarWidth',1.0,'FaceColor','g','Linestyle','-')
        xlim([0 10])
        ylim([0 1+max(Summary.Pop1_Plus.Hist_Dur)])
        MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab3.Fig4.Title.String='Anterograde Fast';
        MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab3.Fig4.XLabel.String='Duration [s]';
        MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab3.Fig4.YLabel.String='# of Events';
        MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab3.Text4.String=strcat(...
            {'Mean= '},{num2str(mean(Summary.Pop1_Plus.Duration_Active_Phase))},{' s'});
    else
        cla(MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab3.Fig4)
        MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab3.Text4.String='Mean= ~ s';
    end
    
    %Slow Antero
    if mean(Summary.Pop2_Plus.Duration_Active_Phase)~=0
        axes(MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab3.Fig3)
        xhist=0:0.25:10;
        Summary.Pop2_Plus.Hist_Dur=hist(Summary.Pop2_Plus.Duration_Active_Phase,xhist);
        bar(xhist,Summary.Pop2_Plus.Hist_Dur,'BarWidth',1.0,'FaceColor','b','Linestyle','-')
        xlim([0 10])
        ylim([0 1+max(Summary.Pop2_Plus.Hist_Dur)])
        MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab3.Fig3.Title.String='Anterograde Slow';
        MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab3.Fig3.XLabel.String='Duration [s]';
        MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab3.Fig3.YLabel.String='# of Events';
        MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab3.Text3.String=strcat(...
            {'Mean= '},{num2str(mean(Summary.Pop2_Plus.Duration_Active_Phase))},{' s'});
    else
        cla(MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab3.Fig3)
        MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab3.Text3.String='Mean= ~ s';
    end
    
    
    %Fast Retro
    if mean(Summary.Pop1_Minus.Duration_Active_Phase)~=0
        axes(MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab3.Fig2)
        xhist=0:0.25:10;
        Summary.Pop1_Minus.Hist_Dur=hist(Summary.Pop1_Minus.Duration_Active_Phase,xhist);
        bar(xhist,Summary.Pop1_Minus.Hist_Dur,'BarWidth',1.0,'FaceColor','r','Linestyle','-')
        xlim([0 10])
        ylim([0 1+max(Summary.Pop1_Minus.Hist_Dur)])
        MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab3.Fig2.Title.String='Retrograde Fast';
        MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab3.Fig2.XLabel.String='Duration [s]';
        MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab3.Fig2.YLabel.String='# of Events';
        MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab3.Text2.String=strcat(...
            {'Mean= '},{num2str(mean(Summary.Pop1_Minus.Duration_Active_Phase))},{' s'});
    else
        cla(MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab3.Fig2)
        MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab3.Text2.String='Mean= ~ s';
    end
    
    %Slow Antero
    if mean(Summary.Pop2_Minus.Duration_Active_Phase)~=0
        axes(MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab3.Fig1)
        xhist=0:0.25:10;
        Summary.Pop2_Minus.Hist_Dur=hist(Summary.Pop2_Minus.Duration_Active_Phase,xhist);
        bar(xhist,Summary.Pop2_Minus.Hist_Dur,'BarWidth',1.0,'FaceColor','b','Linestyle','-')
        xlim([0 10])
        ylim([0 1+max(Summary.Pop2_Minus.Hist_Dur)])
        MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab3.Fig1.Title.String='Retrograde Slow';
        MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab3.Fig1.XLabel.String='Duration [s]';
        MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab3.Fig1.YLabel.String='# of Events';
        MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab3.Text1.String=strcat(...
            {'Mean= '},{num2str(mean(Summary.Pop2_Minus.Duration_Active_Phase))},{' s'});
    else
        cla(MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab3.Fig1)
        MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab3.Text1.String='Mean= ~ s';
    end
    
    % Plot Data in Movement Behaviour Tab
    if isfield(Summary,'Transition')==1
        %Plot Transition Propabilities
        Temp=sum(Summary.Transition.Matrix,2);
        Temp2(1,:)=Summary.Transition.Matrix(1,:)/Temp(1)*100;
        Temp2(2,:)=Summary.Transition.Matrix(2,:)/Temp(2)*100;
        Temp2(3,:)=Summary.Transition.Matrix(3,:)/Temp(3)*100;
        Temp2(4,:)=Summary.Transition.Matrix(4,:)/Temp(4)*100;
        MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab4.Panel.Table1.Data=Temp2;
        
        %Plot Transition Times
        for i=1:4
            for j=1:4
                Temp2=cell2mat(Summary.Transition.Pause(i,j));
                Temp2=Temp2(2:end);
                Temp(i,j)=mean(Temp2)*0.01;
            end
        end
        MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab4.Panel.Table2.Data=Temp;
        
        
    end
    
    
    %% Update Colocalization Results
    if isfield(Summary,'Colocalization') == 1
        if isfield(Summary.Colocalization,'Orbits') == 1
            
            %% Plot Orbit Ratio Axes
            axes(MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab5.Panel.Fig1)    
            cla(MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab5.Panel.Fig1)    
            xlim([0.5 5.5])
            ylim([0 1.2])
            hold on
            % Plot Fast Retrograde Ratio
            text(1,1.15,'Fast','HorizontalAlignment','center');
            text(1,1.08,'Retrograde','HorizontalAlignment','center');
            if Summary.Colocalization.Orbits.Mito_Pop1_Minus == 0 && Summary.Colocalization.Orbits.Track_Pop1_Minus == 0
                text(1,0.535,'No','HorizontalAlignment','center');
                text(1,0.475,'Data','HorizontalAlignment','center');
            elseif Summary.Colocalization.Orbits.Mito_Pop1_Minus == 0 && Summary.Colocalization.Orbits.Track_Pop1_Minus ~= 0
                bar(1,1,'r')
                text(1,0.535,'100%','HorizontalAlignment','center');
                text(1,0.475,'Track','HorizontalAlignment','center');
            elseif Summary.Colocalization.Orbits.Mito_Pop1_Minus ~= 0 && Summary.Colocalization.Orbits.Track_Pop1_Minus == 0
                bar(1,1,'EdgeColor','r','FaceColor','none')
                text(1,0.535,'100%','HorizontalAlignment','center');
                text(1,0.475,'Mito','HorizontalAlignment','center');
            elseif Summary.Colocalization.Orbits.Mito_Pop1_Minus ~= 0 && Summary.Colocalization.Orbits.Track_Pop1_Minus ~= 0
                bar(1,1,'EdgeColor','r','FaceColor','none')
                Mito=Summary.Colocalization.Orbits.Mito_Pop1_Minus/...
                    (Summary.Colocalization.Orbits.Mito_Pop1_Minus+Summary.Colocalization.Orbits.Track_Pop1_Minus);
                Track=1-Mito;
                bar(1,Mito,'r')
                text(1,Mito/2+0.035,[num2str(Mito*100,4) '%'],'HorizontalAlignment','center');
                text(1,Mito/2-0.035,'Mito','HorizontalAlignment','center');
                text(1,Track/2+Mito+0.035,[num2str(Track*100,4) '%'],'HorizontalAlignment','center');
                text(1,Track/2+Mito-0.035,'Track','HorizontalAlignment','center');
            end
            
            % Plot Fast Anterograde Ratio
            text(2,1.15,'Fast','HorizontalAlignment','center');
            text(2,1.08,'Anterograde','HorizontalAlignment','center');
            if Summary.Colocalization.Orbits.Mito_Pop1_Plus == 0 && Summary.Colocalization.Orbits.Track_Pop1_Plus == 0
                text(2,0.535,'No','HorizontalAlignment','center');
                text(2,0.475,'Data','HorizontalAlignment','center');
            elseif Summary.Colocalization.Orbits.Mito_Pop1_Plus == 0 && Summary.Colocalization.Orbits.Track_Pop1_Plus ~= 0
                bar(2,1,'g')
                text(2,0.535,'100%','HorizontalAlignment','center');
                text(2,0.475,'Track','HorizontalAlignment','center');
            elseif Summary.Colocalization.Orbits.Mito_Pop1_Plus ~= 0 && Summary.Colocalization.Orbits.Track_Pop1_Plus == 0
                bar(2,1,'EdgeColor','g','FaceColor','none')
                text(2,0.535,'100%','HorizontalAlignment','center');
                text(2,0.475,'Mito','HorizontalAlignment','center');
            elseif Summary.Colocalization.Orbits.Mito_Pop1_Plus ~= 0 && Summary.Colocalization.Orbits.Track_Pop1_Plus ~= 0
                bar(2,1,'EdgeColor','g','FaceColor','none')
                Mito=Summary.Colocalization.Orbits.Mito_Pop1_Plus/...
                    (Summary.Colocalization.Orbits.Mito_Pop1_Plus+Summary.Colocalization.Orbits.Track_Pop1_Plus);
                Track=1-Mito;
                bar(2,Mito,'g')
                text(2,Mito/2+0.035,[num2str(Mito*100,4) '%'],'HorizontalAlignment','center');
                text(2,Mito/2-0.035,'Mito','HorizontalAlignment','center');
                text(2,Track/2+Mito+0.035,[num2str(Track*100,4) '%'],'HorizontalAlignment','center');
                text(2,Track/2+Mito-0.035,'Track','HorizontalAlignment','center');
            end
            
            
            % Plot Slow Retrograde Ratio
            text(3,1.15,'Slow','HorizontalAlignment','center');
            text(3,1.08,'Retrograde','HorizontalAlignment','center');
            if Summary.Colocalization.Orbits.Mito_Pop2_Minus == 0 && Summary.Colocalization.Orbits.Track_Pop2_Minus == 0
                text(3,0.535,'No','HorizontalAlignment','center');
                text(3,0.475,'Data','HorizontalAlignment','center');
            elseif Summary.Colocalization.Orbits.Mito_Pop2_Minus == 0 && Summary.Colocalization.Orbits.Track_Pop2_Minus ~= 0
                bar(3,1,'m')
                text(3,0.535,'100%','HorizontalAlignment','center');
                text(3,0.475,'Track','HorizontalAlignment','center');
            elseif Summary.Colocalization.Orbits.Mito_Pop2_Minus ~= 0 && Summary.Colocalization.Orbits.Track_Pop2_Minus == 0
                bar(3,1,'EdgeColor','m','FaceColor','none')
                text(3,0.535,'100%','HorizontalAlignment','center');
                text(3,0.475,'Mito','HorizontalAlignment','center');
            elseif Summary.Colocalization.Orbits.Mito_Pop2_Minus ~= 0 && Summary.Colocalization.Orbits.Track_Pop2_Minus ~= 0
                bar(3,1,'EdgeColor','m','FaceColor','none')
                Mito=Summary.Colocalization.Orbits.Mito_Pop2_Minus/...
                    (Summary.Colocalization.Orbits.Mito_Pop2_Minus+Summary.Colocalization.Orbits.Track_Pop2_Minus);
                Track=1-Mito;
                bar(3,Mito,'m')
                text(3,Mito/2+0.035,[num2str(Mito*100,4) '%'],'HorizontalAlignment','center');
                text(3,Mito/2-0.035,'Mito','HorizontalAlignment','center');
                text(3,Track/2+Mito+0.035,[num2str(Track*100,4) '%'],'HorizontalAlignment','center');
                text(3,Track/2+Mito-0.035,'Track','HorizontalAlignment','center');
            end
            
            % Plot Slow Anterograde Ratio
            text(4,1.15,'Slow','HorizontalAlignment','center');
            text(4,1.08,'Anterograde','HorizontalAlignment','center');
            if Summary.Colocalization.Orbits.Mito_Pop2_Plus == 0 && Summary.Colocalization.Orbits.Track_Pop2_Plus == 0
                text(4,0.535,'No','HorizontalAlignment','center');
                text(4,0.475,'Data','HorizontalAlignment','center');
            elseif Summary.Colocalization.Orbits.Mito_Pop2_Plus == 0 && Summary.Colocalization.Orbits.Track_Pop2_Plus ~= 0
                bar(4,1,'b')
                text(4,0.535,'100%','HorizontalAlignment','center');
                text(4,0.475,'Track','HorizontalAlignment','center');
            elseif Summary.Colocalization.Orbits.Mito_Pop2_Plus ~= 0 && Summary.Colocalization.Orbits.Track_Pop2_Plus == 0
                bar(4,1,'EdgeColor','b','FaceColor','none')
                text(4,0.535,'100%','HorizontalAlignment','center');
                text(4,0.475,'Mito','HorizontalAlignment','center');
            elseif Summary.Colocalization.Orbits.Mito_Pop2_Plus ~= 0 && Summary.Colocalization.Orbits.Track_Pop2_Plus ~= 0
                bar(4,1,'EdgeColor','b','FaceColor','none')
                Mito=Summary.Colocalization.Orbits.Mito_Pop2_Plus/...
                    (Summary.Colocalization.Orbits.Mito_Pop2_Plus+Summary.Colocalization.Orbits.Track_Pop2_Plus);
                Track=1-Mito;
                bar(4,Mito,'b')
                text(4,Mito/2+0.035,[num2str(Mito*100,4) '%'],'HorizontalAlignment','center');
                text(4,Mito/2-0.035,'Mito','HorizontalAlignment','center');
                text(4,Track/2+Mito+0.035,[num2str(Track*100,4) '%'],'HorizontalAlignment','center');
                text(4,Track/2+Mito-0.035,'Track','HorizontalAlignment','center');
            end
            
            % Plot Passive Ratio
            text(5,1.15,'Passive','HorizontalAlignment','center');
            if Summary.Colocalization.Orbits.Mito_Passive == 0 && Summary.Colocalization.Orbits.Track_Passive == 0
                text(5,0.535,'No','HorizontalAlignment','center');
                text(5,0.475,'Data','HorizontalAlignment','center');
            elseif Summary.Colocalization.Orbits.Mito_Passive == 0 && Summary.Colocalization.Orbits.Track_Passive ~= 0
                bar(5,1,'y')
                text(5,0.535,'100%','HorizontalAlignment','center');
                text(5,0.475,'Track','HorizontalAlignment','center');
            elseif Summary.Colocalization.Orbits.Mito_Passive ~= 0 && Summary.Colocalization.Orbits.Track_Passive == 0
                bar(5,1,'EdgeColor','y','FaceColor','none')
                text(5,0.535,'100%','HorizontalAlignment','center');
                text(5,0.475,'Mito','HorizontalAlignment','center');
            elseif Summary.Colocalization.Orbits.Mito_Passive ~= 0 && Summary.Colocalization.Orbits.Track_Passive ~= 0
                bar(5,1,'EdgeColor','y','FaceColor','none')
                Mito=Summary.Colocalization.Orbits.Mito_Passive/...
                    (Summary.Colocalization.Orbits.Mito_Passive+Summary.Colocalization.Orbits.Track_Passive);
                Track=1-Mito;
                bar(5,Mito,'y')
                text(5,Mito/2+0.035,[num2str(Mito*100,4) '%'],'HorizontalAlignment','center');
                text(5,Mito/2-0.035,'Mito','HorizontalAlignment','center');
                text(5,Track/2+Mito+0.035,[num2str(Track*100,4) '%'],'HorizontalAlignment','center');
                text(5,Track/2+Mito-0.035,'Track','HorizontalAlignment','center');
            end
            
            %% Plot Phases Ratio Axes
            axes(MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab5.Panel.Fig2) 
            cla(MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab5.Panel.Fig2) 
            xlim([0.5 5.5])
            ylim([0 1.2])
            hold on
            % Plot Fast Retrograde Ratio
            text(1,1.15,'Fast','HorizontalAlignment','center');
            text(1,1.08,'Retrograde','HorizontalAlignment','center');
            if Summary.Colocalization.Phases.Mito_Pop1_Minus == 0 && Summary.Colocalization.Phases.Track_Pop1_Minus == 0
                text(1,0.535,'No','HorizontalAlignment','center');
                text(1,0.475,'Data','HorizontalAlignment','center');
            elseif Summary.Colocalization.Phases.Mito_Pop1_Minus == 0 && Summary.Colocalization.Phases.Track_Pop1_Minus ~= 0
                bar(1,1,'r')
                text(1,0.535,'100%','HorizontalAlignment','center');
                text(1,0.475,'Track','HorizontalAlignment','center');
            elseif Summary.Colocalization.Phases.Mito_Pop1_Minus ~= 0 && Summary.Colocalization.Phases.Track_Pop1_Minus == 0
                bar(1,1,'EdgeColor','r','FaceColor','none')
                text(1,0.535,'100%','HorizontalAlignment','center');
                text(1,0.475,'Mito','HorizontalAlignment','center');
            elseif Summary.Colocalization.Phases.Mito_Pop1_Minus ~= 0 && Summary.Colocalization.Phases.Track_Pop1_Minus ~= 0
                bar(1,1,'EdgeColor','r','FaceColor','none')
                Mito=Summary.Colocalization.Phases.Mito_Pop1_Minus/...
                    (Summary.Colocalization.Phases.Mito_Pop1_Minus+Summary.Colocalization.Phases.Track_Pop1_Minus);
                Track=1-Mito;
                bar(1,Mito,'r')
                text(1,Mito/2+0.035,[num2str(Mito*100,4) '%'],'HorizontalAlignment','center');
                text(1,Mito/2-0.035,'Mito','HorizontalAlignment','center');
                text(1,Track/2+Mito+0.035,[num2str(Track*100,4) '%'],'HorizontalAlignment','center');
                text(1,Track/2+Mito-0.035,'Track','HorizontalAlignment','center');
            end
            
            % Plot Fast Anterograde Ratio
            text(2,1.15,'Fast','HorizontalAlignment','center');
            text(2,1.08,'Anterograde','HorizontalAlignment','center');
            if Summary.Colocalization.Phases.Mito_Pop1_Plus == 0 && Summary.Colocalization.Phases.Track_Pop1_Plus == 0
                text(2,0.535,'No','HorizontalAlignment','center');
                text(2,0.475,'Data','HorizontalAlignment','center');
            elseif Summary.Colocalization.Phases.Mito_Pop1_Plus == 0 && Summary.Colocalization.Phases.Track_Pop1_Plus ~= 0
                bar(2,1,'g')
                text(2,0.535,'100%','HorizontalAlignment','center');
                text(2,0.475,'Track','HorizontalAlignment','center');
            elseif Summary.Colocalization.Phases.Mito_Pop1_Plus ~= 0 && Summary.Colocalization.Phases.Track_Pop1_Plus == 0
                bar(2,1,'EdgeColor','g','FaceColor','none')
                text(2,0.535,'100%','HorizontalAlignment','center');
                text(2,0.475,'Mito','HorizontalAlignment','center');
            elseif Summary.Colocalization.Phases.Mito_Pop1_Plus ~= 0 && Summary.Colocalization.Phases.Track_Pop1_Plus ~= 0
                bar(2,1,'EdgeColor','g','FaceColor','none')
                Mito=Summary.Colocalization.Phases.Mito_Pop1_Plus/...
                    (Summary.Colocalization.Phases.Mito_Pop1_Plus+Summary.Colocalization.Phases.Track_Pop1_Plus);
                Track=1-Mito;
                bar(2,Mito,'g')
                text(2,Mito/2+0.035,[num2str(Mito*100,4) '%'],'HorizontalAlignment','center');
                text(2,Mito/2-0.035,'Mito','HorizontalAlignment','center');
                text(2,Track/2+Mito+0.035,[num2str(Track*100,4) '%'],'HorizontalAlignment','center');
                text(2,Track/2+Mito-0.035,'Track','HorizontalAlignment','center');
            end
            
            
            % Plot Slow Retrograde Ratio
            text(3,1.15,'Slow','HorizontalAlignment','center');
            text(3,1.08,'Retrograde','HorizontalAlignment','center');
            if Summary.Colocalization.Phases.Mito_Pop2_Minus == 0 && Summary.Colocalization.Phases.Track_Pop2_Minus == 0
                text(3,0.535,'No','HorizontalAlignment','center');
                text(3,0.475,'Data','HorizontalAlignment','center');
            elseif Summary.Colocalization.Phases.Mito_Pop2_Minus == 0 && Summary.Colocalization.Phases.Track_Pop2_Minus ~= 0
                bar(3,1,'m')
                text(3,0.535,'100%','HorizontalAlignment','center');
                text(3,0.475,'Track','HorizontalAlignment','center');
            elseif Summary.Colocalization.Phases.Mito_Pop2_Minus ~= 0 && Summary.Colocalization.Phases.Track_Pop2_Minus == 0
                bar(3,1,'EdgeColor','m','FaceColor','none')
                text(3,0.535,'100%','HorizontalAlignment','center');
                text(3,0.475,'Mito','HorizontalAlignment','center');
            elseif Summary.Colocalization.Phases.Mito_Pop2_Minus ~= 0 && Summary.Colocalization.Phases.Track_Pop2_Minus ~= 0
                bar(3,1,'EdgeColor','m','FaceColor','none')
                Mito=Summary.Colocalization.Phases.Mito_Pop2_Minus/...
                    (Summary.Colocalization.Phases.Mito_Pop2_Minus+Summary.Colocalization.Phases.Track_Pop2_Minus);
                Track=1-Mito;
                bar(3,Mito,'m')
                text(3,Mito/2+0.035,[num2str(Mito*100,4) '%'],'HorizontalAlignment','center');
                text(3,Mito/2-0.035,'Mito','HorizontalAlignment','center');
                text(3,Track/2+Mito+0.035,[num2str(Track*100,4) '%'],'HorizontalAlignment','center');
                text(3,Track/2+Mito-0.035,'Track','HorizontalAlignment','center');
            end
            
            % Plot Fast Anterograde Ratio
            text(4,1.15,'Slow','HorizontalAlignment','center');
            text(4,1.08,'Anterograde','HorizontalAlignment','center');
            if Summary.Colocalization.Phases.Mito_Pop2_Plus == 0 && Summary.Colocalization.Phases.Track_Pop2_Plus == 0
                text(4,0.535,'No','HorizontalAlignment','center');
                text(4,0.475,'Data','HorizontalAlignment','center');
            elseif Summary.Colocalization.Phases.Mito_Pop2_Plus == 0 && Summary.Colocalization.Phases.Track_Pop2_Plus ~= 0
                bar(4,1,'b')
                text(4,0.535,'100%','HorizontalAlignment','center');
                text(4,0.475,'Track','HorizontalAlignment','center');
            elseif Summary.Colocalization.Phases.Mito_Pop2_Plus ~= 0 && Summary.Colocalization.Phases.Track_Pop2_Plus == 0
                bar(4,1,'EdgeColor','b','FaceColor','none')
                text(4,0.535,'100%','HorizontalAlignment','center');
                text(4,0.475,'Mito','HorizontalAlignment','center');
            elseif Summary.Colocalization.Phases.Mito_Pop2_Plus ~= 0 && Summary.Colocalization.Phases.Track_Pop2_Plus ~= 0
                bar(4,1,'EdgeColor','b','FaceColor','none')
                Mito=Summary.Colocalization.Phases.Mito_Pop2_Plus/...
                    (Summary.Colocalization.Phases.Mito_Pop2_Plus+Summary.Colocalization.Phases.Track_Pop2_Plus);
                Track=1-Mito;
                bar(4,Mito,'b')
                text(4,Mito/2+0.035,[num2str(Mito*100,4) '%'],'HorizontalAlignment','center');
                text(4,Mito/2-0.035,'Mito','HorizontalAlignment','center');
                text(4,Track/2+Mito+0.035,[num2str(Track*100,4) '%'],'HorizontalAlignment','center');
                text(4,Track/2+Mito-0.035,'Track','HorizontalAlignment','center');
            end
            
            % Plot Passive Ratio
            text(5,1.15,'Passive','HorizontalAlignment','center');
            if Summary.Colocalization.Phases.Mito_Passive == 0 && Summary.Colocalization.Phases.Track_Passive == 0
                text(5,0.535,'No','HorizontalAlignment','center');
                text(5,0.475,'Data','HorizontalAlignment','center');
            elseif Summary.Colocalization.Phases.Mito_Passive == 0 && Summary.Colocalization.Phases.Track_Passive ~= 0
                bar(5,1,'y')
                text(5,0.535,'100%','HorizontalAlignment','center');
                text(5,0.475,'Track','HorizontalAlignment','center');
            elseif Summary.Colocalization.Phases.Mito_Passive ~= 0 && Summary.Colocalization.Phases.Track_Passive == 0
                bar(5,1,'EdgeColor','y','FaceColor','none')
                text(5,0.535,'100%','HorizontalAlignment','center');
                text(5,0.475,'Mito','HorizontalAlignment','center');
            elseif Summary.Colocalization.Phases.Mito_Passive ~= 0 && Summary.Colocalization.Phases.Track_Passive ~= 0
                bar(5,1,'EdgeColor','y','FaceColor','none')
                Mito=Summary.Colocalization.Phases.Mito_Passive/...
                    (Summary.Colocalization.Phases.Mito_Passive+Summary.Colocalization.Phases.Track_Passive);
                Track=1-Mito;
                bar(5,Mito,'y')
                text(5,Mito/2+0.035,[num2str(Mito*100,4) '%'],'HorizontalAlignment','center');
                text(5,Mito/2-0.035,'Mito','HorizontalAlignment','center');
                text(5,Track/2+Mito+0.035,[num2str(Track*100,4) '%'],'HorizontalAlignment','center');
                text(5,Track/2+Mito-0.035,'Track','HorizontalAlignment','center');
            end
            
            %% Plot Mito/Track Orbits bars
            
            %Calculate the % of each Phase on Mitos
            Total_Mito=Summary.Colocalization.Orbits.Mito_Passive+...
                Summary.Colocalization.Orbits.Mito_Pop1_Minus+...
                Summary.Colocalization.Orbits.Mito_Pop1_Plus+...
                Summary.Colocalization.Orbits.Mito_Pop2_Minus+...
                Summary.Colocalization.Orbits.Mito_Pop2_Plus;
            
            %Passive
            Mito_Passive=Summary.Colocalization.Orbits.Mito_Passive/Total_Mito;
            
            %Retrograde
            Mito_Fast_Retro=Summary.Colocalization.Orbits.Mito_Pop1_Minus/Total_Mito;
            Mito_Slow_Retro=Summary.Colocalization.Orbits.Mito_Pop2_Minus/Total_Mito;
            
            %Anterograde
            Mito_Fast_Antero=Summary.Colocalization.Orbits.Mito_Pop1_Plus/Total_Mito;
            Mito_Slow_Antero=Summary.Colocalization.Orbits.Mito_Pop2_Plus/Total_Mito;
            
            %Array with Y Data
            Mito_Y=[Mito_Passive, Mito_Fast_Retro, Mito_Slow_Retro, Mito_Fast_Antero, Mito_Slow_Antero];
            Mito_YPlot=cumsum(Mito_Y);
            Mito_YPlot=fliplr(Mito_YPlot);
            Mito_Y=fliplr(Mito_Y);
            Mito_Text_Pos=Mito_YPlot-0.5*Mito_Y;
            
            
            %Calculate the % of each Phase on Tracks
            Total_Track=Summary.Colocalization.Orbits.Track_Passive+...
                Summary.Colocalization.Orbits.Track_Pop1_Minus+...
                Summary.Colocalization.Orbits.Track_Pop1_Plus+...
                Summary.Colocalization.Orbits.Track_Pop2_Minus+...
                Summary.Colocalization.Orbits.Track_Pop2_Plus;
            
            %Passive
            Track_Passive=Summary.Colocalization.Orbits.Track_Passive/Total_Track;
            
            %Retrograde
            Track_Fast_Retro=Summary.Colocalization.Orbits.Track_Pop1_Minus/Total_Track;
            Track_Slow_Retro=Summary.Colocalization.Orbits.Track_Pop2_Minus/Total_Track;
            
            %Anterograde
            Track_Fast_Antero=Summary.Colocalization.Orbits.Track_Pop1_Plus/Total_Track;
            Track_Slow_Antero=Summary.Colocalization.Orbits.Track_Pop2_Plus/Total_Track;
            
            %Array with Y Data
            Track_Y=[Track_Passive, Track_Fast_Retro, Track_Slow_Retro, Track_Fast_Antero, Track_Slow_Antero];
            Track_YPlot=cumsum(Track_Y);
            Track_YPlot=fliplr(Track_YPlot);
            Track_Y=fliplr(Track_Y);
            Track_Text_Pos=Track_YPlot-0.5*Track_Y;
            
            %YPosition Data Text
            Y_Pos_Text=[-0.75 0.75 -0.75 0.75 -0.75];
            
            %Colour Data
            C_Data={'b','g','m','r','y'};
            
            %Legend Data
            Legend=[1 0.8 0.6 0.4 0.2];
            Legend_Text_Pos=[0.9 0.7 0.5 0.3 0.1];
            Legend_Text={'Slow Antero','Fast Antero','Slow Retro', 'Fast Retro','Passive'  };
            
            
            %Plot into Axes
            axes(MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab5.Panel.Fig3) 
            cla(MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab5.Panel.Fig3) 
            hold on
            for i=1:length(Mito_Y)
                barh(1,Mito_YPlot(i),C_Data{i})
                if Mito_Y(i) > 0
                    text(Mito_Text_Pos(i),1+Y_Pos_Text(i),[num2str(Mito_Y(i)*100,4) '%'],'HorizontalAlignment','center');
                    i
                end
                barh(3,Track_YPlot(i),C_Data{i})
                if Track_Y(i) > 0
                    text(Track_Text_Pos(i),3+Y_Pos_Text(i),[num2str(Track_Y(i)*100,4) '%'],'HorizontalAlignment','center');
                    i
                end
                barh(4.9,Legend(i),'EdgeColor',C_Data{i},'FaceColor','none','LineWidth',2.5)
                text(Legend_Text_Pos(i),4.77,Legend_Text{i},'HorizontalAlignment','center');
                
            end
            ylim([0 5])
            xlim([0 1.2])
            text(1.1,1,'Mito','HorizontalAlignment','center');
            text(1.1,3,'Track','HorizontalAlignment','center');
            text(1.1,4.77,'Legend','HorizontalAlignment','center');
            hold off
            
            %% Plot Mito/Track Phases bars
            
            %Calculate the % of each Phase on Mitos
            Total_Mito=Summary.Colocalization.Phases.Mito_Passive+...
                Summary.Colocalization.Phases.Mito_Pop1_Minus+...
                Summary.Colocalization.Phases.Mito_Pop1_Plus+...
                Summary.Colocalization.Phases.Mito_Pop2_Minus+...
                Summary.Colocalization.Phases.Mito_Pop2_Plus;
            
            %Passive
            Mito_Passive=Summary.Colocalization.Phases.Mito_Passive/Total_Mito;
            
            %Retrograde
            Mito_Fast_Retro=Summary.Colocalization.Phases.Mito_Pop1_Minus/Total_Mito;
            Mito_Slow_Retro=Summary.Colocalization.Phases.Mito_Pop2_Minus/Total_Mito;
            
            %Anterograde
            Mito_Fast_Antero=Summary.Colocalization.Phases.Mito_Pop1_Plus/Total_Mito;
            Mito_Slow_Antero=Summary.Colocalization.Phases.Mito_Pop2_Plus/Total_Mito;
            
            %Array with Y Data
            Mito_Y=[Mito_Passive, Mito_Fast_Retro, Mito_Slow_Retro, Mito_Fast_Antero, Mito_Slow_Antero];
            Mito_YPlot=cumsum(Mito_Y);
            Mito_YPlot=fliplr(Mito_YPlot);
            Mito_Y=fliplr(Mito_Y);
            Mito_Text_Pos=Mito_YPlot-0.5*Mito_Y;
            
            
            %Calculate the % of each Phase on Tracks
            Total_Track=Summary.Colocalization.Phases.Track_Passive+...
                Summary.Colocalization.Phases.Track_Pop1_Minus+...
                Summary.Colocalization.Phases.Track_Pop1_Plus+...
                Summary.Colocalization.Phases.Track_Pop2_Minus+...
                Summary.Colocalization.Phases.Track_Pop2_Plus;
            
            %Passive
            Track_Passive=Summary.Colocalization.Phases.Track_Passive/Total_Track;
            
            %Retrograde
            Track_Fast_Retro=Summary.Colocalization.Phases.Track_Pop1_Minus/Total_Track;
            Track_Slow_Retro=Summary.Colocalization.Phases.Track_Pop2_Minus/Total_Track;
            
            %Anterograde
            Track_Fast_Antero=Summary.Colocalization.Phases.Track_Pop1_Plus/Total_Track;
            Track_Slow_Antero=Summary.Colocalization.Phases.Track_Pop2_Plus/Total_Track;
            
            %Array with Y Data
            Track_Y=[Track_Passive, Track_Fast_Retro, Track_Slow_Retro, Track_Fast_Antero, Track_Slow_Antero];
            Track_YPlot=cumsum(Track_Y);
            Track_YPlot=fliplr(Track_YPlot);
            Track_Y=fliplr(Track_Y);
            Track_Text_Pos=Track_YPlot-0.5*Track_Y;
            
            %YPosition Data Text
            Y_Pos_Text=[-0.75 0.75 -0.75 0.75 -0.75];
            
            %Colour Data
            C_Data={'b','g','m','r','y'};
            
            %Legend Data
            Legend=[1 0.8 0.6 0.4 0.2];
            Legend_Text_Pos=[0.9 0.7 0.5 0.3 0.1];
            Legend_Text={'Slow Antero','Fast Antero','Slow Retro', 'Fast Retro','Passive'  };
            
            
            %Plot into Axes
            axes(MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab5.Panel.Fig4) 
            cla(MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab5.Panel.Fig4) 
            hold on
            for i=1:length(Mito_Y)
                barh(1,Mito_YPlot(i),C_Data{i})
                if Mito_Y(i) > 0
                    text(Mito_Text_Pos(i),1+Y_Pos_Text(i),[num2str(Mito_Y(i)*100,4) '%'],'HorizontalAlignment','center');
                    i
                end
                barh(3,Track_YPlot(i),C_Data{i})
                if Track_Y(i) > 0
                    text(Track_Text_Pos(i),3+Y_Pos_Text(i),[num2str(Track_Y(i)*100,4) '%'],'HorizontalAlignment','center');
                    i
                end
                barh(4.9,Legend(i),'EdgeColor',C_Data{i},'FaceColor','none','LineWidth',2.5)
                text(Legend_Text_Pos(i),4.77,Legend_Text{i},'HorizontalAlignment','center');
                
            end
            ylim([0 5])
            xlim([0 1.2])
            text(1.1,1,'Mito','HorizontalAlignment','center');
            text(1.1,3,'Track','HorizontalAlignment','center');
            text(1.1,4.77,'Legend','HorizontalAlignment','center');
            hold off
            
        end
        
    else
        cla(MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab5.Panel.Fig1)    
        cla(MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab5.Panel.Fig2)    
        cla(MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab5.Panel.Fig3)    
        cla(MainFig.Maintab.Tab4.Panel.Tab.Tab2.Tab.Tab5.Panel.Fig4)      
    end
end



