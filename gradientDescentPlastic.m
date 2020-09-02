function [S0,Q1,C1,J_plastic] = gradientDescentPlastic(Xplastic, S0, Q1, C1, Yplastic, alpha, num_iters)
%GRADIENTDESCENT Performs gradient descent to learn S0, Q1, and C1
%   it updates S0, Q1, and C1 by taking num_iters gradient steps with learning rate alpha

% Initialize values =======================================================================================
m = length(Yplastic); % number of training examples
J_plastic = zeros(num_iters, 1);

for iter = 1:num_iters

    % Gradient Descent Equations ==========================================================================
    	S0=S0-alpha*(1/m)*sum(S0+Q1.*(1-exp(-C1.*Xplastic))-Yplastic);
		Q1=Q1-alpha.*(1/m)*sum((S0+Q1.*(1-exp(-C1.*Xplastic))-Yplastic).*(1-exp(-C1.*Xplastic)));
		C1=C1-alpha*(1/m)*sum((S0+Q1.*(1-exp(-C1.*Xplastic))-Yplastic).*Q1.*Xplastic.*exp(-C1.*Xplastic));

                                                                               
    % =====================================================================================================

    % Save the cost J in every iteration    
    J_plastic(iter) = costFunctionPlastic(Xplastic,Yplastic,S0,Q1,C1);

end

end
