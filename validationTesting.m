function [res] = validationTesting(trainingSize, x, y, l, trainingFunctName, varargin)
        errSum = 0;
        n = length(y);
        originalX = x;
        originalY = y;
        res = zeros(1,length(varargin)+1);
        
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
            
            if (strcmp(trainingFunctName, 'traingd') == 1)
                [N, tr] = createCustomNetwork(a, b, l, trainingFunctName, varargin{1}); 
            elseif (strcmp(trainingFunctName, 'traingda') == 1)
                [N, tr] = createCustomNetwork(a, b, l, trainingFunctName, varargin{1}, varargin{2}, varargin{3}); 
    
            elseif (stcmp(trainingFunctName, 'traingdm') == 1)
                [N, tr] = createCustomNetwork(a, b, l, trainingFunctName, varargin{1}, varargin{2}); 
        
            elseif(strcmp(trainingFunctName, 'trainrp') == 1)
                [N, tr] = createCustomNetwork(a, b, l, trainingFunctName, varargin{1}, varargin{2}, varargin{3}); 
            end
            
            nbError = 0;
            
            for i = 1 : (1 + ending - starting)
                predicted = predict(N, testA(:, i));

                if (0 == testB(predicted, i))
                   nbError = nbError + 1;
                end
            end
            
            avg = nbError/(1 + ending - starting);
            errSum = errSum + avg;           
            
            x = originalX;
            y = originalY;
        end

        for i=1:length(varargin)
            res(1, i) = varargin{i};
        end
        
        res(1,length(varargin)+1) = 100*errSum/trainingSize;
end

