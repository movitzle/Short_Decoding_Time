clear all
colors = [0.35    0.54    0.69;
    0.92    0.28    0.29;
    0.44    0.75    0.43;
    1.00    0.60    0.20];
figure;
hold on;
load('./Results/workspace_D_1_b_0_xi_1_L_5.mat')
prediction = getLowerBound(amps,width,N,L,D,c,lambda0);
[R_sq, coefficients] = fitData(prediction, T_th, c, colors, 1, 1)

load('./Results/workspace_D_1_b_0_xi_2_L_5.mat')
prediction = getLowerBound(amps,width,N,L,D,c,lambda0);
[R_sq, coefficients] = fitData(prediction, T_th, c, colors, 2, 0)

load('./Results/workspace_D_2_b_0_xi_1_L_5.mat')
prediction = getLowerBound(amps,width,N,L,D,c,lambda0);
[R_sq, coefficients] = fitData(prediction, T_th, c, colors, 3, 1)

load('./Results/workspace_D_2_b_0_xi_2_L_5.mat')
prediction = getLowerBound(amps,width,N,L,D,c,lambda0);
[R_sq, coefficients] = fitData(prediction, T_th, c, colors, 4, 0)


% save figure
save_to = './Results/';
name = 'Fig2c_main';

save_figure(save_to, name, gcf)

%% 
colors = [0.35    0.54    0.69;
    0.92    0.28    0.29;
    0.44    0.75    0.43;
    1.00    0.60    0.20];
figure;
hold on;
load('./Results/workspace_D_1_b_0_xi_1_L_5.mat')
plot(c, approx_FI(:), 'k', 'LineWidth', 2)
plot(c, est_FI(:), '--o', 'LineWidth', 2, 'Color', colors(1,:))


load('./Results/workspace_D_1_b_0_xi_2_L_5.mat')
plot(c, approx_FI(:), 'k', 'LineWidth', 2)
plot(c, est_FI(:), '--o', 'LineWidth', 2, 'Color', colors(2,:))


load('./Results/workspace_D_2_b_0_xi_1_L_5.mat')
plot(c, approx_FI(:), 'k', 'LineWidth', 2)
% Fisher information matrix, plot the average of diagonal elements
mean_est_FI = arrayfun(@(k) mean(diag(est_FI(:,:,k))), 1:length(c));
plot(c, mean_est_FI, '--o', 'LineWidth', 2, 'Color', colors(3,:))


load('./Results/workspace_D_2_b_0_xi_2_L_5.mat')
plot(c, approx_FI(:), 'k', 'LineWidth', 2)
% Fisher information matrix, plot the average of diagonal elements
mean_est_FI = arrayfun(@(k) mean(diag(est_FI(:,:,k))), 1:length(c));
plot(c, mean_est_FI, '--o', 'LineWidth', 2, 'Color', colors(4,:))


set(gca, 'YScale', 'log')
xlabel('Scale factor, c', 'Interpreter', 'latex', 'FontSize', 16)
ylabel('(Average) Fisher information', 'Interpreter', 'latex', 'FontSize', 16)

% save figure
save_to = './Results/';
name = 'Fig2c_inset';
save_figure(save_to, name, gcf)