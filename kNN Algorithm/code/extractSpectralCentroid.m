
function [C,S] = extractSpectralCentroid(filename)
[y,fs]=audioread(filename);
windowLength = fs*0.02;
Ham = window(@hamming, windowLength); % smooths the data in the window
[M,nf] = windowize(y,windowLength,floor(windowLength/2)); % 50% overlap between subsequent frames
% initialization of the feature vectors
C =zeros(1,nf);
S =zeros(1,nf);
for i=1:nf
    frame = M(:,i);
    frame  = frame .* Ham;
    frameFFT = getDFT(frame, fs);
    [C(i),S(i)] = feature_spectral_centroid(frameFFT, fs);
end