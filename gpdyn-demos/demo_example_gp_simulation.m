%% demo_example_gp_simulation 

%% Description
<<<<<<< HEAD
% This demo presents the simulation of the GP model, describing dynamic
% system. Five different simulations are presented: 
% * "naive" simulation (without propagation of uncertainty) 
% * simulation with numerical (MCMC) propagation of uncertainty. 
% * simulation using taylor approximation for propagation of uncertainty. 
% * "exact" simulation (anayltical propagation of uncertainty) 
% * "exact" simulation (anayltical propagation of uncertainty) using linear
% covariance function
% 
% Based on work of: A. Girard, Approximate Methods for Propagation of
% Uncertainty with Gaussian Process Models, PhD thesis, 2004. 
 
%% See Also
% example, demo_example_present, demo_example_gp_data,
% demo_example_gp_training, demo_example_gp_norm, simulGPnaive,
% simulGPmcmc, simulGPtaylorSE, simulGPexactSE, simulGPexactLIN, construct

clear all;
close all;

% load data from file
load example_data 
load example_trained

% test data
y0 = 0; % initial value
lag = 1;

% construct input matrix for simulation (lag = 1):
% test = [y0  uvalid(1);
%          0  uvalid(2);
%
%          0  uvalid(end)];

test = construct(lag, uvalid, y0);  

t = [0:length(uvalid)-1]'; %time

%% Naive Simulation
[ynaive, s2naive] = simulGPnaive(hyp, inf, mean, cov, lik, input, target, test, lag);

f1=figure('Name', 'Naive Simulation');
plotgp(f1,t,yvalid, ynaive, sqrt(s2naive));

%% MCMC Simulation - Numerical Variance Propagation

Nsamples = 100;
[ymcmc, s2mcmc, MU, SIGMA2] = simulGPmcmc(hyp, inf, mean, cov, lik, input, target, test, lag,Nsamples);
f2=figure('Name', 'MCMC Simulation');
plotgp(f2,t,yvalid, ymcmc, sqrt(s2mcmc));

% testing pdfs in steps 1 and 14
desired_steps = [1 14]; 
mcmc_test_pdfs(MU,SIGMA2,desired_steps); 

%% Taylor Simulation - Variance Propagation using Taylor Approximation

[ytaylor, s2taylor] = ...
    simulGPtaylorSE(hyp, inf, mean, cov, lik, input, target, test, lag);

f4=figure('Name', 'Taylor Simulation');
plotgp(f4,t,yvalid, ytaylor, sqrt(s2taylor));

%% Exact Simulation - Analytical Variance Propagation

[yexactSE, s2exactSE] = ...
  simulGPexactSE(hyp, inf, mean, cov, lik, input, target, test, lag);

f3=figure('Name', 'Exact Simulation');
plotgp(f3,t,yvalid, yexactSE, sqrt(s2exactSE));

%% Exact Simulation - Analytical Variance Propagation (Using Linear Covariance Function)

[yexactLIN, s2exactLIN, ynaiveLIN, s2naiveLIN] = ...
    simulGPexactLIN(hyp_lin, inf, mean, @covLINard, lik, input, target, test, lag);

f4=figure('Name', 'Naive Simulation (Using Linear Covariacne Function)');
plotgp(f4,t,yvalid, ynaiveLIN, sqrt(s2naiveLIN));
  
f5=figure('Name', 'Exact Simulation (Using Linear Covariacne Function)');
plotgp(f5,t,yvalid, yexactLIN, sqrt(s2exactLIN));

%% Comparing results
% A function loss is available to calculate several frequently used
% perforamnce values. See the console output.

% load trained model from demo_example_gp_training
load example_trained
[yy, ss2] = simulGPexactSE(hyp, inf, mean, cov, lik, input, target, test, lag);

fprintf('\nNaive Simulation:\n');
loss(yvalid, ynaive, s2naive);                 
fprintf('\nMCMC Simulation:\n');
loss(yvalid, ymcmc, s2mcmc);
fprintf('\nTaylor Simulation:\n');
loss(yvalid, ytaylor, s2taylor);
fprintf('\nExact Simulation:\n');
loss(yvalid, yexactSE, s2exactSE);  
fprintf('\nExact Simulation (Linear Covariance Function):\n');
loss(yvalid, yexactLIN, s2exactLIN);  
=======
% Demo to present the simulation of the GP model, describing dynamic
% system. Three different simulations are presented: 
% (1) "naive" simulation (without propagation of uncertainty) 
% (2) "exact" simulation (anayltical propagation of uncertainty) 
% (3) simulation with numerical (MCMC) propagation of uncertainty. 
% See: 
%   A. Girard, Approximate Methods for Propagation of Uncertainty 
%   with Gaussian Process Models, PhD thesis, 2004. 
% for more info. 
% 
% Set flags accordingly. 

%% See Also
% EXAMPLE, DEMO_EXAMPLE_PRESENT, DEMO_EXAMPLE_GP_DATA, 
% DEMO_EXAMPLE_GP_TRAINING, SIMUL02NAIVE, SIMUL00EXACT, SIMUL02MCMC, GPR_SIMUL 

clear;
close all;

flag_naive_simulation = 1;
flag_exact_simulation = 1;
flag_mcmc_simulation = 1;

if (abs(flag_naive_simulation)+abs(flag_exact_simulation)+abs(flag_mcmc_simulation) == 0)
    disp('demo_example_simulation: at least one simulation should be chosen');
end

load example_data
load example_trained

uvalid = example_valid_data.uvalid;
xvalid = example_valid_data.xvalid;
yvalid = example_valid_data.yvalid;

% test input 
xt = [xvalid uvalid];
lag = 1;
t = [0:length(uvalid)-1]';



% naive simulation
if(flag_naive_simulation)
    [ynaive, s2naive] = simul02naive(logtheta,covfunc,input,target,xt,lag);
    plotgp(101,t,yvalid, ynaive, sqrt(s2naive));
    plotgpe(201,t,yvalid, ynaive, sqrt(s2naive));
end




% exact simulation - analytical variance propagation
if(flag_exact_simulation)
    [ynaive_exact, s2naive_exact, yexact, s2exact] = ...
        simul00exact(logtheta,covfunc,input,target,xt,lag);

    plotgp(102,t,yvalid, yexact, sqrt(s2exact));
    plotgp(103,t,yvalid, ynaive_exact, sqrt(s2naive_exact));

    plotgpe(202,t,yvalid, yexact, sqrt(s2exact));
    plotgpe(203,t,yvalid, ynaive_exact, sqrt(s2naive_exact));
end

% mcmc simulation - numerical variance propagation
if(flag_mcmc_simulation)
    Nsamples = 100;
    [ymcmc, s2mcmc, MU, SIGMA2] = simul02mcmc(logtheta,covfunc,input,target,xt,lag,Nsamples);
    
    plotgp(104,t,yvalid, ymcmc, sqrt(s2mcmc));
    plotgpe(204,t,yvalid, ymcmc, sqrt(s2mcmc));
    
    % testing pdfs in steps 1 and 14
    desired_steps = [1 14]; 
    mcmc_test_pdfs(MU,SIGMA2,desired_steps); 

end


return
>>>>>>> 396c15414ee6149dcbe2c544813a6175e225583e



