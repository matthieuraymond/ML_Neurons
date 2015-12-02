clear;

load('cleandata_students.mat');
%load('noisydata_students.mat');

originalX = x;
originalY = y;
trainingSize = 9;
n = length(y);

res = zeros(100,3);
indexer = 1;

for layers = 1:5
    for neurons_per_layers = [10 20 30 50 100]
        
        l = ones(1,layers) * neurons_per_layers;
        errSum = 0;
        
        for k = 1:trainingSize
            starting = floor(k * n / (trainingSize + 1));
            ending = floor((k+1) * n / (trainingSize + 1));
            
            % take the validation set (10%) and put it in the end
            validSet = x(starting:ending,:);
            validRes = y(starting:ending);
            x(starting:ending,:) = [];
            y(starting:ending,:) = [];
            x = [x; validSet];
            y = [y; validRes];

            [a, b] = ANNdata(x, y);
            [testA, testB] = ANNdata(validSet, validRes);

            [N, tr] = createNetwork(a, b, l);
            
            nbError = 0;
            
            for i = 1 : (1 + ending - starting)
                predicted = predict(N, testA(:, i));

                if (1 == testB(predicted, i))
                   nbError = nbError + 1;
                end
            end
            
            avg = nbError/(1 + ending - starting);
            errSum = errSum + avg;           
            
            x = originalX;
            y = originalY;
        end
        
        res(indexer, 1) = layers;
        res(indexer, 2) = neurons_per_layers;
        res(indexer, 3) = 100*errSum/trainingSize;
        indexer = indexer + 1;
    end
end
