function [ meanClassRate ] = computeMeanClassificationRate( confusionMatrix )

actualSize = size(confusionMatrix,1);
TP = 0;
FP = 0;
TN = 0;
FN = 0;
classSum = 0;
meanClassRate = 0;

for index = 1:actualSize
    TP = confusionMatrix(index,index);
    FP = sum(confusionMatrix(:,index)) - TP;
    FN = sum(confusionMatrix(index,:)) - TP;
    TN = sum(confusionMatrix(:)) - (TP+ FP +FN);
    classSum = classSum + calculateClassificationRate(TP, TN, sum(confusionMatrix(:)));
end

meanClassRate = classSum / actualSize;


end

