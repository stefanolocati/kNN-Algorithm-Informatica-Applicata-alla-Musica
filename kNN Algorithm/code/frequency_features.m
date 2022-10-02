function [C,S,R,ceps]=frequency_features(filename)
% example for the extraction of spectral_centroid, spread, rolloff and MFCCs
[y,fs]=audioread(filename);
windowLength = fs*0.02;
Ham = window(@hamming, windowLength); % smooths the data in the window
[M,nf]=windowize(y,windowLength,windowLength/2); % 50% overlap between subsequent frames
mfccParams = feature_mfccs_init(windowLength, fs); % initialization of MFCCs
% initialization of the feature vectors
C=zeros(1,nf);
S=zeros(1,nf);
R=zeros(1,nf);
ceps=zeros(13,nf);
for i=1:nf
    frame = M(:,i);
    frame  = frame .* Ham;
    frameFFT = getDFT(frame, fs);
    [C(i),S(i)] = feature_spectral_centroid(frameFFT, fs);
    R(i) = feature_spectral_rolloff(frameFFT, 0.9);
    ceps(1:13,i) = feature_mfccs(frameFFT, mfccParams);
end