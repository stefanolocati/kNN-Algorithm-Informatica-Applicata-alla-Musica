function val = extractZcr(filename)
[y,fs]=audioread(filename);
windowLength = fs*0.02;
Ham = window(@hamming, windowLength); % smooths the data in the window
[M,nf] = windowize(y,windowLength,windowLength); 
val=zeros(1,nf);

for j=1:nf % for each frame compute ZCR
        val(j) = feature_zcr(M(:,j));
end