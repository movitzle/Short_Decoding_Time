clear all
% Need to change this variable to match the selected alpha value in
% simulations
alpha_load = '1.2';

colors = [0.35    0.54    0.69;
    0.92    0.28    0.29;
    0.44    0.75    0.43;
    1.00    0.60    0.20];

R_sq = zeros(4,1);
coefficients = zeros(4,2);
figure;
set(gca,'fontsize',12)
hold on;


load(strcat('./Results/alpha_',alpha_load,'/workspace_D_1_b_0_xi_1_L_5.mat'));

prediction = getPrediction(amps,width,N,L,D,c,lambda1); % Right hand term in equation (9)
[R_sq(1), coefficients(1,:)] = fitData(prediction, T_th, b, c, colors, 1, 1);

load(strcat('./Results/alpha_',alpha_load,'/workspace_D_1_b_0_xi_2_L_5.mat'));

prediction = getPrediction(amps,width,N,L,D,c,lambda1); % Right hand term in equation (9)
[R_sq(2), coefficients(2,:)] = fitData(prediction, T_th, b, c, colors, 2, 0);

load(strcat('./Results/alpha_',alpha_load,'/workspace_D_2_b_0_xi_1_L_5.mat'));

prediction = getPrediction(amps,width,N,L,D,c,lambda1); % Right hand term in equation (9)
[R_sq(3), coefficients(3,:)] = fitData(prediction, T_th, b, c, colors, 3, 1);

load(strcat('./Results/alpha_',alpha_load,'/workspace_D_2_b_0_xi_2_L_5.mat'));

prediction = getPrediction(amps,width,N,L,D,c,lambda1); % Right hand term in equation (9)
[R_sq(4), coefficients(4,:)] = fitData(prediction, T_th, b, c, colors, 4, 0);
legend({'$\lambda_1 = 1$, $D = 1$','Prediction $\lambda_1 = 1$, $D = 1$','$\lambda_1 = 1/2$, $D = 1$','$\lambda_1 = 1$, $D = 2$','Prediction $\lambda_1 = 1$, $D = 2$','$\lambda_1 = 1/2$, $D = 2$'},'Interpreter','latex','fontsize',12)
R_sq
coefficients
% save figure
save_to = strcat('./Results/alpha_',alpha_load,'/');
name = 'Fig_4c_main';

save_figure(save_to, name, gcf)

%% 
colors = [0.35    0.54    0.69;
    0.92    0.28    0.29;
    0.44    0.75    0.43;
    1.00    0.60    0.20];
figure;
set(gca,'fontsize',20)
hold on;
load(strcat('./Results/alpha_',alpha_load,'/workspace_D_1_b_0_xi_1_L_5.mat'));
plot(c, approx_FI(:), 'k', 'LineWidth', 3)
plot(c, est_FI(:), '--o', 'LineWidth', 3, 'MarkerSize',12, 'Color', colors(1,:))


load(strcat('./Results/alpha_',alpha_load,'/workspace_D_1_b_0_xi_2_L_5.mat'));
plot(c, approx_FI(:), 'k', 'LineWidth', 3)
plot(c, est_FI(:), '--o', 'LineWidth', 3, 'MarkerSize',12, 'Color', colors(2,:))


load(strcat('./Results/alpha_',alpha_load,'/workspace_D_2_b_0_xi_1_L_5.mat'));
plot(c, approx_FI(:), 'k', 'LineWidth', 3)
% Fisher information matrix, plot the average of diagonal elements
mean_est_FI = arrayfun(@(k) mean(diag(est_FI(:,:,k))), 1:length(c));
plot(c, mean_est_FI, '--o', 'LineWidth', 3, 'MarkerSize',12, 'Color', colors(3,:))

load(strcat('./Results/alpha_',alpha_load,'/workspace_D_2_b_0_xi_2_L_5.mat'));
plot(c, approx_FI(:), 'k', 'LineWidth', 3)
% Fisher information matrix, plot the average of diagonal elements
mean_est_FI = arrayfun(@(k) mean(diag(est_FI(:,:,k))), 1:length(c));
plot(c, mean_est_FI, '--o', 'LineWidth', 3, 'MarkerSize',12,'Color', colors(4,:))


set(gca, 'YScale', 'log')
xlabel('Scale factor, c', 'Interpreter', 'latex', 'FontSize', 26)
ylabel('(Average) Fisher information', 'Interpreter', 'latex', 'FontSize', 26)
xlim([0.2,1])
xticks([0.2,0.4,0.6,0.8,1])
% save figure
save_to = strcat('./Results/alpha_',alpha_load,'/');
name = 'Fig_4c_inset';
save_figure(save_to, name, gcf)