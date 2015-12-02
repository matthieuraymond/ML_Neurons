function [ N, tr ] = createCustomNetwork( x, y, l, trainingFunctName, varargin)
%CREATENETWORK creates a Neuron Network using A as inputs and B as labels
%Weights are initialised randomly, here we reset the seed

    rng('default'); 
    N = feedforwardnet(l,'trainlm');
    N.divideFcn = 'divideind';
    N.divideParam.trainInd = 1:903;
    N.divideParam.valInd = 904:1004;
    N.divideParam.testInd = [];
    N.trainFcn = trainingFunctName;

    N.trainParam.lr = varargin{1};
    
    if (strcmp(trainingFunctName, 'traingda') == 1)
            N.trainParam.lr_inc = varargin{2};
            N.trainParam.lr_dec = varargin{3};
    
    elseif (strcmp(trainingFunctName, 'traingdm') == 1)
        N.trainParam.mc = varargin{2};
        
    elseif(strcmp(trainingFunctName, 'trainrp') == 1)
            N.trainParam.delt_inc = varargin{2};
            N.trainParam.delt_dec = varargin{3};
    end

    N = configure(N, x, y);
    [N, tr] = train(N, x, y);
end