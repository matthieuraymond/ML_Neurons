clear;

load('cleandata_students.mat');
%load('noisydata_students.mat');

originalX = x;
originalY = y;
trainingSize = 9;
n = length(y);

confusionMatrix = zeros(6);
res = zeros(100,3);
indexer = 1;

errSum = 0;

for k = 1:trainingSize
    starting = floor(k * n / (trainingSize + 1));
    ending = floor((k+1) * n / (trainingSize + 1));
    testSet = x(starting:ending,:);
    testRes = y(starting:ending);
    x(starting:ending,:) = [];
    y(starting:ending,:) = [];
    predictedSize = length(testRes);
    predictedSet=[predictedSize:1];

    [a, b] = ANNdata(x, y);
    [testA, testB] = ANNdata(testSet, testRes);

    N = createNetwork(a, b);
    nbError = 0;

    for i = 1 : (1 + ending - starting)
        predicted = predict(N, testA(:, i));

        predictedSet(i,1) = predicted;
        if (predicted ~= testRes(i))
           nbError = nbError + 1;
        end
    end

    confusionMatrix = confusionMatrix + buildConfusionMatrix(testRes,predictedSet,6);

    avg = nbError/(1 + ending - starting);

    errSum = errSum + avg;

    x = originalX;
    y = originalY;
end

errSum/trainingSize

confusionMatrix = confusionMatrix / trainingSize;
meanRecall = computeMeanRecall(confusionMatrix);
meanPrecision = computeMeanPrecision(confusionMatrix);
meanF1 = CalcF(meanPrecision,meanRecall);
meanClass = computeMeanClassificationRate(confusionMatrix);