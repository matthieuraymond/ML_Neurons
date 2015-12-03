function [ res ] = testANN( N, x )
%testANN computes the the predictions for examples x using network N

examples = x';
[length, ~] = size(x);
res = zeros(length, 1);

for k = 1:length 
    res(k) = predict(N, examples(:, k));
end

