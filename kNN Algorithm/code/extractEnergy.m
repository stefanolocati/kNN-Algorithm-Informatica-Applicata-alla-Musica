function val = extractEnergy(filename)
[y,fs]=audioread(filename);
[M,nf]=windowize(y, fs*0.02, fs*0.02);
val=zeros(1,nf);
for j=1:nf % for each frame compute ZCR and Energy
    val(j) = feature_energy(M(:,j));
end