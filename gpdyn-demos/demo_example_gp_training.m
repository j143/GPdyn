%% demo_example_gp_training

%% Description
<<<<<<< HEAD
% This demo presents how to train (=identify) the GP model, which
% describes the nonlinear dynamic system.

%% See Also
% demo_example, demo_example_gp_data, demo_example_gp_simulation,
% demo_example_norm, gp, gpx, gp_initial, trainGParx, trainGPoe 
 
clear all;
close all;

% load data from file
load example_data 

% Build training data (delayed outputs y first) 
input = [xtrain utrain]; 
target = [ytrain]; 

% Define covariance function: Squared exponential covariance function with
% ARD
cov = @covSEard; 

% Define covariance function: Gaussinan likelihood function.
lik = @likGauss;

% Define mean function: Zero mean function.
mean = @meanZero;

% Define inference method: Exact Inference
inf= @infExact;

%% Setting initial hyperparameters
% For hyperparameters a struct is used. The struct has to be of the
% following shape:
% hyp = 
%      cov: [] - covariance function parameters
%      lik: [] - likelyhood function parameters
%      mean: [] -  mean function parameters
% 
% To get the number of hyperparameters you could
% use: eval_func(cov),  eval_func(cov) or eval_func(mean).
%

D = size(input,2); % Input space dimension
hyp0.cov  = -ones(D+1,1); 

% Define likelihood hyperparameter. In our case this parameter is noise
% parameter.
hyp0.lik=log(0.1);
 
hyp0.mean = []; 

%% gp_initial
% We can also use a ruthine gp_initial to find the initial hperparameters.
% This function returns best set of n random sets of hyperparameter values. 
% As score it uses a log marginal likelihood. The number of the parameters
% is adjusted to the current covariance, likelihood and mean function.% 

% Set between which bounds the best set of hyperparameters will be estimated.
bounds=[-7,8];

% Find initial hyperparamerers:
hyp0_lin = gp_initial(bounds, inf, mean, @covLINard, lik, input, target);

% For further use we will train another GP model with linear covariance
% function(@covLINard).


%% Training 
% Identification of the GP model
[hyp, flogtheta, i] = trainGParx(hyp0, inf, mean, cov, lik, input, target);

% Training using Differential Evolution minimization algorithm:
[hyp_lin, flogtheta_lin, i] = trainGParx(hyp0_lin, inf, mean, @covLINard, lik, input, target, @minimizeDE);

% Training using Output Error alorithm
[hyp_oe, flogtheta, i] = trainGPoe(hyp0, inf, mean, cov, lik, input, target, @simulGPmcmc, 1);

%% Validation (Regression)
% validation on identification data 
[ytest S2test] = gp(hyp, inf, mean, cov, lik, input, target, input);

% plot
t = [0:length(input)-1]';
f1=figure('Name', 'Validation on Identification Data');
plotgp(f1,t,target, ytest, sqrt(S2test));

% validation on validation dataset (regression) 
[ytest2 S2test2] = gp(hyp, inf, mean, cov, lik, input, target, [xvalid uvalid]);

%polot
t = [0:length(uvalid)-1]';
f2=figure('Name', 'Validation on Validation Data (Regression)');
plotgp(f2,t,yvalid, ytest2, sqrt(S2test2));

% save trained GP model to file 
save example_trained hyp hyp_lin inf mean cov lik input target
=======
% Demo to present the how to train (=identify) the GP model, which
% describes the nonlinear dynamic system. 

%% See Also
% EXAMPLE, DEMO_EXAMPLE_GP_DATA, DEMO_EXAMPLE_GP_SIMULATION, TRAINGP, GPR 
 
clear;
close all;

load example_data 

yeq = example_train_data.yeq; 
ueq = example_train_data.ueq; 
utrain = example_train_data.utrain; 
xtrain = example_train_data.xtrain; 
ytrain = example_train_data.ytrain; 

% build training data (delayed outputs y first) 
input = [yeq ueq; xtrain utrain]; 
target = [yeq; ytrain]; 

% covariance function: SE + white noise 
covfunc = {'covSum',{'covSEard','covNoise'}}; 

% to get the number of hyperparameters you could use: feval(covfunc{:})
D = size(input,2); 
logtheta0 = -ones(D+2,1); 


% training 
[logtheta, flogtheta, i] = traingp(covfunc,input, target, logtheta0);

% validation on identification data 
[ytest S2test] = gpr(logtheta, covfunc, input, target, input);

figure 
plot(input(:,1),target,'b*'); 
hold on 
plot(input(:,1),ytest,'ko'); 
plot(input(:,1),ytest-2*sqrt(S2test),'k.'); 
plot(input(:,1),ytest+2*sqrt(S2test),'k.'); 
hold off 
title('Validation on training data')
xlabel('y(k-1)')
ylabel('y(k)')
legend('target','ygp','ygp\pm2\sigma') 

save example_trained 
>>>>>>> 396c15414ee6149dcbe2c544813a6175e225583e



return; 



