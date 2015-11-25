clear;

load('cleandata_students.mat');
%load('noisydata_students.mat');

originalX = x;
originalY = y;
trainingSize = 9;
n = length(y);

%confusionMatrix = zeros(6);
res = zeros(100,3);
indexer = 1;

for layers = 1:10
    for neurons_per_layers = (1:10)*10
        
        l = ones(1,layers) * neurons_per_layers;
        errSum = 0;
        
        for k = 1:trainingSize
            starting = floor(k * n / (trainingSize + 1));
            ending = floor((k+1) * n / (trainingSize + 1));
            testSet = x(starting:ending,:);
            testRes = y(starting:ending);
            x(starting:ending,:) = [];
            y(starting:ending,:) = [];
            predictedSize = length(testRes);
            %predictedSet=[predictedSize:1];

            [a, b] = ANNdata(x, y);
            [testA, testB] = ANNdata(testSet, testRes);

            N = createNetwork(a, b, l);
            nbError = 0;

            for i = 1 : (1 + ending - starting)
                predicted = predict(N, testA(:, i));

                %predictedSet(i,1) = predicted;
                if (predicted ~= testRes(i))
                   nbError = nbError + 1;
                end
            end

            %confusionMatrix = confusionMatrix + buildConfusionMatrix(testRes,predictedSet,6);

            avg = nbError/(1 + ending - starting);

            errSum = errSum + avg;

            x = originalX;
            y = originalY;
        end

        %confusionMatrix = confusionMatrix / trainingSize;
        %meanRecall = computeMeanRecall(confusionMatrix);
        %meanPrecision = computeMeanPrecision(confusionMatrix);
        %meanF1 = CalcF(meanPrecision,meanRecall);
        %meanClass = computeMeanClassificationRate(confusionMatrix);

        %for i = 1: size(confusionMatrix,1)
        %    TP = confusionMatrix(i,i);
        %    FN = sum(confusionMatrix(i,:)) - TP;
        %    FP = sum(confusionMatrix(:,i)) - TP;
        %    TN = sum(confusionMatrix(:)) - (TP+ FP +FN);
        %    classRecalls(i,1) = calculateRecall(TP, FN);
        %    classPrecisions(i,1) = calculatePrecision(TP, FP);
        %    classF1s(i,1) = CalcF(classPrecisions(i,1),classRecalls(i,1));
        %    classRates(i,1) = calculateClassificationRate(TP, TN, sum(confusionMatrix(:)));
        %end
        
        layers
        neurons_per_layers
        res(indexer, 1) = layers;
        res(indexer, 2) = neurons_per_layers;
        res(indexer, 3) = 100*errSum/trainingSize;
        indexer = indexer + 1;
    end
end
