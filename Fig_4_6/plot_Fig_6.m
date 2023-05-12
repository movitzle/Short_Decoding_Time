clear all
addpath('./utils')

% Need to change this variable to match the selected alpha value in
% simulations
alpha_load = '1.2';

colors = [0.35    0.54    0.69;
    0.92    0.28    0.29;
    0.44    0.75    0.43;
    1.00    0.60    0.20];



% Plot minimal decoding times for D = 1
R_sq_D_1 = zeros(4,1);
coefficients_D_1 = zeros(4,2);
figure;
set(gca,'fontsize',12,'Box','off')
hold on;
% Without background activity

load(strcat('./Results/alpha_',alpha_load,'/workspace_D_1_b_0_xi_1_L_5.mat'));
prediction = getPrediction(amps,width,N,L,D,c,lambda1);
[R_sq_D_1(1), coefficients_D_1(1,:)] = fitData(prediction, T_th, b, c, colors, 1, 1, 200);

load(strcat('./Results/alpha_',alpha_load,'/workspace_D_1_b_0_xi_2_L_5.mat'));
prediction = getPrediction(amps,width,N,L,D,c,lambda1);
[R_sq_D_1(2), coefficients_D_1(2,:)] = fitData(prediction, T_th, b, c, colors, 2, 0, 200);

% With background activity
load(strcat('./Results/alpha_',alpha_load,'/workspace_D_1_b_2_xi_1_L_5.mat'));
prediction = getPrediction(amps,width,N,L,D,c,lambda1);
[R_sq_D_1(3), coefficients_D_1(3,:)] = fitData(prediction, T_th, b, c, colors, 1, 1, 200);


load(strcat('./Results/alpha_',alpha_load,'/workspace_D_1_b_2_xi_2_L_5.mat'));
prediction = getPrediction(amps,width,N,L,D,c,lambda1);
[R_sq_D_1(4), coefficients_D_1(4,:)] = fitData(prediction, T_th, b, c, colors, 2, 0, 200);

% save figure
save_to = strcat('./Results/alpha_',alpha_load,'/');
name = 'Fig_6a';
save_figure(save_to, name, gcf)


% Plot minimal decoding times for D = 2

R_sq_D_2 = zeros(4,1);
coefficients_D_2 = zeros(4,2);
figure;
set(gca,'fontsize',12,'Box','off')
hold on;
% Without background activity

load(strcat('./Results/alpha_',alpha_load,'/workspace_D_2_b_0_xi_1_L_5.mat'));
prediction = getPrediction(amps,width,N,L,D,c,lambda1);
[R_sq_D_2(1), coefficients_D_2(1,:)] = fitData(prediction, T_th, b, c, colors, 3, 1, 200);


load(strcat('./Results/alpha_',alpha_load,'/workspace_D_2_b_0_xi_2_L_5.mat'));
prediction = getPrediction(amps,width,N,L,D,c,lambda1);
[R_sq_D_2(2), coefficients_D_2(2,:)] = fitData(prediction, T_th, b, c, colors, 4, 0, 200);

% With background activity
load(strcat('./Results/alpha_',alpha_load,'/workspace_D_2_b_2_xi_1_L_5.mat'));
prediction = getPrediction(amps,width,N,L,D,c,lambda1);
[R_sq_D_2(3), coefficients_D_2(3,:)] = fitData(prediction, T_th, b, c, colors, 3, 1, 200);

load(strcat('./Results/alpha_',alpha_load,'/workspace_D_2_b_2_xi_2_L_5.mat'));
prediction = getPrediction(amps,width,N,L,D,c,lambda1);
[R_sq_D_2(4), coefficients_D_2(4,:)] = fitData(prediction, T_th, b, c, colors, 4, 0, 200);

% save data
save_to = strcat('./Results/alpha_',alpha_load,'/');
name = 'Fig_6b';
save_figure(save_to, name, gcf)
R_sq_D_1
R_sq_D_2
ratio_D_1 = coefficients_D_1(3,1)/coefficients_D_1(1,1)
ratio_D_2 = coefficients_D_2(3,1)/coefficients_D_2(1,1)