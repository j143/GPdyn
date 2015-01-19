%% demo_example_present

%% Description
% Demo to present the dynamics of the chosen nonlinear dynamic system: 
% 
%                y(k)
%   y(k+1) = ---------------  + [u(k)]^3
%            1 + y(k)*y(k)
%
% which is used to demonstrate the use of this toolbox. 
% 
% [1] K.S. Narendra and K. Parthasarathy. Identification
% and Control of Dynamical Systems Using Neural Networks, 
% IEEE Transactions on NN, Vol.1 No. 1, 4-27, 1990.

%% See Also
<<<<<<< HEAD
% demo_example, demo_example_gp_data, demo_example_gp_training, 
% demo_example_gp_simulation
=======
% EXAMPLE, DEMO_EXAMPLE_GP_DATA, DEMO_EXAMPLE_GP_TRAINING, 
% DEMO_EXAMPLE_GP_SIMULATION 
>>>>>>> 396c15414ee6149dcbe2c544813a6175e225583e


clear;
close all;



% ********************************************
% plotting 
uplot = [-1.5:0.1:1.5]; 
xplot = [-3.5:0.2:3.5]';
Uplot = repmat(uplot,length(xplot),1); 
Xplot = repmat(xplot,1,length(uplot)); 
Uplot = reshape(Uplot,prod(size(Uplot)),1); 
Xplot = reshape(Xplot,prod(size(Xplot)),1); 
<<<<<<< HEAD
Yplot = demo_example([Xplot,Uplot]); 
=======
Yplot = example([Xplot,Uplot]); 
>>>>>>> 396c15414ee6149dcbe2c544813a6175e225583e
yplot = reshape(Yplot,length(xplot),length(uplot)); 



ueq = [-1.5:0.02:1.5]';
for ii=1:length(ueq)
    ueq0 = ueq(ii);
<<<<<<< HEAD
    ytmp = demo_example(repmat(ueq0,400,1));
=======
    ytmp = example(repmat(ueq0,400,1));
>>>>>>> 396c15414ee6149dcbe2c544813a6175e225583e
    yeq(ii,1) = ytmp(end);      
end 
zeq = yeq + 0.02; 



figure(1); 
mesh(uplot,xplot,yplot); 
hold on; 
plot3(ueq,yeq,zeq, 'k', 'LineWidth',2); 
hold off; 
xlabel('u(k)'); 
ylabel('y(k)'); 
zlabel('y(k+1)'); 
title('Nonlinear system and equilibrium curve'); 



return; 



