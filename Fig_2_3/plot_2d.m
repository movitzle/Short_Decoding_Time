clear all;
close all;
figure;
hold on;
color = [0.35    0.54    0.69;
    0.92    0.28    0.29;
    0.44    0.75    0.43;
    1.00    0.60    0.20];

load('./Results/workspace_D_1_b_0_xi_1_L_5.mat')

FI_est_plt = est_FI(:);
plot(FI_est_plt, T_th*1000 ,'-o','LineWidth',1.5,'Color', color(1,:));


hold on;
load('./Results/workspace_D_1_b_0_xi_2_L_5.mat')
T_th_plt = T_th;

FI_est_plt = est_FI(:);
plot(FI_est_plt, T_th_plt*1000 ,'-o','LineWidth',1.5,'Color', color(2,:));

% In the 2D case 

load('./Results/workspace_D_2_b_0_xi_1_L_5.mat')
T_th_plt = T_th;

FI_est_plt = zeros(1,length(c));
for k=1:length(c)
    % take the mean of the diagonal elements of the FI matrix for the
    % specific FI matrix corresponding to each scale factor c 
    FI_est_plt(k) = mean(diag(est_FI(:,:,k)));
end
plot(FI_est_plt, T_th_plt*1000 ,'-o','LineWidth',1.5,'Color', color(3,:));

load('./Results/workspace_D_2_b_0_xi_2_L_5.mat')
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

ylabel('$T_{th}$ (ms)','Interpreter','latex','FontSize', 15)
xlabel('Average fisher information','Interpreter','latex','FontSize', 15)

x0 = 100;
y0 = 100;
width = 300;
height = 230;

save_to = './Results/';
name = 'Fig2d';
save_figure(save_to, name, gcf)