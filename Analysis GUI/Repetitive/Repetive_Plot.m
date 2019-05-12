close all

%% Write Current M_FIle to Temp

%Detect Number of Elements in WOrkspace
Filelist=whos;
NumberEL=length(whos)-1;

figure(1)
hold on
for i=1:NumberEL
    %Write Current Trajectory to temp file
    TempFile=Filelist(i);
    Temp=eval(TempFile.name);
    if Temp.Trajectory.Trajectory(end,2)-Temp.Trajectory.Trajectory(1,2) > 0
        C='.g';
    else
        C='.r';
    end
    plot([min(Temp.Trajectory.Trajectory(:,2)) max(Temp.Trajectory.Trajectory(:,2))],[i i],'Color',[0.5 0.5 0.5],'LineWidth',2)
    plot(Temp.Passive.Trajectory_Data(:,2),ones(length(Temp.Passive.Trajectory_Data),1)*i,C,'MarkerSize',20)
end
ylim([0 i+1])
xlabel('y [µm]')
set(gca,'FontSize',16)
hold off
clear i
clear Filelist
clear NumberEL
clear Temp
clear TempFile
clear C