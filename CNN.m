close all; clear; clc
%% Specify the dataset directory
currentFolder = pwd;
imds = imageDatastore(fullfile(currentFolder, 'new_training'), ...
    'IncludeSubfolders',true,'LabelSource','foldernames');
%% Getting number of labels
labelCount = countEachLabel(imds);
%% Getting Image Size from first image in 'imds'
img = readimage(imds,1);
imageSize = size(img);
%% Specify the number of files used for training
filesToTrain = 600;
[imdsTrain,imdsValidation] = splitEachLabel(imds,filesToTrain,'randomize');

%imdsTrain=augmentedImageDatastore(imageSize, imdsTrain);

%% Declare the CNN network 
layers = [
    imageInputLayer(size(img))
    
    convolution2dLayer(64,8,'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(32,'Stride',8)
    
    convolution2dLayer(32,16,'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(16,'Stride',16)
    
    convolution2dLayer(16,32,'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    fullyConnectedLayer(2)
    softmaxLayer
    classificationLayer];
%% Specify Training Options for the model
options = trainingOptions('sgdm', ...
    'InitialLearnRate',0.01, ...
    'MaxEpochs',10, ...
    'Shuffle','every-epoch', ...
    'ValidationData',imdsValidation, ...
    'ValidationFrequency',30, ...
    'Verbose',false, ...
    'Plots','training-progress', ...
    'MiniBatchSize',2, ...
    'ExecutionEnvironment','gpu');
%% Train The CNN Network
net = trainNetwork(imdsTrain,layers,options);
%% Checking Network Performance
YPred = classify(net,imdsValidation);
YValidation = imdsValidation.Labels;
accuracy = sum(YPred == YValidation)/numel(YValidation);
plotconfusion(YPred,YValidation)

% TP = 0; TN = 0; FP = 0; FN = 0;
% for i=1:size(YPred)
%     if (YValidation(i)=="empty")&&(YPred(i)=="empty")
%         TP = TP+1;
%     end
%     if (YValidation(i)=="human")&&(YPred(i)=="human")
%         TN = TN+1;
%     end
%     if (YValidation(i)=="human")&&(YPred(i)=="empty")
%         FP = FP+1;
%     end
%     if (YValidation(i)=="empty")&&(YPred(i)=="human")
%         FN = FN+1;
%     end
% end
% PPV = TP/(FP+TP);
% FDR = FP/(FP+TP);
% NPV = TN/(TN+FN);
% FOR = FN/(TN+FN);
% TPR = TP/(TP+FN);
% TNR = TN/(TN+FP);
% F1 = 2*TP/(2*TP+FP+FN);
% 
% FPR = FP/(FP+TN);
% %ROC plot
% FPRm = [0 FPR 1];
% TPRm = [0 TPR 1];
% figure
% plot(FPRm, TPRm)
% grid
% axis([0 1 0 1]) 
%% Calculate TP TN FP FN FDR NPV TPR TNR F1 ROC
% TP: True Positive Object is A and predicted as A
% TN: True Negative Object is B and predicted as B
% FP: False Positive Object is B but predicted as A
% FN: False Negative Object is A but predicted as B
% FDR: False Discovery Rate = FP/(FP+TP)
% NPV: Negative Predictive Value = TN/(TN+FN)
% TPR: True Positive Rate(Sensitivity, Recall, Hit rate) = TP/(TP+FN) 
% TNR: True Negative Rate (Specificity, Selectivity) = TN/(TN+FP);
% F1 score: harmonic mean of precision and sensitivity = 2TP/(2TP+FP+FN)
% ROC curve 
%% Save the Network for future validation
CNNnet = net;
save CNNnet;