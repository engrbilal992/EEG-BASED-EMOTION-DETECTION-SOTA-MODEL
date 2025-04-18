clear all
close all
clc

T=importdata('TSC_En.xlsx');
C=T(:,2:end-1);


F0=[C(1:732,:)]; % Minority Class
F1=[C(733:end,:)]; % Majority Class

numEx0=size(F0,1); %Minority Class
numEx1=size(F1,1); %Majority Class

labels0 = false([numEx0 1]);
labels1 = true ([numEx1 1]);

adasyn_features = [F0; F1];
adasyn_labels = [labels0  ; labels1];
adasyn_beta = [];   % let ADASYN choose default
adasyn_kDensity = [];   % let ADASYN choose default
adasyn_kSMOTE = [];   % let ADASYN choose default
adasyn_featuresAreNormalized = false;    % false lets ADASYN handle normalization

[out_featuresSyn, out_labelsSyn] = ADASYN(adasyn_features, adasyn_labels, adasyn_beta, adasyn_kDensity, adasyn_kSMOTE, adasyn_featuresAreNormalized);
