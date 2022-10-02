clear all
clc
train1 = []
labels1 = []
train2 = []
labels2 = []
train3 = []
labels3 = []
test1 = []
test2 = []
test3 = []
correctlabel1 =[]
correctlabel2 = []
correctlabel3 = []
addpath(genpath(pwd))
for i=1:3
    file = (['Pop',mat2str(i)])
    file2 = (['Blues', mat2str(i)])
    file3 = (['Rock', mat2str(i)])
    
valPop = extractSpectralCentroid([file,'.wav']);
trainPop = valPop(:,1:floor(length(valPop/2)));
labelPop = repmat(1,1,length(trainPop));

valBlues = extractSpectralCentroid([file2,'.wav']);
trainBlues = valBlues(:,1:floor(length(valBlues/2)));
labelBlues = repmat(2,1,length(trainBlues));

valRock = extractSpectralCentroid([file3,'.wav']);
trainRock = valRock(:,1:floor(length(valRock/2)));
labelRock = repmat(3,1,length(trainRock));

train1 = [train1 trainPop]
train2 = [train2 trainBlues]
train3 = [train3 trainRock]
labels1 = [labels1 labelPop]
labels2 = [labels2 labelBlues]
labels3 = [labels3 labelRock]
all_train = [train1 train2 train3];
all_labels = [labels1 labels2 labels3]; 
end


for i=4:6
    file = (['Pop',mat2str(i)])
    file2 = (['Blues', mat2str(i)])
    file3 = (['Rock', mat2str(i)])
    
valPop = extractSpectralCentroid([file,'.wav']);
testPop = valPop(:,1:floor(length(valPop/2)));
testlabelPop = repmat(1,1,length(testPop));    
    
valBlues = extractSpectralCentroid([file2,'.wav']);
testBlues =  valBlues(:,1:floor(length(valBlues/2)));
testlabelBlues = repmat(2,1,length(testBlues));

valRock = extractSpectralCentroid([file3,'.wav']);
testRock = valRock(:,1:floor(length(valRock/2)));
testlabelRock = repmat(3,1,length(testRock));

test1 = [test1 testPop]
test2 = [test2 testBlues]
test3 = [test3 testRock]
all_test = [test1 test2 test3];
correctlabel1 = [correctlabel1 testlabelPop]
correctlabel2 = [correctlabel2 testlabelBlues]
correctlabel3 = [correctlabel3 testlabelRock]
correct_label = [correctlabel1 correctlabel2 correctlabel3];
end

k=[1 5 10 15 20];
rate = [];
for kk=1:length(k)
    disp(['set-up the kNN... number of neighbors: ',mat2str(k(kk))])
    Mdl = fitcknn(all_train',all_labels','NumNeighbors',k(kk));
    
    % test the kNN
    predicted_label = predict(Mdl,all_test');
    
    % measure the performance
    correct = 0;
    for i=1:length(predicted_label)
        if predicted_label(i)==correct_label(i)
            correct=correct+1;            
        end
    end
    disp('recognition rate:')
    rate(kk) = (correct/length(predicted_label))*100
end
[a,b]=max(rate);
disp('----------results----------------')
disp(['the maximum recognition rate is ',mat2str(a)])
disp(['and it is achieved with ',mat2str(k(b)),' nearest neighbors'])
