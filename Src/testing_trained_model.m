clc
clear
close all

% Load the file into the workspace
load('DREAMER.mat');
fs=128;
% Access the data field of the structure and store it in a variable called "data"
data = DREAMER.Data;
Person= data(1);
% Now I am extracting 1x1 struct from Cell array
P = Person{1,1};
% Extracting EEG from 1x1 Struct
EEG = P.EEG;
% Extracting stimuli from EEG (dataofpers1) structure
EEGs= EEG.stimuli;
EEGs=EEGs{18,1};

% EEGss=EEGs{1,1};

d=EEGs;

% Pre processing

d=d(1:3840,:); % Collected 30 sec segment

EEGFilter = filter(bandstopeeg,d); %Band Stop Filter
% Bandpass Filter
Delta=filter(Deltawave,EEGFilter); %DeltaWave(1-4hz)
Theta=filter(thetawave,EEGFilter); %ThetaWave(4-8hz)
Alpha=filter(alphawave,EEGFilter); %AlphaWave(8-12hz)
Beta=filter(betawave,EEGFilter); %BetaWave(12-30hz)

% Highpass Filter
Gama=filter(gamawave,EEGFilter); %GamaWave(30hz)

% Features bhi dalne hain

             chFeat=extractFeatures(Delta,fs);
             chFeat1=extractFeatures(Theta,fs);
             chFeat2=extractFeatures(Alpha,fs);
             chFeat3=extractFeatures(Beta,fs);
             chFeat4=extractFeatures(Gama,fs);
             feat0=[chFeat chFeat1 chFeat2 chFeat3 chFeat4];

TC=importdata('trainedclassifier.mat');
y=TC.predictFcn(feat0);

if y==1 %HAHV
    disp('Joy');
elseif y==2 % HALV
    disp('Angry');
elseif y==3 %LALV
    disp ('Sadness')
else %LAHV
    disp('Pleasure')
end