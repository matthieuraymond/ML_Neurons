clear;

%load('cleandata_students.mat');max=1004;
load('noisydata_students.mat');max=1001;

sum = zeros(46, 6);

for k=1:max
   sum(1,y(k)) = sum(1,y(k)) + 1;
   for i=1:45
       sum(i + 1, y(k)) = sum(i + 1, y(k)) + x(k, i);
   end
end