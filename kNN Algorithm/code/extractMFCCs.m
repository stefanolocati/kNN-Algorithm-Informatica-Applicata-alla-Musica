function ceps = extractMFCCs(filename)
[y,fs]=audioread(filename);
windowLength = fs*0.02;
Ham = window(@hamming, windowLength); % smooths the data in the window
[M,nf] = windowize(y,windowLength,floor(windowLength/2)); % 50% overlap between subsequent frames
mfccParams = feature_mfccs_init(windowLength, fs); % initialization of MFCCs
ceps=zeros(13,nf);
for i=1:nf
    frame = M(:,i);
    frame  = frame .* Ham;
    frameFFT = getDFT(frame, fs);
    ceps(1:13,i) = feature_mfccs(frameFFT, mfccParams);
end