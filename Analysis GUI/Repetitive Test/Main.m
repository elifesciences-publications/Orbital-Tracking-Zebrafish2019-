clear all
close all

%% Select Folder
Folder_Name=uigetdir('','Select Folder for Summary');
File_List=dir(Folder_Name);

%% Select Files to laod
j=1;
for i=1:length(File_List)
    Temp=File_List(i);
    if Temp.isdir == 0
        [~,~,ext] = fileparts(Temp.name);
        if strcmp('.mat',ext) == 1
            Data{j,1}=fullfile(Folder_Name,Temp.name);
            Data{j,2}=true;
            j=j+1;
        end
    end
end


%% Create Matrix with n=#of tracks lines and 3500 columns (10nm bins for 35µm)
%2 indicates no entry
%0 indicates pause
%1 indicates movement
Pause_Matrix=ones(size(Data,1)+1,800)*2;
Rnd_Pause_Matrix=ones(size(Data,1)+1,800)*2;



% Load Single Files and Create Array
for j=1:size(Data,1)
    load(Data{j,1});
    Length=M_File.Trajectory.Trajectory(end,2)-M_File.Trajectory.Trajectory(1,2);
    
    if Length > 0
        Bin_Min=round(min(M_File.Trajectory.Trajectory(:,2))*100/5)+400;
        Bin_Max=round(max(M_File.Trajectory.Trajectory(:,2))*100/5)+400;
        Pause_Matrix(j,Bin_Min:Bin_Max)=ones(Bin_Max-Bin_Min+1,1);
        %Fill Bin Array
        for i=1:length(M_File.Trajectory.Trajectory(:,2))
            Temp=round(M_File.Trajectory.Trajectory(i,2)*100/5)+400;
            
            %Fill Pause Matrix
            if Pause_Matrix(j,Temp)~= 0
                if M_File.Dynamics.Population_Status(i) == 0 | M_File.Dynamics.Population_Status(i) == 10
                    Pause_Matrix(j,Temp)=0;
                else
                    Pause_Matrix(j,Temp)=1;
                end
            end
        end
        % Permutate Startpoint Pauses
        %Detect Start + Endpoint of pauses in bins
        k=1;
        Bins_Startpoint=[];
        Bins_Endpoint=[];
        for i=2:length(Rnd_Pause_Matrix(j,:))-1
            if Pause_Matrix(j,i-1) > 0 && Pause_Matrix(j,i) == 0
                Bins_Startpoint(k)=i;
            elseif Pause_Matrix(j,i-1) == 0 && Pause_Matrix(j,i) > 0
                Bins_Endpoint(k)=i;
                k=k+1;
            end
        end
        
        Bin_Min=round(min(M_File.Trajectory.Trajectory(:,2))*100/5)+400;
        Bin_Max=round(max(M_File.Trajectory.Trajectory(:,2))*100/5)+400;
        Rnd_Pause_Matrix(j,Bin_Min:Bin_Max)=ones(Bin_Max-Bin_Min+1,1);
        
        Length_Bins=Bins_Endpoint-Bins_Startpoint;
        Length_Bins=sort(Length_Bins,'descend');
        %Permutate Startpoints
        for i=1:length(Length_Bins)
            l=0;
            t=1;
            while l==0;
                Startpoint=round(rand(1,1)*(Bin_Max-Bin_Min)+Bin_Min);
                if Startpoint+Length_Bins(i)< Bin_Max
                    if mean(Rnd_Pause_Matrix(j,Startpoint:Startpoint+Length_Bins(i))==1) == 1
                        Rnd_Pause_Matrix(j,Startpoint:Startpoint+Length_Bins(i)-1)=zeros(Length_Bins(i),1);
                        l=1;
                    end
                end
            end
        end
    end
    Test(j,1)=sum(Rnd_Pause_Matrix(j,:)==0);
    Test(j,2)=sum(Pause_Matrix(j,:)==0);
end


% Create Pause Map with at least 4 trajectories per point
Pause_Prop=ones(1,800)*2;
for i=1:length(Pause_Matrix(1,:))
    Temp=Pause_Matrix(:,i);
    if sum(Temp==2) < length(Pause_Matrix(:,2))-3
        Tracks=length(Pause_Matrix(:,2))-sum(Temp==2);
        Pauses=sum(Temp==0);
        Pause_Prop(i)=Pauses/Tracks;
        if Pause_Prop(i)  == 1/Tracks
            Pause_Prop(i)=Pause_Prop(i)-1/Tracks;
        end
    end
end

% Create Pause Map with at least 4 trajectories per point
Rnd_Pause_Prop=ones(1,800)*2;
for i=1:length(Rnd_Pause_Matrix(1,:))
    Temp=Rnd_Pause_Matrix(:,i);
    if sum(Temp==2) < length(Rnd_Pause_Matrix(:,2))-3
        Tracks=length(Rnd_Pause_Matrix(:,2))-sum(Temp==2);
        Pauses=sum(Temp==0);
        Rnd_Pause_Prop(i)=Pauses/Tracks;
        if Rnd_Pause_Prop(i) == 1/Tracks
            Rnd_Pause_Prop(i)=Rnd_Pause_Prop(i)-1/Tracks;
        end
    end
end

x=-20:0.05:19.950;
y=1:1:length(Rnd_Pause_Matrix(:,1));
Rnd_Pause_Prop(Rnd_Pause_Prop>1)=-1;
figure(1)
h(1)=subplot(2,1,1);
set(gca,'FontSize',16);
bar(x,(Rnd_Pause_Prop))
xlabel('Y [µm]');
ylabel('%')
ylim([0 1])
xlim([-20 20])
title('tresh')
%set(h(1), 'position', [0.05, 0.05, 0.9, 0.4] );
h(2)=subplot(2,1,2);
mesh(x,y,Rnd_Pause_Matrix)
xlabel('Y [µm]');
view([0 90])
%set(h(2), 'position', [0.05, 0.55, 0.9, 0.4] );
% x=1:1:800;
% plot(smooth(Pause_Prop,5))
% ylim([0 1])
% xlim([0 800])
% set(h(2), 'position', [0.05, 0.625, 0.9, 0.35] );

Pause_Prop(Pause_Prop>1)=-1;
figure(2)
o(1)=subplot(2,1,1);

bar(x,(Pause_Prop))
xlabel('Y [µm]');
ylabel('%')
ylim([0 1])
xlim([-20 20])
title('data')
% set(o(1), 'position', [0.05, 0.05, 0.9, 0.4] );
o(2)=subplot(2,1,2);
mesh(x,y,Pause_Matrix)
xlabel('Y [µm]');
view([0 90])
set(gca,'FontSize',16);
% set(o(2), 'position', [0.05, 0.55, 0.9, 0.4] );
% x=1:1:800;
% plot(smooth(Pause_Prop,5))

% set(h(2), 'position', [0.05, 0.625, 0.9, 0.35] );





% %% FFT
% Test=smooth(Pause_Prop,5);
% Test(Test>0.8)=[];
% Fs=20;
% L=length(Test);
% NFFT = 2^nextpow2(L); % Next power of 2 from length of y
% Y = fft(Test-mean(Test),NFFT)/L;
% f = Fs/2*linspace(0,1,NFFT/2+1);
%
% % Plot single-sided amplitude spectrum.
% figure(3)
% plot(f,2*abs(Y(1:NFFT/2+1)))
% title('Single-Sided Amplitude Spectrum of y(t)')
% xlabel('Frequency (µm^-1)')
% ylabel('|Y(f)|')


%% Calculate 5 of bins with pauses
for i=1:length(Pause_Matrix(:,1))
    Length(i)=(sum(Pause_Matrix(i,:)==0)+sum(Pause_Matrix(i,:)==1));
    Pause(i)=sum(Pause_Matrix(i,:)==0);
    
    
    
end
Pause(isnan(Pause)==1)=[];
Length(isnan(Length)==1)=[];
Pause_Fraction_Total=sum(Pause)/sum(Length);
Pause_Fraction=Pause./Length;
Pause_Fraction(isnan(Pause_Fraction)==1)=[];
figure(3)
bar(Pause_Fraction)