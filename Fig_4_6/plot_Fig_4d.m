clear all;
close all;
% Need to change this variable to match the selected alpha value in
% simulations
alpha_load = '1.2';

figure;
set(gca,'fontsize',12)
hold on;
color = [0.35    0.54    0.69;
    0.92    0.28    0.29;
    0.44    0.75    0.43;
    1.00    0.60    0.20];

load(strcat('./Results/alpha_',alpha_load,'/workspace_D_1_b_0_xi_1_L_5.mat'));

FI_est_plt = est_FI(:);
plot(FI_est_plt, T_th*1000 ,'-o','LineWidth',1.5,'Color', color(1,:));


hold on;
load(strcat('./Results/alpha_',alpha_load,'/workspace_D_1_b_0_xi_2_L_5.mat'));
T_th_plt = T_th;

FI_est_plt = est_FI(:);
plot(FI_est_plt, T_th_plt*1000 ,'-o','LineWidth',1.5,'Color', color(2,:));

% In the 2D case 

load(strcat('./Results/alpha_',alpha_load,'/workspace_D_2_b_0_xi_1_L_5.mat'));

T_th_plt = T_th;

FI_est_plt = zeros(1,length(c));
for k=1:length(c)
    % take the mean of the diagonal elements of the FI matrix for the
    % specific FI matrix corresponding to each scale factor c 
    FI_est_plt(k) = mean(diag(est_FI(:,:,k)));
end
plot(FI_est_plt, T_th_plt*1000 ,'-o','LineWidth',1.5,'Color', color(3,:));

load(strcat('./Results/alpha_',alpha_load,'/workspace_D_2_b_0_xi_2_L_5.mat'));

T_th_plt = T_th;
FI_est_plt = zeros(1,length(c));
for k=1:length(c)
    % take the mean of the diagonal elements of the FI matrix for the
    % specific FI matrix corresponding to each scale factor c 
    FI_est_plt(k) = mean(diag(est_FI(:,:,k)));
end

plot(FI_est_plt, T_th_plt*1000 ,'-o','LineWidth',1.5,'Color', color(4,:));


set(gca, 'XScale', 'log')
set(gca, 'YScale', 'log')

ylabel('Minimal decoding time, $T_{th}$ (ms)','Interpreter','latex','FontSize', 16)
xlabel('(Average) Fisher information','Interpreter','latex','FontSize', 16)

x0 = 100;
y0 = 100;
width = 300;
height = 230;

save_to = strcat('./Results/alpha_',alpha_load,'/');
name = 'Fig_4d';
save_figure(save_to, name, gcf)