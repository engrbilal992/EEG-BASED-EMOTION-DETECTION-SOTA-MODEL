clc
clear
close all

path = 'Final_av'; % Path for Data

subFF = [];

fs=128;

dirListing = dir(fullfile(path, '*.mat')); % List of files in the folder

        for i = 1:length(dirListing) % Loop through the files in the folder
    
            fileName = fullfile(path,dirListing(i).name); % Extracting the full file name of the ith EEG file
            x = importdata(fileName);

%   Extracting videos now
            vidFF = [];

        for vid = 1:18

%   Now extracting every segment from video
            video = x.concatenated_data; 
%   Now extracting segments
            segFF = [];
            video=video(vid).concatenated_data;

        for seg = 1:length(video)
            chEEG = [];
            chFF = []; 
            segmentdata = video(seg).x1;

%   Extracting channels now

         for ch = 1:14

            chEEG = segmentdata(:,ch);
            d=chEEG;

            EEGFilter = filter(bandstopeeg,d); %Band Stop Filter

%    Bandpass Filter

            Delta=filter(Deltawave,EEGFilter); %DeltaWave(1-4hz)
            Theta=filter(thetawave,EEGFilter); %ThetaWave(4-8hz)
            Alpha=filter(alphawave,EEGFilter); %AlphaWave(8-12hz)
            Beta=filter(betawave,EEGFilter); %BetaWave(12-30hz)

%    Highpass Filter

            Gama=filter(gamawave,EEGFilter); %GamaWave(30hz)

%    Feature Extraction

% % For Deltawave
%    Power Spectral Density
            % PSD1 = pwelch(Delta, 30*fs, 0, [], fs);
            % PSD1 = mean(PSD1, 2);
            % PSD1= rms(PSD1);
%    Mean Freq
            % Mf1=(meanfreq(Delta,fs));
% %    Log Energy
%             LE1=sum(log(Delta.^2+eps));
%    Hjorth Features

            A1 = var(Delta);                      % Activity or signal energy
            M1 = std(diff(Delta)) / std(Delta);  % Mobility
            C1 = std(diff(diff(Delta))) / std(diff(Delta)) / M1;  % Complexity
            LE1=wentropy(Delta,"log energy");
            SE1=wentropy(Delta,"shannon");
            P1=bandpower(Delta,fs,[0, fs/2] );

%Thetawave
%    Power Spectral Density
%             PSD2 = pwelch(Theta, 30*fs, 0, [], fs);
%             PSD2 = mean(PSD2, 2);
%             PSD2= rms(PSD2);
% %    Mean Freq
%             Mf2=(meanfreq(Theta,fs));
% % %    Log Energy
% %             LE2=sum(log(Theta.^2+eps));
%    Hjorth Features
            
            A2 = var(Theta);                      % Activity or signal energy
            M2 = std(diff(Theta)) / std(Theta);  % Mobility
            C2 = std(diff(diff(Theta))) / std(diff(Theta)) / M2;  % Complexity
            LE2=wentropy(Theta,'log energy');
            SE2=wentropy(Theta,'shannon');
            P2=bandpower(Theta,fs,[0, fs/2]);

%   Alphawave
%    Power Spectral Density
%             PSD3 = pwelch(Alpha, 30*fs, 0, [], fs);
%             PSD3 = mean(PSD3, 2);
%             PSD3= rms(PSD3);
% %    Mean Freq
%             Mf3=(meanfreq(Alpha,fs));
% %    Log Energy
%             LE3=sum(log(Alpha.^2+eps));
%    Hjorth Features
            
            A3 = var(Alpha);                      % Activity or signal energy
            M3 = std(diff(Alpha)) / std(Alpha);  % Mobility
            C3 = std(diff(diff(Alpha))) / std(diff(Alpha)) / M3;  % Complexity
            LE3=wentropy(Alpha,'log energy');
            SE3=wentropy(Alpha,'shannon');
            P3=bandpower(Alpha,fs,[0, fs/2]);

% %Beta
%    Power Spectral Density
%             PSD4 = pwelch(Beta, 30*fs, 0, [], fs);
%             PSD4 = mean(PSD4, 2);
%             PSD4= rms(PSD4);
% %    Mean Freq
%             Mf4=(meanfreq(Beta,fs));
% %    Log Energy
%             LE4=sum(log(Beta.^2+eps));
%    Hjorth Features

            A4 = var(Beta);                      % Activity or signal energy
            M4 = std(diff(Beta)) / std(Beta);  % Mobility
            C4 = std(diff(diff(Beta))) / std(diff(Beta)) / M4;  % Complexity
            LE4=wentropy(Beta,'log energy');
            SE4=wentropy(Beta,'shannon');
            P4=bandpower(Beta,fs,[0, fs/2]);

% % Gamma
%    Power Spectral Density
%             PSD5 = pwelch(Gama, 30*fs, 0, [], fs);
%             PSD5 = mean(PSD5, 2);
%             PSD5= rms(PSD5);
% %    Mean Freq
%             Mf5=(meanfreq(Gama,fs));
% %    Log Energy
%             LE5=sum(log(Gama.^2+eps));
%    Hjorth Features

            A5 = var(Gama);                      % Activity or signal energy
            M5 = std(diff(Gama)) / std(Gama);  % Mobility
            C5 = std(diff(diff(Gama))) / std(diff(Gama)) / M5;  % Complexity
            LE5=wentropy(Gama,'log energy');
            SE5=wentropy(Gama,'shannon');
            P5=bandpower(Gama,fs,[0, fs/2]);
            
% FF=[PSD1 Mf1 LE1 A1 M1 C1 PSD2 Mf2 LE2 A2 M2 C2 PSD3 Mf3 LE3 A3 M3 C3 PSD4 Mf4 LE4 A4 M4 C4 PSD5 Mf5 LE5 A5 M5 C5];
FF=[PSD1 PSD2 PSD3 PSD4 PSD5 Mf1 Mf2 Mf3 Mf4 Mf5 A1 A2 A3 A4 A5 M1 M2 M3 M4 M5 C1 C2 C3 C4 C5 LE1 LE2 LE3 LE4 LE5 SE1 SE2 SE3 SE4 SE5 P1 P2 P3 P4 P5];
chFF=[chFF FF];
        end
            segFF =[segFF;chFF];
        end
            vidFF = [vidFF;segFF];
        end
            subFF= [subFF;vidFF];
        end

% load('label_seg.mat');
% Label = data_seg;

FeatureMatrixFiltered = [subFF Label];
