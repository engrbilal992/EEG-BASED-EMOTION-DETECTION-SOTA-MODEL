clc
clear
close all

load('DREAMER.mat');
% Access the data field of the structure and store it in a variable called "data"
data = DREAMER.Data; 
for k=1:23
% For ith person extract 1st struct from 1x23 cell array
x=data(k);
% Now i am extracting 1x1 struct from Cell array
x=x{1,1};
% Extracting EEG from 1x1 Struct
x1=x.EEG;
% Extracting baseline from EEG(dataofpers1) structure
x=x1.stimuli;
fs=128;

for i = 1:18
        xa=x(i);
        xa=xa{1,1};
        chseg=[];
    for ch = 1:14
        % Extract data for this channel
         cx=xa(:,ch);
         % Define segment length and initialize segment counter
         L = 30 * fs;
         segment_counter = 1;
        for seg = 1 :(length(cx)/L)
            segment = cx((seg-1)*L+1 : seg*L);
            chseg=[chseg segment];
        end
           % Save the combined channel segment as one .mat file
           filename = sprintf('Person_%d_video_%d.mat',k,i);
           save(filename, 'chseg');
    end
end
end