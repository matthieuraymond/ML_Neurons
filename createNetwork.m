function [ N ] = createNetwork( x, y, l)
%CREATENETWORK creates a Neuron Network using A as inputs and B as labels
    rng('default'); %Weights are initialised randomly, here we reset the seed
    N = feedforwardnet(l,'trainlm');
    N = configure(N, x, y);
    N = train(N, x, y);
    
end

