function [ N ] = createNetwork( x, y )
%CREATENETWORK creates a Neuron Network using A as inputs and B as labels

    N = feedforwardnet(10,'trainlm');
    N = configure(N, x, y);
    N = train(N, x, y);
    
end

