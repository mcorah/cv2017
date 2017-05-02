function [prob, pred] = testMCL(x, model)
	[pred, ~, sc] = predictLinear(zeros(1,size(x,2))', sparse(x), model, '-b 1', 'col');
	prob(model.Label,:) = sc';
end
