clear;

load('cleandata_students.mat');
%load('noisydata_students.mat');

originalX = x;
originalY = y;
trainingSize = 9;
n = length(y);

res = zeros(100,3);


neurons_per_layers = 20;
layers = 2;
traingdRes = zeros(100,2);
traingdaRes = zeros(100,4);
traingdmRes = zeros(100,3);
trainrpRes = zeros(100,4);
l = ones(1,layers) * neurons_per_layers;

%traingd
%indexerTrainGd = 1;
%for lr = 0.4:0.1:0.7    
%        traingdRes(indexerTrainGd, :) = testTrainParam(trainingSize, x, y, l, 'traingd', lr);
%        indexerTrainGd = indexerTrainGd + 1;
%end


%traingda
% indexerTrainGda = 1;
% for lr = 0.01:0.01:0.1   
%     for lr_inc = 1.01:0.05:1.5
%         for lr_dec = 0.1:0.1:0.9
%             traingdaRes(indexerTrainGda, :) = testTrainParam(trainingSize, x, y, l, 'traingda', lr, lr_inc, lr_dec);
%             indexerTrainGda = indexerTrainGda + 1;
%         end
%     end
% end


%traingdm
% indexerTrainGdm = 1;
% for lr = 0.01:0.01:0.1 
%     for mc = 0: 0.1: 1
%         traingdmRes(indexerTrainGdm, :) = testTrainParam(trainingSize, x, y, l, 'traingdm', lr, mc);
%         indexerTrainGdm = indexerTrainGdm + 1;
%     end
% end

%trainrp
indexerTrainRp = 1;
for lr = 0.01:0.01:0.1 
    for delt_inc = 1.1:0.1:1.9
        for delt_dec = 0.1:0.1:0.9
            trainrpRes(indexerTrainRp, :) = testTrainParam(trainingSize, x, y, l, 'trainrp', lr, delt_inc, delt_dec);
            indexerTrainRp = indexerTrainRp + 1;
        end
    end
end


        
