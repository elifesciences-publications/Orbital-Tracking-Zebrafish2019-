function Summarize_Data(~,~)
%% Initialize Global Variables
%Figure Variable
global MainFig;
%Variables to save data
global M_File;
%Variable for Summary
global Summary

%% Create Variables in Summary Variable
%Pop1 Plus
Summary.Pop1_Plus.Duration_Active_Phase=[];
Summary.Pop1_Plus.XY_Displacement=[];
Summary.Pop1_Plus.XY_Stepsize=[];
Summary.Pop1_Plus.Y_Stepsize=[];

%Pop2 Plus
Summary.Pop2_Plus.Duration_Active_Phase=[];
Summary.Pop2_Plus.XY_Displacement=[];
Summary.Pop2_Plus.XY_Stepsize=[];
Summary.Pop2_Plus.Y_Stepsize=[];

%Pop1 Minus
Summary.Pop1_Minus.Duration_Active_Phase=[];
Summary.Pop1_Minus.XY_Displacement=[];
Summary.Pop1_Minus.XY_Stepsize=[];
Summary.Pop1_Minus.Y_Stepsize=[];

%Pop2 Minus
Summary.Pop2_Minus.Duration_Active_Phase=[];
Summary.Pop2_Minus.XY_Displacement=[];
Summary.Pop2_Minus.XY_Stepsize=[];
Summary.Pop2_Minus.Y_Stepsize=[];

%Passive
Summary.Passive.XY_Stepsize=[];
Summary.Passive.Length=[];
Summary.Passive.Y_Stepsize=[];

%Transitions
Summary.Transition.Matrix=zeros(4,4);
Summary.Transition.Pause=cell(4);

%Colocalization
Summary.Colocalization.Orbits.Mito_Pop1_Plus=0;
Summary.Colocalization.Orbits.Mito_Pop2_Plus=0;
Summary.Colocalization.Orbits.Mito_Pop1_Minus=0;
Summary.Colocalization.Orbits.Mito_Pop2_Minus=0;
Summary.Colocalization.Orbits.Mito_Passive=0;

Summary.Colocalization.Orbits.Track_Pop1_Plus=0;
Summary.Colocalization.Orbits.Track_Pop2_Plus=0;
Summary.Colocalization.Orbits.Track_Pop1_Minus=0;
Summary.Colocalization.Orbits.Track_Pop2_Minus=0;
Summary.Colocalization.Orbits.Track_Passive=0;

Summary.Colocalization.Phases.Mito_Pop1_Plus=0;
Summary.Colocalization.Phases.Mito_Pop2_Plus=0;
Summary.Colocalization.Phases.Mito_Pop1_Minus=0;
Summary.Colocalization.Phases.Mito_Pop2_Minus=0;
Summary.Colocalization.Phases.Mito_Passive=0;

Summary.Colocalization.Phases.Track_Pop1_Plus=0;
Summary.Colocalization.Phases.Track_Pop2_Plus=0;
Summary.Colocalization.Phases.Track_Pop1_Minus=0;
Summary.Colocalization.Phases.Track_Pop2_Minus=0;
Summary.Colocalization.Phases.Track_Passive=0;


% Collect individual data from each trajectory
Summary.Colocalization.Orbits.Mito_Pop1_Plus_All=0;
Summary.Colocalization.Orbits.Mito_Pop2_Plus_All=0;
Summary.Colocalization.Orbits.Mito_Pop1_Minus_All=0;
Summary.Colocalization.Orbits.Mito_Pop2_Minus_All=0;
Summary.Colocalization.Orbits.Mito_Passive_All=0;

Summary.Colocalization.Orbits.Track_Pop1_Plus_All=0;
Summary.Colocalization.Orbits.Track_Pop2_Plus_All=0;
Summary.Colocalization.Orbits.Track_Pop1_Minus_All=0;
Summary.Colocalization.Orbits.Track_Pop2_Minus_All=0;
Summary.Colocalization.Orbits.Track_Passive_All=0;

Summary.Colocalization.Phases.Mito_Pop1_Plus_All=0;
Summary.Colocalization.Phases.Mito_Pop2_Plus_All=0;
Summary.Colocalization.Phases.Mito_Pop1_Minus_All=0;
Summary.Colocalization.Phases.Mito_Pop2_Minus_All=0;
Summary.Colocalization.Phases.Mito_Passive_All=0;

Summary.Colocalization.Phases.Track_Pop1_Plus_All=0;
Summary.Colocalization.Phases.Track_Pop2_Plus_All=0;
Summary.Colocalization.Phases.Track_Pop1_Minus_All=0;
Summary.Colocalization.Phases.Track_Pop2_Minus_All=0;
Summary.Colocalization.Phases.Track_Passive_All=0;


Summary.Filelist=MainFig.Maintab.Tab4.Panel.Tab.Tab1.Table.Data;






for i=1:length(Summary.Filelist(:,1))
    
    if cell2mat(Summary.Filelist(i,2)) == 1
        load(Summary.Filelist{i,1});
        if M_File.Dynamics.Enough_Data_Plus == 1
            %Pop1 Plus
            Summary.Pop1_Plus.Duration_Active_Phase=...
                [Summary.Pop1_Plus.Duration_Active_Phase M_File.Pop1_Plus.Duration_Active_Phase];
            Summary.Pop1_Plus.XY_Displacement=...
                [Summary.Pop1_Plus.XY_Displacement M_File.Pop1_Plus.XY_Displacement];
            Summary.Pop1_Plus.XY_Stepsize=...
                [Summary.Pop1_Plus.XY_Stepsize M_File.Pop1_Plus.XY_Stepsize'];
            Summary.Pop1_Plus.Y_Stepsize=...
                [Summary.Pop1_Plus.Y_Stepsize...
                (M_File.Pop1_Plus.Trajectory_Data(2:end,2)-M_File.Pop1_Plus.Trajectory_Data(1:end-1,2))'];
            
            %Pop2 Plus
            Summary.Pop2_Plus.Duration_Active_Phase=...
                [Summary.Pop2_Plus.Duration_Active_Phase M_File.Pop2_Plus.Duration_Active_Phase];
            Summary.Pop2_Plus.XY_Displacement=...
                [Summary.Pop2_Plus.XY_Displacement M_File.Pop2_Plus.XY_Displacement];
            Summary.Pop2_Plus.XY_Stepsize=...
                [Summary.Pop2_Plus.XY_Stepsize M_File.Pop2_Plus.XY_Stepsize'];
            Summary.Pop2_Plus.Y_Stepsize=...
                [Summary.Pop2_Plus.Y_Stepsize...
                (M_File.Pop2_Plus.Trajectory_Data(2:end,2)-M_File.Pop2_Plus.Trajectory_Data(1:end-1,2))'];
        end
        
        if M_File.Dynamics.Enough_Data_Minus == 1
            %Pop1 Minus
            Summary.Pop1_Minus.Duration_Active_Phase=...
                [Summary.Pop1_Minus.Duration_Active_Phase M_File.Pop1_Minus.Duration_Active_Phase];
            Summary.Pop1_Minus.XY_Displacement=...
                [Summary.Pop1_Minus.XY_Displacement M_File.Pop1_Minus.XY_Displacement];
            Summary.Pop1_Minus.XY_Stepsize=...
                [Summary.Pop1_Minus.XY_Stepsize M_File.Pop1_Minus.XY_Stepsize'];
            Summary.Pop1_Minus.Y_Stepsize=...
                [Summary.Pop1_Minus.Y_Stepsize...
                (M_File.Pop1_Minus.Trajectory_Data(2:end,2)-M_File.Pop1_Minus.Trajectory_Data(1:end-1,2))'];
            
            %Pop2 Minus
            Summary.Pop2_Minus.Duration_Active_Phase=...
                [Summary.Pop2_Minus.Duration_Active_Phase M_File.Pop2_Minus.Duration_Active_Phase];
            Summary.Pop2_Minus.XY_Displacement=...
                [Summary.Pop2_Minus.XY_Displacement M_File.Pop2_Minus.XY_Displacement];
            Summary.Pop2_Minus.XY_Stepsize=...
                [Summary.Pop2_Minus.XY_Stepsize M_File.Pop2_Minus.XY_Stepsize'];
            Summary.Pop2_Minus.Y_Stepsize=...
                [Summary.Pop2_Minus.Y_Stepsize...
                (M_File.Pop2_Minus.Trajectory_Data(2:end,2)-M_File.Pop2_Minus.Trajectory_Data(1:end-1,2))'];
            
            %Passive
            Summary.Passive.XY_Stepsize=...
                [Summary.Passive.XY_Stepsize M_File.Passive.XY_Stepsize'];
            Summary.Passive.Length=...
                [Summary.Passive.Length M_File.Passive.Orbit_Length_Passive_Phase];
            Summary.Passive.Y_Stepsize=...
                [Summary.Passive.Y_Stepsize...
                (M_File.Passive.Trajectory_Data(2:end,2)-M_File.Passive.Trajectory_Data(1:end-1,2))'];
        end
        
        
        %Transitions
        Summary.Transition.Matrix=Summary.Transition.Matrix+M_File.Transition.Matrix;
        for j=1:16
            Summary.Transition.Pause{j}=[(Summary.Transition.Pause{j}) (M_File.Transition.Pause{j})];
            Bla=Summary.Transition.Pause{j};
            Bla(Bla==0)=[];
            Summary.Transition.Pause{j}=Bla;
        end
        
        %Colocalization
        if isfield(M_File,'Colocalization') == 1
            if isfield(M_File.Colocalization,'Orbits') == 1
                %Summary Orbits Mito
                Summary.Colocalization.Orbits.Mito_Pop1_Plus=...
                    Summary.Colocalization.Orbits.Mito_Pop1_Plus+M_File.Colocalization.Orbits.Mito_Pop1_Plus;
                Summary.Colocalization.Orbits.Mito_Pop1_Plus_All(i)=M_File.Colocalization.Orbits.Mito_Pop1_Plus;
                
                Summary.Colocalization.Orbits.Mito_Pop2_Plus=...
                    Summary.Colocalization.Orbits.Mito_Pop2_Plus+M_File.Colocalization.Orbits.Mito_Pop2_Plus;
                Summary.Colocalization.Orbits.Mito_Pop2_Plus_All(i)=M_File.Colocalization.Orbits.Mito_Pop2_Plus;
                
                Summary.Colocalization.Orbits.Mito_Pop1_Minus=...
                    Summary.Colocalization.Orbits.Mito_Pop1_Minus+M_File.Colocalization.Orbits.Mito_Pop1_Minus;
                Summary.Colocalization.Orbits.Mito_Pop1_Minus_All(i)=M_File.Colocalization.Orbits.Mito_Pop1_Minus;
                
                Summary.Colocalization.Orbits.Mito_Pop2_Minus=...
                    Summary.Colocalization.Orbits.Mito_Pop2_Minus+M_File.Colocalization.Orbits.Mito_Pop2_Minus;
                Summary.Colocalization.Orbits.Mito_Pop2_Minus_All(i)=M_File.Colocalization.Orbits.Mito_Pop2_Minus;
                
                Summary.Colocalization.Orbits.Mito_Passive=...
                    Summary.Colocalization.Orbits.Mito_Passive+M_File.Colocalization.Orbits.Mito_Passive;
                Summary.Colocalization.Orbits.Mito_Passive_All(i)=M_File.Colocalization.Orbits.Mito_Passive;
                
                %Summary Orbits Track
                Summary.Colocalization.Orbits.Track_Pop1_Plus=...
                    Summary.Colocalization.Orbits.Track_Pop1_Plus+M_File.Colocalization.Orbits.Track_Pop1_Plus;
                Summary.Colocalization.Orbits.Track_Pop1_Plus_All(i)=M_File.Colocalization.Orbits.Track_Pop1_Plus;
                
                Summary.Colocalization.Orbits.Track_Pop2_Plus=...
                    Summary.Colocalization.Orbits.Track_Pop2_Plus+M_File.Colocalization.Orbits.Track_Pop2_Plus;
                Summary.Colocalization.Orbits.Track_Pop2_Plus_All(i)=M_File.Colocalization.Orbits.Track_Pop2_Plus;
                
                Summary.Colocalization.Orbits.Track_Pop1_Minus=...
                    Summary.Colocalization.Orbits.Track_Pop1_Minus+M_File.Colocalization.Orbits.Track_Pop1_Minus;
                Summary.Colocalization.Orbits.Track_Pop1_Minus_All(i)=M_File.Colocalization.Orbits.Track_Pop1_Minus;
                
                Summary.Colocalization.Orbits.Track_Pop2_Minus=...
                    Summary.Colocalization.Orbits.Track_Pop2_Minus+M_File.Colocalization.Orbits.Track_Pop2_Minus;
                Summary.Colocalization.Orbits.Track_Pop2_Minus_All(i)=M_File.Colocalization.Orbits.Track_Pop2_Minus;
                
                Summary.Colocalization.Orbits.Track_Passive=...
                    Summary.Colocalization.Orbits.Track_Passive+M_File.Colocalization.Orbits.Track_Passive;
                Summary.Colocalization.Orbits.Track_Passive_All(i)=M_File.Colocalization.Orbits.Track_Passive;
                
                %Summary Phases Mito
                Summary.Colocalization.Phases.Mito_Pop1_Plus=...
                    Summary.Colocalization.Phases.Mito_Pop1_Plus+M_File.Colocalization.Phases.Mito_Pop1_Plus;
                Summary.Colocalization.Phases.Mito_Pop1_Plus_All(i)=M_File.Colocalization.Phases.Mito_Pop1_Plus;
                
                Summary.Colocalization.Phases.Mito_Pop2_Plus=...
                    Summary.Colocalization.Phases.Mito_Pop2_Plus+M_File.Colocalization.Phases.Mito_Pop2_Plus;
                Summary.Colocalization.Phases.Mito_Pop2_Plus_All(i)=M_File.Colocalization.Phases.Mito_Pop2_Plus;
                
                Summary.Colocalization.Phases.Mito_Pop1_Minus=...
                    Summary.Colocalization.Phases.Mito_Pop1_Minus+M_File.Colocalization.Phases.Mito_Pop1_Minus;
                Summary.Colocalization.Phases.Mito_Pop1_Minus_All(i)=M_File.Colocalization.Phases.Mito_Pop1_Minus;
                
                Summary.Colocalization.Phases.Mito_Pop2_Minus=...
                    Summary.Colocalization.Phases.Mito_Pop2_Minus+M_File.Colocalization.Phases.Mito_Pop2_Minus;
                Summary.Colocalization.Phases.Mito_Pop2_Minus_All(i)=M_File.Colocalization.Phases.Mito_Pop2_Minus;
                
                Summary.Colocalization.Phases.Mito_Passive=...
                    Summary.Colocalization.Phases.Mito_Passive+M_File.Colocalization.Phases.Mito_Passive;
                Summary.Colocalization.Phases.Mito_Passive_All(i)=M_File.Colocalization.Phases.Mito_Passive;
                
                %Summary Phases Track
                Summary.Colocalization.Phases.Track_Pop1_Plus=...
                    Summary.Colocalization.Phases.Track_Pop1_Plus+M_File.Colocalization.Phases.Track_Pop1_Plus;
                Summary.Colocalization.Phases.Track_Pop1_Plus_All(i)=M_File.Colocalization.Phases.Track_Pop1_Plus;
                
                Summary.Colocalization.Phases.Track_Pop2_Plus=...
                    Summary.Colocalization.Phases.Track_Pop2_Plus+M_File.Colocalization.Phases.Track_Pop2_Plus;
                Summary.Colocalization.Phases.Track_Pop2_Plus_All(i)=M_File.Colocalization.Phases.Track_Pop2_Plus;
                
                Summary.Colocalization.Phases.Track_Pop1_Minus=...
                    Summary.Colocalization.Phases.Track_Pop1_Minus+M_File.Colocalization.Phases.Track_Pop1_Minus;
                Summary.Colocalization.Phases.Track_Pop1_Minus_All(i)=M_File.Colocalization.Phases.Track_Pop1_Minus;
                
                Summary.Colocalization.Phases.Track_Pop2_Minus=...
                    Summary.Colocalization.Phases.Track_Pop2_Minus+M_File.Colocalization.Phases.Track_Pop2_Minus;
                Summary.Colocalization.Phases.Track_Pop2_Minus_All(i)=M_File.Colocalization.Phases.Track_Pop2_Minus;
                
                Summary.Colocalization.Phases.Track_Passive=...
                    Summary.Colocalization.Phases.Track_Passive+M_File.Colocalization.Phases.Track_Passive;
                Summary.Colocalization.Phases.Track_Passive_All(i)=M_File.Colocalization.Phases.Track_Passive;
                
                %Count Mitochondria
                Summary.Colocalization.Mito_Count(i)=0;
                for j=2:length(M_File.Video_Data.MitoPosCam)
                    if M_File.Video_Data.MitoPosCam(j)> M_File.Video_Data.MitoPosCam(j-1)
                        Summary.Colocalization.Mito_Count(i)=Summary.Colocalization.Mito_Count(i)+1;
                    end
                end
                
                if strcmp('Retrograde',Summary.Filelist{i,3}) == 1
                    Summary.Colocalization.Mito_Count(i)=Summary.Colocalization.Mito_Count(i)*-1;
                end
            end
        end
        
    end
end


Summary.Colocalization.Orbits.Mito_Pop1_Plus_All=Summary.Colocalization.Orbits.Mito_Pop1_Plus_All';
Summary.Colocalization.Orbits.Mito_Pop2_Plus_All=Summary.Colocalization.Orbits.Mito_Pop2_Plus_All';
Summary.Colocalization.Orbits.Mito_Pop1_Minus_All=Summary.Colocalization.Orbits.Mito_Pop1_Minus_All';
Summary.Colocalization.Orbits.Mito_Pop2_Minus_All=Summary.Colocalization.Orbits.Mito_Pop2_Minus_All';
Summary.Colocalization.Orbits.Mito_Passive_All=Summary.Colocalization.Orbits.Mito_Passive_All';

Summary.Colocalization.Orbits.Track_Pop1_Plus_All=Summary.Colocalization.Orbits.Track_Pop1_Plus_All';
Summary.Colocalization.Orbits.Track_Pop2_Plus_All=Summary.Colocalization.Orbits.Track_Pop2_Plus_All';
Summary.Colocalization.Orbits.Track_Pop1_Minus_All=Summary.Colocalization.Orbits.Track_Pop1_Minus_All';
Summary.Colocalization.Orbits.Track_Pop2_Minus_All=Summary.Colocalization.Orbits.Track_Pop2_Minus_All';
Summary.Colocalization.Orbits.Track_Passive_All=Summary.Colocalization.Orbits.Track_Passive_All';

Summary.Colocalization.Phases.Mito_Pop1_Plus_All=Summary.Colocalization.Phases.Mito_Pop1_Plus_All';
Summary.Colocalization.Phases.Mito_Pop2_Plus_All=Summary.Colocalization.Phases.Mito_Pop2_Plus_All';
Summary.Colocalization.Phases.Mito_Pop1_Minus_All=Summary.Colocalization.Phases.Mito_Pop1_Minus_All';
Summary.Colocalization.Phases.Mito_Pop2_Minus_All=Summary.Colocalization.Phases.Mito_Pop2_Minus_All';
Summary.Colocalization.Phases.Mito_Passive_All=Summary.Colocalization.Phases.Mito_Passive_All';

Summary.Colocalization.Phases.Track_Pop1_Plus_All=Summary.Colocalization.Phases.Track_Pop1_Plus_All';
Summary.Colocalization.Phases.Track_Pop2_Plus_All=Summary.Colocalization.Phases.Track_Pop2_Plus_All';
Summary.Colocalization.Phases.Track_Pop1_Minus_All=Summary.Colocalization.Phases.Track_Pop1_Minus_All';
Summary.Colocalization.Phases.Track_Pop2_Minus_All=Summary.Colocalization.Phases.Track_Pop2_Minus_All';
Summary.Colocalization.Phases.Track_Passive_All=Summary.Colocalization.Phases.Track_Passive_All';



clearvars -global M_File


%Remove artifacts in Y stepsize
Summary.Pop1_Plus.Y_Stepsize(Summary.Pop1_Plus.Y_Stepsize>0.1)=[];
Summary.Pop1_Plus.Y_Stepsize(Summary.Pop1_Plus.Y_Stepsize<-0.1)=[];

Summary.Pop2_Plus.Y_Stepsize(Summary.Pop2_Plus.Y_Stepsize>0.1)=[];
Summary.Pop2_Plus.Y_Stepsize(Summary.Pop2_Plus.Y_Stepsize<-0.1)=[];

Summary.Pop1_Minus.Y_Stepsize(Summary.Pop1_Minus.Y_Stepsize>0.1)=[];
Summary.Pop1_Minus.Y_Stepsize(Summary.Pop1_Minus.Y_Stepsize<-0.1)=[];

Summary.Pop2_Minus.Y_Stepsize(Summary.Pop2_Minus.Y_Stepsize>0.1)=[];
Summary.Pop2_Minus.Y_Stepsize(Summary.Pop2_Minus.Y_Stepsize<-0.1)=[];

Summary.Passive.Y_Stepsize(Summary.Passive.Y_Stepsize>0.1)=[];
Summary.Passive.Y_Stepsize(Summary.Passive.Y_Stepsize<-0.1)=[];


%%Update Tab 4
Update_Tab4;

