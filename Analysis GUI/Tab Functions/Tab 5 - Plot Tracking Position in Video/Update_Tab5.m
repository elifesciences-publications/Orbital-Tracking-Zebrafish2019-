function Update_Tab5(~,~)
%% Initialize Global Variables
%Figure Variable
global MainFig;
%Variables to save data
global M_File;
%Variable for Summary
global Summary
%Variable To Store Video Information
global Video_Temp


%%Update Values in Tab 5
if isfield(M_File,'Video_Data') == 1
    MainFig.Maintab.Tab5.Panel.Videopanel.XYShiftpanel.XShift_Edit.String=M_File.Video_Data.XShift;
    MainFig.Maintab.Tab5.Panel.Videopanel.XYShiftpanel.YShift_Edit.String=M_File.Video_Data.YShift;
    MainFig.Maintab.Tab5.Panel.Videopanel.Frameshift.Frameshift_Edit.String=M_File.Video_Data.Frame_Shift;
    MainFig.Maintab.Tab5.Panel.Colocalizationpanel.Start_Edit.String=1;
    MainFig.Maintab.Tab5.Panel.Colocalizationpanel.Start_Static.String='Start Long Range Phase [1]';
    MainFig.Maintab.Tab5.Panel.Colocalizationpanel.End_Edit.String=M_File.Colocalization.Max_Frame;
    MainFig.Maintab.Tab5.Panel.Colocalizationpanel.End_Static.String=['End Long Range Phase [' num2str(length(M_File.Video_Data.Cam_Long_Range)) ']'];
end

%% Update Colocalization Results
if isfield(M_File,'Colocalization') == 1
    if isfield(M_File.Colocalization,'Orbits') == 1
        
        %% Plot Orbit Ratio Axes
        axes(MainFig.Maintab.Tab5.Panel.Colocalizationpanel.Tab.Tab1.Panel.Axes)
        cla(MainFig.Maintab.Tab5.Panel.Colocalizationpanel.Tab.Tab1.Panel.Axes)
        xlim([0.5 5.5])
        ylim([0 1.2])
        hold on
        % Plot Fast Retrograde Ratio
        text(1,1.15,'Fast','HorizontalAlignment','center');
        text(1,1.08,'Retrograde','HorizontalAlignment','center');
        if M_File.Colocalization.Orbits.Mito_Pop1_Minus == 0 && M_File.Colocalization.Orbits.Track_Pop1_Minus == 0
            text(1,0.535,'No','HorizontalAlignment','center');
            text(1,0.475,'Data','HorizontalAlignment','center');
        elseif M_File.Colocalization.Orbits.Mito_Pop1_Minus == 0 && M_File.Colocalization.Orbits.Track_Pop1_Minus ~= 0
            bar(1,1,'r')
            text(1,0.535,'100%','HorizontalAlignment','center');
            text(1,0.475,'Track','HorizontalAlignment','center');
        elseif M_File.Colocalization.Orbits.Mito_Pop1_Minus ~= 0 && M_File.Colocalization.Orbits.Track_Pop1_Minus == 0
            bar(1,1,'EdgeColor','r','FaceColor','none')
            text(1,0.535,'100%','HorizontalAlignment','center');
            text(1,0.475,'Mito','HorizontalAlignment','center');
        elseif M_File.Colocalization.Orbits.Mito_Pop1_Minus ~= 0 && M_File.Colocalization.Orbits.Track_Pop1_Minus ~= 0
            bar(1,1,'EdgeColor','r','FaceColor','none')
            Mito=M_File.Colocalization.Orbits.Mito_Pop1_Minus/...
                (M_File.Colocalization.Orbits.Mito_Pop1_Minus+M_File.Colocalization.Orbits.Track_Pop1_Minus);
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
        if M_File.Colocalization.Orbits.Mito_Pop1_Plus == 0 && M_File.Colocalization.Orbits.Track_Pop1_Plus == 0
            text(2,0.535,'No','HorizontalAlignment','center');
            text(2,0.475,'Data','HorizontalAlignment','center');
        elseif M_File.Colocalization.Orbits.Mito_Pop1_Plus == 0 && M_File.Colocalization.Orbits.Track_Pop1_Plus ~= 0
            bar(2,1,'g')
            text(2,0.535,'100%','HorizontalAlignment','center');
            text(2,0.475,'Track','HorizontalAlignment','center');
        elseif M_File.Colocalization.Orbits.Mito_Pop1_Plus ~= 0 && M_File.Colocalization.Orbits.Track_Pop1_Plus == 0
            bar(2,1,'EdgeColor','g','FaceColor','none')
            text(2,0.535,'100%','HorizontalAlignment','center');
            text(2,0.475,'Mito','HorizontalAlignment','center');
        elseif M_File.Colocalization.Orbits.Mito_Pop1_Plus ~= 0 && M_File.Colocalization.Orbits.Track_Pop1_Plus ~= 0
            bar(2,1,'EdgeColor','g','FaceColor','none')
            Mito=M_File.Colocalization.Orbits.Mito_Pop1_Plus/...
                (M_File.Colocalization.Orbits.Mito_Pop1_Plus+M_File.Colocalization.Orbits.Track_Pop1_Plus);
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
        if M_File.Colocalization.Orbits.Mito_Pop2_Minus == 0 && M_File.Colocalization.Orbits.Track_Pop2_Minus == 0
            text(3,0.535,'No','HorizontalAlignment','center');
            text(3,0.475,'Data','HorizontalAlignment','center');
        elseif M_File.Colocalization.Orbits.Mito_Pop2_Minus == 0 && M_File.Colocalization.Orbits.Track_Pop2_Minus ~= 0
            bar(3,1,'m')
            text(3,0.535,'100%','HorizontalAlignment','center');
            text(3,0.475,'Track','HorizontalAlignment','center');
        elseif M_File.Colocalization.Orbits.Mito_Pop2_Minus ~= 0 && M_File.Colocalization.Orbits.Track_Pop2_Minus == 0
            bar(3,1,'EdgeColor','m','FaceColor','none')
            text(3,0.535,'100%','HorizontalAlignment','center');
            text(3,0.475,'Mito','HorizontalAlignment','center');
        elseif M_File.Colocalization.Orbits.Mito_Pop2_Minus ~= 0 && M_File.Colocalization.Orbits.Track_Pop2_Minus ~= 0
            bar(3,1,'EdgeColor','m','FaceColor','none')
            Mito=M_File.Colocalization.Orbits.Mito_Pop2_Minus/...
                (M_File.Colocalization.Orbits.Mito_Pop2_Minus+M_File.Colocalization.Orbits.Track_Pop2_Minus);
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
        if M_File.Colocalization.Orbits.Mito_Pop2_Plus == 0 && M_File.Colocalization.Orbits.Track_Pop2_Plus == 0
            text(4,0.535,'No','HorizontalAlignment','center');
            text(4,0.475,'Data','HorizontalAlignment','center');
        elseif M_File.Colocalization.Orbits.Mito_Pop2_Plus == 0 && M_File.Colocalization.Orbits.Track_Pop2_Plus ~= 0
            bar(4,1,'b')
            text(4,0.535,'100%','HorizontalAlignment','center');
            text(4,0.475,'Track','HorizontalAlignment','center');
        elseif M_File.Colocalization.Orbits.Mito_Pop2_Plus ~= 0 && M_File.Colocalization.Orbits.Track_Pop2_Plus == 0
            bar(4,1,'EdgeColor','b','FaceColor','none')
            text(4,0.535,'100%','HorizontalAlignment','center');
            text(4,0.475,'Mito','HorizontalAlignment','center');
        elseif M_File.Colocalization.Orbits.Mito_Pop2_Plus ~= 0 && M_File.Colocalization.Orbits.Track_Pop2_Plus ~= 0
            bar(4,1,'EdgeColor','b','FaceColor','none')
            Mito=M_File.Colocalization.Orbits.Mito_Pop2_Plus/...
                (M_File.Colocalization.Orbits.Mito_Pop2_Plus+M_File.Colocalization.Orbits.Track_Pop2_Plus);
            Track=1-Mito;
            bar(4,Mito,'b')
            text(4,Mito/2+0.035,[num2str(Mito*100,4) '%'],'HorizontalAlignment','center');
            text(4,Mito/2-0.035,'Mito','HorizontalAlignment','center');
            text(4,Track/2+Mito+0.035,[num2str(Track*100,4) '%'],'HorizontalAlignment','center');
            text(4,Track/2+Mito-0.035,'Track','HorizontalAlignment','center');
        end
        
        % Plot Passive Ratio
        text(5,1.15,'Passive','HorizontalAlignment','center');
        if M_File.Colocalization.Orbits.Mito_Passive == 0 && M_File.Colocalization.Orbits.Track_Passive == 0
            text(5,0.535,'No','HorizontalAlignment','center');
            text(5,0.475,'Data','HorizontalAlignment','center');
        elseif M_File.Colocalization.Orbits.Mito_Passive == 0 && M_File.Colocalization.Orbits.Track_Passive ~= 0
            bar(5,1,'y')
            text(5,0.535,'100%','HorizontalAlignment','center');
            text(5,0.475,'Track','HorizontalAlignment','center');
        elseif M_File.Colocalization.Orbits.Mito_Passive ~= 0 && M_File.Colocalization.Orbits.Track_Passive == 0
            bar(5,1,'EdgeColor','y','FaceColor','none')
            text(5,0.535,'100%','HorizontalAlignment','center');
            text(5,0.475,'Mito','HorizontalAlignment','center');
        elseif M_File.Colocalization.Orbits.Mito_Passive ~= 0 && M_File.Colocalization.Orbits.Track_Passive ~= 0
            bar(5,1,'EdgeColor','y','FaceColor','none')
            Mito=M_File.Colocalization.Orbits.Mito_Passive/...
                (M_File.Colocalization.Orbits.Mito_Passive+M_File.Colocalization.Orbits.Track_Passive);
            Track=1-Mito;
            bar(5,Mito,'y')
            text(5,Mito/2+0.035,[num2str(Mito*100,4) '%'],'HorizontalAlignment','center');
            text(5,Mito/2-0.035,'Mito','HorizontalAlignment','center');
            text(5,Track/2+Mito+0.035,[num2str(Track*100,4) '%'],'HorizontalAlignment','center');
            text(5,Track/2+Mito-0.035,'Track','HorizontalAlignment','center');
        end   
        
        %% Plot Phases Ratio Axes
        axes(MainFig.Maintab.Tab5.Panel.Colocalizationpanel.Tab.Tab2.Panel.Axes)
        cla(MainFig.Maintab.Tab5.Panel.Colocalizationpanel.Tab.Tab2.Panel.Axes)
        xlim([0.5 5.5])
        ylim([0 1.2])
        hold on
        % Plot Fast Retrograde Ratio
        text(1,1.15,'Fast','HorizontalAlignment','center');
        text(1,1.08,'Retrograde','HorizontalAlignment','center');
        if M_File.Colocalization.Phases.Mito_Pop1_Minus == 0 && M_File.Colocalization.Phases.Track_Pop1_Minus == 0
            text(1,0.535,'No','HorizontalAlignment','center');
            text(1,0.475,'Data','HorizontalAlignment','center');
        elseif M_File.Colocalization.Phases.Mito_Pop1_Minus == 0 && M_File.Colocalization.Phases.Track_Pop1_Minus ~= 0
            bar(1,1,'r')
            text(1,0.535,'100%','HorizontalAlignment','center');
            text(1,0.475,'Track','HorizontalAlignment','center');
        elseif M_File.Colocalization.Phases.Mito_Pop1_Minus ~= 0 && M_File.Colocalization.Phases.Track_Pop1_Minus == 0
            bar(1,1,'EdgeColor','r','FaceColor','none')
            text(1,0.535,'100%','HorizontalAlignment','center');
            text(1,0.475,'Mito','HorizontalAlignment','center');
        elseif M_File.Colocalization.Phases.Mito_Pop1_Minus ~= 0 && M_File.Colocalization.Phases.Track_Pop1_Minus ~= 0
            bar(1,1,'EdgeColor','r','FaceColor','none')
            Mito=M_File.Colocalization.Phases.Mito_Pop1_Minus/...
                (M_File.Colocalization.Phases.Mito_Pop1_Minus+M_File.Colocalization.Phases.Track_Pop1_Minus);
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
        if M_File.Colocalization.Phases.Mito_Pop1_Plus == 0 && M_File.Colocalization.Phases.Track_Pop1_Plus == 0
            text(2,0.535,'No','HorizontalAlignment','center');
            text(2,0.475,'Data','HorizontalAlignment','center');
        elseif M_File.Colocalization.Phases.Mito_Pop1_Plus == 0 && M_File.Colocalization.Phases.Track_Pop1_Plus ~= 0
            bar(2,1,'g')
            text(2,0.535,'100%','HorizontalAlignment','center');
            text(2,0.475,'Track','HorizontalAlignment','center');
        elseif M_File.Colocalization.Phases.Mito_Pop1_Plus ~= 0 && M_File.Colocalization.Phases.Track_Pop1_Plus == 0
            bar(2,1,'EdgeColor','g','FaceColor','none')
            text(2,0.535,'100%','HorizontalAlignment','center');
            text(2,0.475,'Mito','HorizontalAlignment','center');
        elseif M_File.Colocalization.Phases.Mito_Pop1_Plus ~= 0 && M_File.Colocalization.Phases.Track_Pop1_Plus ~= 0
            bar(2,1,'EdgeColor','g','FaceColor','none')
            Mito=M_File.Colocalization.Phases.Mito_Pop1_Plus/...
                (M_File.Colocalization.Phases.Mito_Pop1_Plus+M_File.Colocalization.Phases.Track_Pop1_Plus);
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
        if M_File.Colocalization.Phases.Mito_Pop2_Minus == 0 && M_File.Colocalization.Phases.Track_Pop2_Minus == 0
            text(3,0.535,'No','HorizontalAlignment','center');
            text(3,0.475,'Data','HorizontalAlignment','center');
        elseif M_File.Colocalization.Phases.Mito_Pop2_Minus == 0 && M_File.Colocalization.Phases.Track_Pop2_Minus ~= 0
            bar(3,1,'m')
            text(3,0.535,'100%','HorizontalAlignment','center');
            text(3,0.475,'Track','HorizontalAlignment','center');
        elseif M_File.Colocalization.Phases.Mito_Pop2_Minus ~= 0 && M_File.Colocalization.Phases.Track_Pop2_Minus == 0
            bar(3,1,'EdgeColor','m','FaceColor','none')
            text(3,0.535,'100%','HorizontalAlignment','center');
            text(3,0.475,'Mito','HorizontalAlignment','center');
        elseif M_File.Colocalization.Phases.Mito_Pop2_Minus ~= 0 && M_File.Colocalization.Phases.Track_Pop2_Minus ~= 0
            bar(3,1,'EdgeColor','m','FaceColor','none')
            Mito=M_File.Colocalization.Phases.Mito_Pop2_Minus/...
                (M_File.Colocalization.Phases.Mito_Pop2_Minus+M_File.Colocalization.Phases.Track_Pop2_Minus);
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
        if M_File.Colocalization.Phases.Mito_Pop2_Plus == 0 && M_File.Colocalization.Phases.Track_Pop2_Plus == 0
            text(4,0.535,'No','HorizontalAlignment','center');
            text(4,0.475,'Data','HorizontalAlignment','center');
        elseif M_File.Colocalization.Phases.Mito_Pop2_Plus == 0 && M_File.Colocalization.Phases.Track_Pop2_Plus ~= 0
            bar(4,1,'b')
            text(4,0.535,'100%','HorizontalAlignment','center');
            text(4,0.475,'Track','HorizontalAlignment','center');
        elseif M_File.Colocalization.Phases.Mito_Pop2_Plus ~= 0 && M_File.Colocalization.Phases.Track_Pop2_Plus == 0
            bar(4,1,'EdgeColor','b','FaceColor','none')
            text(4,0.535,'100%','HorizontalAlignment','center');
            text(4,0.475,'Mito','HorizontalAlignment','center');
        elseif M_File.Colocalization.Phases.Mito_Pop2_Plus ~= 0 && M_File.Colocalization.Phases.Track_Pop2_Plus ~= 0
            bar(4,1,'EdgeColor','b','FaceColor','none')
            Mito=M_File.Colocalization.Phases.Mito_Pop2_Plus/...
                (M_File.Colocalization.Phases.Mito_Pop2_Plus+M_File.Colocalization.Phases.Track_Pop2_Plus);
            Track=1-Mito;
            bar(4,Mito,'b')
            text(4,Mito/2+0.035,[num2str(Mito*100,4) '%'],'HorizontalAlignment','center');
            text(4,Mito/2-0.035,'Mito','HorizontalAlignment','center');
            text(4,Track/2+Mito+0.035,[num2str(Track*100,4) '%'],'HorizontalAlignment','center');
            text(4,Track/2+Mito-0.035,'Track','HorizontalAlignment','center');
        end
        
        % Plot Passive Ratio
        text(5,1.15,'Passive','HorizontalAlignment','center');
        if M_File.Colocalization.Phases.Mito_Passive == 0 && M_File.Colocalization.Phases.Track_Passive == 0
            text(5,0.535,'No','HorizontalAlignment','center');
            text(5,0.475,'Data','HorizontalAlignment','center');
        elseif M_File.Colocalization.Phases.Mito_Passive == 0 && M_File.Colocalization.Phases.Track_Passive ~= 0
            bar(5,1,'y')
            text(5,0.535,'100%','HorizontalAlignment','center');
            text(5,0.475,'Track','HorizontalAlignment','center');
        elseif M_File.Colocalization.Phases.Mito_Passive ~= 0 && M_File.Colocalization.Phases.Track_Passive == 0
            bar(5,1,'EdgeColor','y','FaceColor','none')
            text(5,0.535,'100%','HorizontalAlignment','center');
            text(5,0.475,'Mito','HorizontalAlignment','center');
        elseif M_File.Colocalization.Phases.Mito_Passive ~= 0 && M_File.Colocalization.Phases.Track_Passive ~= 0
            bar(5,1,'EdgeColor','y','FaceColor','none')
            Mito=M_File.Colocalization.Phases.Mito_Passive/...
                (M_File.Colocalization.Phases.Mito_Passive+M_File.Colocalization.Phases.Track_Passive);
            Track=1-Mito;
            bar(5,Mito,'y')
            text(5,Mito/2+0.035,[num2str(Mito*100,4) '%'],'HorizontalAlignment','center');
            text(5,Mito/2-0.035,'Mito','HorizontalAlignment','center');
            text(5,Track/2+Mito+0.035,[num2str(Track*100,4) '%'],'HorizontalAlignment','center');
            text(5,Track/2+Mito-0.035,'Track','HorizontalAlignment','center');
        end
        
        %% Plot Mito/Track Orbits bars
        
        %Calculate the % of each Phase on Mitos
        Total_Mito=M_File.Colocalization.Orbits.Mito_Passive+...
            M_File.Colocalization.Orbits.Mito_Pop1_Minus+...
            M_File.Colocalization.Orbits.Mito_Pop1_Plus+...
            M_File.Colocalization.Orbits.Mito_Pop2_Minus+...
            M_File.Colocalization.Orbits.Mito_Pop2_Plus;
        
        %Passive
        Mito_Passive=M_File.Colocalization.Orbits.Mito_Passive/Total_Mito;
        
        %Retrograde
        Mito_Fast_Retro=M_File.Colocalization.Orbits.Mito_Pop1_Minus/Total_Mito;
        Mito_Slow_Retro=M_File.Colocalization.Orbits.Mito_Pop2_Minus/Total_Mito;
        
        %Anterograde
        Mito_Fast_Antero=M_File.Colocalization.Orbits.Mito_Pop1_Plus/Total_Mito;
        Mito_Slow_Antero=M_File.Colocalization.Orbits.Mito_Pop2_Plus/Total_Mito;
        
        %Array with Y Data
        Mito_Y=[Mito_Passive, Mito_Fast_Retro, Mito_Slow_Retro, Mito_Fast_Antero, Mito_Slow_Antero];
        Mito_YPlot=cumsum(Mito_Y);
        Mito_YPlot=fliplr(Mito_YPlot);
        Mito_Y=fliplr(Mito_Y);
        Mito_Text_Pos=Mito_YPlot-0.5*Mito_Y;
        
        
        %Calculate the % of each Phase on Tracks
        Total_Track=M_File.Colocalization.Orbits.Track_Passive+...
            M_File.Colocalization.Orbits.Track_Pop1_Minus+...
            M_File.Colocalization.Orbits.Track_Pop1_Plus+...
            M_File.Colocalization.Orbits.Track_Pop2_Minus+...
            M_File.Colocalization.Orbits.Track_Pop2_Plus;
        
        %Passive
        Track_Passive=M_File.Colocalization.Orbits.Track_Passive/Total_Track;
        
        %Retrograde
        Track_Fast_Retro=M_File.Colocalization.Orbits.Track_Pop1_Minus/Total_Track;
        Track_Slow_Retro=M_File.Colocalization.Orbits.Track_Pop2_Minus/Total_Track;
        
        %Anterograde
        Track_Fast_Antero=M_File.Colocalization.Orbits.Track_Pop1_Plus/Total_Track;
        Track_Slow_Antero=M_File.Colocalization.Orbits.Track_Pop2_Plus/Total_Track;
        
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
        axes(MainFig.Maintab.Tab5.Panel.Colocalizationpanel.Tab.Tab3.Panel.Axes)
        cla(MainFig.Maintab.Tab5.Panel.Colocalizationpanel.Tab.Tab3.Panel.Axes)
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
        Total_Mito=M_File.Colocalization.Phases.Mito_Passive+...
            M_File.Colocalization.Phases.Mito_Pop1_Minus+...
            M_File.Colocalization.Phases.Mito_Pop1_Plus+...
            M_File.Colocalization.Phases.Mito_Pop2_Minus+...
            M_File.Colocalization.Phases.Mito_Pop2_Plus;
        
        %Passive
        Mito_Passive=M_File.Colocalization.Phases.Mito_Passive/Total_Mito;
        
        %Retrograde
        Mito_Fast_Retro=M_File.Colocalization.Phases.Mito_Pop1_Minus/Total_Mito;
        Mito_Slow_Retro=M_File.Colocalization.Phases.Mito_Pop2_Minus/Total_Mito;
        
        %Anterograde
        Mito_Fast_Antero=M_File.Colocalization.Phases.Mito_Pop1_Plus/Total_Mito;
        Mito_Slow_Antero=M_File.Colocalization.Phases.Mito_Pop2_Plus/Total_Mito;
        
        %Array with Y Data
        Mito_Y=[Mito_Passive, Mito_Fast_Retro, Mito_Slow_Retro, Mito_Fast_Antero, Mito_Slow_Antero];
        Mito_YPlot=cumsum(Mito_Y);
        Mito_YPlot=fliplr(Mito_YPlot);
        Mito_Y=fliplr(Mito_Y);
        Mito_Text_Pos=Mito_YPlot-0.5*Mito_Y;
        
        
        %Calculate the % of each Phase on Tracks
        Total_Track=M_File.Colocalization.Phases.Track_Passive+...
            M_File.Colocalization.Phases.Track_Pop1_Minus+...
            M_File.Colocalization.Phases.Track_Pop1_Plus+...
            M_File.Colocalization.Phases.Track_Pop2_Minus+...
            M_File.Colocalization.Phases.Track_Pop2_Plus;
        
        %Passive
        Track_Passive=M_File.Colocalization.Phases.Track_Passive/Total_Track;
        
        %Retrograde
        Track_Fast_Retro=M_File.Colocalization.Phases.Track_Pop1_Minus/Total_Track;
        Track_Slow_Retro=M_File.Colocalization.Phases.Track_Pop2_Minus/Total_Track;
        
        %Anterograde
        Track_Fast_Antero=M_File.Colocalization.Phases.Track_Pop1_Plus/Total_Track;
        Track_Slow_Antero=M_File.Colocalization.Phases.Track_Pop2_Plus/Total_Track;
        
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
        axes(MainFig.Maintab.Tab5.Panel.Colocalizationpanel.Tab.Tab4.Panel.Axes)
        cla(MainFig.Maintab.Tab5.Panel.Colocalizationpanel.Tab.Tab4.Panel.Axes)
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
    cla(MainFig.Maintab.Tab5.Panel.Colocalizationpanel.Tab.Tab1.Panel.Axes)
    cla(MainFig.Maintab.Tab5.Panel.Colocalizationpanel.Tab.Tab2.Panel.Axes)
    cla(MainFig.Maintab.Tab5.Panel.Colocalizationpanel.Tab.Tab3.Panel.Axes)
    cla(MainFig.Maintab.Tab5.Panel.Colocalizationpanel.Tab.Tab4.Panel.Axes)
    
    MainFig.Maintab.Tab5.Panel.Colocalizationpanel.End_Static.String='End Long Range Phase [?]';
    MainFig.Maintab.Tab5.Panel.Colocalizationpanel.End_Edit.String='0';
    MainFig.Maintab.Tab5.Panel.Colocalizationpanel.Start_Static.String='Start Long Range Phase [?]';
    MainFig.Maintab.Tab5.Panel.Colocalizationpanel.Start_Edit.String='0';
    MainFig.Maintab.Tab5.Panel.Videopanel.Frameshift.Frameshift_Edit.String='0';
    MainFig.Maintab.Tab5.Panel.Videopanel.XYShiftpanel.XShift_Edit.String='0';
    MainFig.Maintab.Tab5.Panel.Videopanel.XYShiftpanel.YShift_Edit.String='0';
    
end

%% Clear Video
if isfield(Video_Temp,'Tifstack') == 0
    Video_Temp=[];
    MainFig.Maintab.Tab5.Panel.Fig1_Image.CData=ones(512,512,3);
    MainFig.Maintab.Tab5.Panel.Fig1_Image.HitTest = 'off';
    MainFig.Maintab.Tab5.Panel.Fig1.ButtonDownFcn = @Video_Controls;
    MainFig.Maintab.Tab5.Panel.Slider.Value=0;
end
