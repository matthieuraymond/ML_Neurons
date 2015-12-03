function [ N, tr ] = createNetwork(x, y)
%CREATENETWORK creates a Neuron Network using A as inputs and B as labels

    % RESET SEED (weights being initialised randomly)
    rng('default');
    
    % CONFIGURE NETWORK
    N = feedforwardnet(26,'traingdm');
    N.trainParam.epochs = 5000;
    N.trainParam.lr = 0.09;
    N.trainParam.mc = 0.3;
    
    N.divideFcn = 'divideind';
    N.divideParam.testInd = [];
    % FOR CROSS VALIDATION ===
      N.divideParam.trainInd = 1:802;
      N.divideParam.valInd = 803:903;
    % ========================
    N = configure(N, x, y);
    
    % TRAIN IT
    [N, tr] = train(N, x, y);
end

