mini_nyu;
clear;
incl = {'ucm', 'COM', 'utils', ...
	'semantics', 'segmentation', ...
	'ucmGT', 'classify', 'sceneClassification', 'allBenchmarks', ...
	'external', 'external/vlfeat/toolbox/', 'external/BSR/grouping/lib', 'external/BSR/bench/benchmarks'};
for i = 1:length(incl)
	addpath(incl{i});
end
vl_setup();
fprintf('Set up and ready to use...!\n');
