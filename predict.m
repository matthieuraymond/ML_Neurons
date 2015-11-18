function [ res ] = predict( N, r )
    %PREDICT takes a neuron network N and a row of action units and classify it
    % in one of our 6 emotions class

    class = sim(N, r);
    max = class(1);
    res = 1;

    for i = 2 : 6
         if class(i) > max
             max = class(i);
             res = i;
         end;
    end
end

