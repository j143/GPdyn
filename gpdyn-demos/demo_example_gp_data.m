%% demo_example_gp_data 

%% Description
<<<<<<< HEAD
% This example shows generation of the data which is used in other demors.

%% See Also
% demo_example, demo_example_present, demo_example_gp_training, 
% demo_example_gp_simulation, demo_example_gp_norm
=======
% Demo to present how to obtain and compose data for the identification
% of the GP model. 

%% See Also
% EXAMPLE, DEMO_EXAMPLE_PRESENT, DEMO_EXAMPLE_GP_TRAINING, 
% DEMO_EXAMPLE_GP_SIMULATION 
>>>>>>> 396c15414ee6149dcbe2c544813a6175e225583e


clear;
close all;

% data parameters 
umax = 1.5; 
umin = -umax; 
N_training_points = 100; 
N_validation_points = 200; 
noise_std = 0.05; 


% training data --> eq curve AND samples very excited signal 
<<<<<<< HEAD
ueq = (-1.5:0.5:1.5)';
for ii=1:length(ueq)
    ueq0 = ueq(ii);
    ytmp = demo_example(repmat(ueq0,400,1));
    yeq(ii,1) = ytmp(end);      
end 
figure('Name', 'EQ Curve');
plot(ueq, yeq);

utrain = sig_prs_minmax(N_training_points,2,umin,umax); % create input singal

% simulate example system, to obtain delayed outputs and delayed outputs 
[ytrain, xtrain, utrain] = demo_example(utrain); 
% add noise to training data 
[ytrain, ytrain_no_noise] = add_noise_to_vector(ytrain, noise_std); 
figure('Name', 'Training Input Signal');
t=1:length(utrain);
plot(t, utrain, t, xtrain);
legend('u', 'y');
grid on;

% validation data --> less excited signal 
uvalid = sig_prs_minmax(N_validation_points,5,umin,umax); 
[yvalid, xvalid, uvalid] = demo_example(uvalid); 

figure('Name', 'Validation Input Signal');
plot(uvalid);

save example_data ... 
     ueq yeq utrain xtrain ytrain ... % training data
     uvalid xvalid yvalid ...         % validation data
     umax umin noise_std 
=======
ueq = [-1.5:0.5:1.5]';
for ii=1:length(ueq)
    ueq0 = ueq(ii);
    ytmp = example(repmat(ueq0,400,1));
    yeq(ii,1) = ytmp(end);      
end 

utrain = sig_prs_minmax(N_training_points,2,umin,umax); 
[ytrain, xtrain, utrain] = example(utrain); 
% add noise to training data 
[ytrain, ytrain_no_noise] = add_noise_to_vector(ytrain, noise_std); 

% validation data --> less excited signal 
uvalid = sig_prs_minmax(N_validation_points,1,umin,umax); 
[yvalid, xvalid, uvalid] = example(uvalid); 

% training data 
example_train_data.ueq = ueq; 
example_train_data.yeq = yeq; 
example_train_data.utrain = utrain; 
example_train_data.xtrain = xtrain; 
example_train_data.ytrain = ytrain; 

% validation data 
example_valid_data.uvalid = uvalid; 
example_valid_data.xvalid = xvalid; 
example_valid_data.yvalid = yvalid; 

save example_data example_valid_data example_train_data umax umin noise_std 




>>>>>>> 396c15414ee6149dcbe2c544813a6175e225583e
return; 



