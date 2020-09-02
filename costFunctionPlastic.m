function [J] = costFunctionPlastic(Xplastic,Yplastic,S0,Q1,C1)
%CostFunctionPlastic Compute cost for logistic regression using S0, Q1, C1 as the parameters for logistic regression and the gradient of the cost w.r.t. to the parameters.

% Initialize values=======================================================
m = length(Yplastic); % number of training examples

J = 0;

	hPlastic=S0+Q1.*exp(-C1.*Xplastic);
	J=sum(((hPlastic) - Yplastic).^2)/(2*m);
% =============================================================

end
