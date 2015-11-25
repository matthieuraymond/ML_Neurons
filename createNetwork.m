function [ N, tr ] = createNetwork( x, y, l)
%CREATENETWORK creates a Neuron Network using A as inputs and B as labels
    rng('default'); %Weights are initialised randomly, here we reset the seed
    N = feedforwardnet(l,'trainlm');
    N.divideFcn = 'divideind';
    N.divideParam.trainInd = 1:903;
    N.divideParam.valInd = 904:1004;
    N.divideParam.testInd = [];
    N = configure(N, x, y);
    [N, tr] = train(N, x, y);
end

