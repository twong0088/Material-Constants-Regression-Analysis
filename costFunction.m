function [J] = costFunction(Xlinear,Ylinear,E)
%COSTFUNCTION Compute cost for logistic regression
%   J = COSTFUNCTION(E, X, y) computes the cost of using E as the
%   parameter for logistic regression and the gradient of the cost
%   w.r.t. to the parameters.

% Initialize some useful values ===============================

	m = length(Ylinear); % number of training examples
	h=E*Xlinear;
	
%Cost function ================================================
	J = sum(((h) - Ylinear).^2)/(2*m);
	
	

% =============================================================

end
