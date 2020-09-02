% This program is used to find the material constants of a ductile material. 
% The linear region of a stress strain curve is reprsented by σ=E*ε where σ is the stress, E is the Young's modulus and ε is strain.
% The plastic region  is represented by the Voce Hardening Law σ=S0+Q1*(1-exp(-C1*ε)) where S0, Q1 and C1 are Voce Constants
% This program utilizes gradient descent to determine the material constants
% A for-loop is used to test various strains at which material becomes plastic (Labeled as XBreak in code)
% User of this program will need to load sorted stress strain data (ascending strain), set up XBreak settings by estimating the XBreak range, and set up gradient descent setting. 
% Fitting parameters are initialized to a random number in the order of magnitude of the material constants as found in literature to expedite gradient descent process

%==================================================================================================================================================================================================================================
%% Initialization DO NOT CHANGE!
clear ; close all; clc
lowestCost=10000000000000;
bestXBreak=0;
bestE=0;
bestS0=0;
bestQ1=0;
bestC1=0;
bestLinearCost=0;
bestPlasticCost=0;
Breakpoint=0;
maxPlastic=0;


%% Load Data ======================================================================================================================================================================================================================

data = load('sorted_cluster_0.csv');
X = data(:, 1); y = data(:, 2);

%XBreak settings =================================================================================================================================================================================================================
XBreak=0.004; %Minimum XBreak value
XBreak_refinement=0.0002; %XBreak testing step size
num_trials=5; %Number of XBreak you want to try

%Gradient Descent setting ========================================================================================================================================================================================================
num_iters = 50000; 
alpha = 0.03;


fprintf('Running Gradient Descent ...\n')
 
for i=0:num_trials-1
%Split data into linear/ plastic arrays ========================================================================================================================================================================================
Xlinear=X(X<=XBreak);
Xplastic=X(X>XBreak);
Ylinear=y(1:size(Xlinear));
Yplastic=y(size(Xlinear)+1:end);


%% ============ Part 2: Compute Cost and Gradient ==============================================================================================================================================================================
% Initialize fitting parameters
[m, n] = size(X);
E=61000;
S0=200;
Q1=40;
C1=20;                                  

%Linear Region =================================================================================================================================================================================================================
[E,J_linear]= gradientDescent(Xlinear, E, Ylinear, alpha, num_iters);
linearCost=J_linear(end);

%Plastic Region ================================================================================================================================================================================================================
[S0,Q1,C1,J_plastic] = gradientDescentPlastic(Xplastic, S0, Q1, C1, Yplastic, alpha, num_iters);
plasticCost=J_plastic(end);

% Total Cost Function ==========================================================================================================================================================================================================
totalCost=linearCost+plasticCost;

% Determine Best Fit parameters =================================================================================================================================================================================================
if (lowestCost>totalCost)
	lowestCost=totalCost;
	bestXBreak=XBreak;
	bestE=E;
	bestS0=S0;
	bestQ1=Q1;
	bestC1=C1;
	bestLinearCost=linearCost;
	bestPlasticCost=plasticCost;
	Breakpoint=Xlinear(end);
	maxPlastic=Xplastic(end);
end

%Display =======================================================================================================================================================================================================================
printf("\nTest: "), disp(i+1), printf("Plastic Strain: "), disp(XBreak), printf("E: "), disp(E), printf("S0: "), disp(S0), printf("Q1 :"), disp(Q1), printf("C1: "), disp(C1), printf("Linear Cost: "), disp(linearCost), 
printf("Plastic Cost: "), disp(plasticCost), printf("Combined Cost: "), disp(totalCost), printf('\n');
%strcat("\nTest: ", i+1, "Transition Strain: ", XBreak, "E: ", E, "S0: ", S0, "Q1 :", Q1, "C1: ", C1, "Cost: ", totalCost, "\n");

%Incremental increase of XBreak ================================================================================================================================================================================================
XBreak=XBreak+XBreak_refinement;
end

% Display best fit =============================================================================================================================================================================================================
printf("\nBest Fit: "), printf("\nPlastic Strain: "), disp(bestXBreak), printf("E: "), disp(bestE), printf("S0: "), disp(bestS0), printf("Q1 :"), disp(bestQ1), printf("C1: "), disp(bestC1), 
printf("Linear Cost: "), disp(bestLinearCost), printf("Plastic Cost: "), disp(bestPlasticCost), printf("Combined Cost: "), disp(lowestCost), printf('\n');
linearStrain= 0:0.0005:Breakpoint;
plasticStrain=Breakpoint:0.0005:maxPlastic;

linearStress=bestE*linearStrain;
plasticStress=bestS0+bestQ1*(1-exp(-bestC1*plasticStrain));
% Plotting ======================================================================================================================================================================================================================
plot(X, y,'b',linearStrain,linearStress,'ro',plasticStrain,plasticStress,'ro');
% Put some labels 
hold on;
% Labels and Legend
xlabel('Strain')
ylabel('Stress (MPa)')
title ("Stress vs Strain Curve",'FontSize',14);
legend({"Empirical Data", "Fitted Line"},"location","southeast");

printf("\nEnd of Program.............................................. \n\n");




