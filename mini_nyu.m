clear all; close all; clc

disp('shrinking nyusplpits.mat to create nuyusplits_mini.mat')

reduction_factor = 100;

load('../data/benchmarkData/metadata/nyusplits.mat')
val = val(1:floor(end/reduction_factor));
train = train(1:floor(end/reduction_factor));
test = test(1:floor(end/reduction_factor));
train1 = train1(1:floor(end/reduction_factor));
train2 = train2(1:floor(end/reduction_factor));
val1 = val1(1:floor(end/reduction_factor));
val2 = val2(1:floor(end/reduction_factor));
trainval = trainval(1:floor(end/reduction_factor));
save('../data/benchmarkData/metadata/nyusplits_mini.mat')

disp('done')
