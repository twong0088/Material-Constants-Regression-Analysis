function [E, J_linear] = gradientDescent(Xlinear, E, Ylinear, alpha, num_iters)
%GRADIENTDESCENT Performs gradient descent to learn E
%   E = GRADIENTDESCENT(Xlinear, E, Ylinear, alpha, num_iters) updates E by 
%   taking num_iters gradient steps with learning rate alpha

% Initialize some useful values
m = length(Ylinear); % number of training examples
J_linear = zeros(num_iters, 1);

	for iter = 1:num_iters

		% Perform a single gradient step on the parameter E  
			
			slope = Xlinear'*((Xlinear * E) - Ylinear);
			E = E - alpha * (1/m) * slope;
		
																		   
		% ============================================================

		% Save the cost J in every iteration    
		J_linear(iter) = costFunction(Xlinear,Ylinear, E);

	end

end
