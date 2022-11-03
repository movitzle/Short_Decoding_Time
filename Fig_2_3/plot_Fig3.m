clear all

colors = [0.35    0.54    0.69;
    0.92    0.28    0.29;
    0.44    0.75    0.43;
    1.00    0.60    0.20];
% Plot minimal decoding times for D = 1
figure;
hold on;
% Without background activity
load('./Results/workspace_D_1_b_0_xi_1_L_5.mat')
prediction = getLowerBound(amps,width,N,L,D,c,lambda0);
[R_sq, coefficients] = fitData(prediction, T_th, c, colors, 1, 1)

load('./Results/workspace_D_1_b_0_xi_2_L_5.mat')
prediction = getLowerBound(amps,width,N,L,D,c,lambda0);
[R_sq, coefficients] = fitData(prediction, T_th, c, colors, 2, 0)

% With background activity
load('./Results/workspace_D_1_b_2_xi_1_L_5.mat')
prediction = getLowerBound(amps,width,N,L,D,c,lambda0);
[R_sq, coefficients] = fitData(prediction, T_th, c, colors, 1, 1)

load('./Results/workspace_D_1_b_2_xi_2_L_5.mat')
prediction = getLowerBound(amps,width,N,L,D,c,lambda0);
[R_sq, coefficients] = fitData(prediction, T_th, c, colors, 2, 0)

% save figure
save_to = './Results/';
name = 'Fig3a';
save_figure(save_to, name, gcf)


% Plot minimal decoding times for D = 2
figure;
hold on;
% Without background activity
load('./Results/workspace_D_2_b_0_xi_1_L_5.mat')
colors = [0.35    0.54    0.69;
    0.92    0.28    0.29;
    0.44    0.75    0.43;
    1.00    0.60    0.20];
prediction = getLowerBound(amps,width,N,L,D,c,lambda0);
[R_sq, coefficients] = fitData(prediction, T_th, c, colors, 3, 1)

load('./Results/workspace_D_2_b_0_xi_2_L_5.mat')
prediction = getLowerBound(amps,width,N,L,D,c,lambda0);
[R_sq, coefficients] = fitData(prediction, T_th, c, colors, 4, 0)

% With background activity
load('./Results/workspace_D_2_b_2_xi_1_L_5.mat')
colors = linspecer(4);
prediction = getLowerBound(amps,width,N,L,D,c,lambda0);
[R_sq, coefficients] = fitData(prediction, T_th, c, colors, 3, 1)

load('./Results/workspace_D_2_b_2_xi_2_L_5.mat')
prediction = getLowerBound(amps,width,N,L,D,c,lambda0);
[R_sq, coefficients] = fitData(prediction, T_th, c, colors, 4, 0)


% save data
save_to = './Results/';
name = 'Fig3b';
save_figure(save_to, name, gcf)