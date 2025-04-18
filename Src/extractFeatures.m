function chFeat=extractFeatures(sig,fs)
chFeat=[];
for ch=1:14
    V=sig(:,ch);
    [Pxx,F] = periodogram(V,hamming(length(V)),length(V),fs,'psd');
    pTot = bandpower(Pxx,F,'psd');
    t_activity = var(V);  
    t_mobility = std(diff(V))./std(V);
    t_complexity = std(diff(diff(V)))./std(diff(V))./t_mobility;
    SE=wentropy(V,"shannon");
    LE=wentropy(V,"log energy");
    tHJ=[t_activity t_mobility t_complexity pTot SE LE];
    chFeat=[chFeat tHJ];
end
end