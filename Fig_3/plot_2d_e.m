close all
clear all
addpath('./utils')
M = 300;
width = 0.3;
D = 1;
c_pred = 1:-0.001:0.05;
amps = 20; % mean peak amplitude
p_err = 10^(-4);
C_color = [0.35    0.54    0.69; 0.92    0.28    0.29];
T_approx = zeros(2, length(c_pred));
delta_star = zeros(2, length(c_pred));
Jinv = zeros(2, length(c_pred));

font_size = 26;

alpha_load = 'alpha_2';
%% 

%load single-peaked population (1/lambda = xi = 1) data
load(strcat('Results/',alpha_load,'/workspace_D_1_b_0_xi_1_L_2.mat'));
c = 1:-0.01:0.05;
% disregard all points which reached maximal decoding time considered in simulations.
infty_idx = find(T_th==0.4);
T_th(infty_idx) = inf; % if the script did not stop, then we don't know the decoding time.
mean_amps = mean(amps,'all');
% get the predicted mimimal decoding times
lambda0 = 1;
[T_approx(1,:),delta_star(1,:), Jinv(1,:)] = get_prediction(mean_amps, c_pred, lambda0, p_err, M, width, D);


figure('Position',[10,10,6.25*400,6.25*200]);

subplot(3,4,[5,6,9,10])
set(gca,'FontSize',font_size,'Box','off')
% Predicted Minimal decoding time
plot(c_pred,T_approx(1,:)*1000, 'Color', [100 100 100]/255,'LineWidth',3)
hold on;
% Minimal decoding time estimated from simulations
scatter(c,T_th*1000,50,C_color(1,:),'LineWidth',3)
xlim([0.05,1])
ylim([0,300])
xlabel('Scale factor, c','Interpreter','latex')
ylabel('Minimal decoding time, $T_{th}$ (ms)','Interpreter','latex')
set(gca,'FontSize',font_size,'Box','off')

subplot(3,4,1);
plot(c_pred,  1./delta_star(1,:), 'Color', C_color(1,:),'LineWidth',4)
xlabel('Scale factor, c','Interpreter','latex')
ylabel('$1/\delta^*$','Interpreter','latex')
set(gca,'FontSize',font_size,'Box','off')
ylim([0,200])
xlim([0.05,1])
xticks([0.2,0.4,0.6,0.8,1])


subplot(3,4,2);
plot(c_pred, Jinv(1,:), 'Color', C_color(1,:),'LineWidth',4)
set(gca,'YScale','log')
xlabel('Scale factor, c','Interpreter','latex')
ylabel('$1/J_{1,norm} + 1/J_{2,norm}$','Interpreter','latex')

ylim([10^(-6),1.5*10^(-5)]);
xlim([0.05,1])
xticks([0.2,0.4,0.6,0.8,1])
set(gca,'FontSize',font_size,'Box','off')

C_color = [0.35    0.54    0.69; 0.92    0.28    0.29];
%load periodic population (1/lambda = xi = 2) data
load(strcat('./Results/',alpha_load,'/workspace_D_1_b_0_xi_2_L_2.mat'));
infty_idx = find(round(T_th,5)==0.4);   % disregard all points which reached maximal decoding time considered in simulations.
T_th(infty_idx) = inf;

c = [0.95:-0.01:0.51, 0.49:-0.01:0.26,0.24:-0.01:0.21,0.19:-0.01:0.15,0.14:-0.01:0.11, 0.09:-0.01:0.06];

mean_amps = mean(amps,'all');
lambda0 = 1/2;

[T_approx(2,:),delta_star(2,:), Jinv(2,:)] = get_prediction(mean_amps, c_pred, lambda0, p_err, M, width, D);

subplot(3,4,[7,8,11,12])
hold on;
plot(c_pred,T_approx(2,:)*1000, 'Color', [100 100 100]/255,'LineWidth',3)

scatter(c,T_th*1000,50,C_color(2,:),'LineWidth',3)

xlim([0.05,1])
ylim([0,300])
xlabel('Scale factor, c','Interpreter','latex')
ylabel('Minimal decoding time, $T_{th}$ (ms)','Interpreter','latex')
set(gca,'FontSize',font_size,'Box','off')
%
subplot(3,4,3);
y = 1./delta_star(2,:);
xs = c_pred(~isnan(y));
ys = y(~isnan(y));
plot(xs,  ys, 'Color', C_color(2,:),'LineWidth',4)
xlabel('Scale factor, c','Interpreter','latex')
ylabel('$1/\delta^*$','Interpreter','latex')

ylim([0,200])
xlim([0.05,1])
xticks([0.2,0.4,0.6,0.8,1])
set(gca,'FontSize',font_size,'Box','off')

subplot(3,4,4)

plot(c_pred, Jinv(2,:), 'Color', C_color(2,:),'LineWidth',4)
set(gca,'YScale','log')
xlabel('Scale factor, c','Interpreter','latex')
ylabel('$1/J_{1,norm} + 1/J_{2,norm}$','Interpreter','latex')
ylim([10^(-6),1.5*10^(-5)]);
xlim([0.05,1])
xticks([0.2,0.4,0.6,0.8,1])
set(gca,'FontSize',font_size,'Box','off')

save_to = strcat('./Results/',alpha_load);
name = '/Fig_2_T_th';
save_figure(save_to,name,gca)
%% Calculate R^2 values

load(strcat('Results/',alpha_load,'/workspace_D_1_b_0_xi_1_L_2.mat'));
mean_amps = mean(amps,'all');

for i=1:length(c)
    idx_c_pred(i) = find(c_pred == c(i));
end
SS_tot = sum((T_th - mean(T_th)).^2);
SS_res = sum((T_th - T_approx(1,idx_c_pred)).^2);
R_sq_xi_1 = 1- SS_res/SS_tot


load(strcat('Results/',alpha_load,'/workspace_D_1_b_0_xi_2_L_2.mat'));
c = [0.95:-0.01:0.51, 0.49:-0.01:0.26,0.24:-0.01:0.21,0.19:-0.01:0.15,0.14:-0.01:0.11, 0.09:-0.01:0.06];
% We set the maximum decoding time to 400ms, so remove all samples at 400ms
% or larger (not completed).
idx_remove = find(T_th >=0.400); 
c(idx_remove) = [];
T_th(idx_remove) = [];

mean_amps = mean(amps,'all');
idx_c_pred_xi_2 = [];
for i=1:length(c)
    idx_c_pred_xi_2(i) = find(round(c_pred,4) == round(c(i),4));
end
SS_tot = sum((T_th - mean(T_th)).^2);
SS_res = sum((T_th - T_approx(2,idx_c_pred_xi_2)).^2);

R_sq_xi_2 = 1- SS_res/SS_tot

function [T_approx, delta_star, Jinv] = get_prediction(amps,c,lambda0,p_err,M,width,D)
    %vectors to save results
    delta_star = zeros(1,length(c)); 
    T_approx = zeros(1,length(c));
    Jinv = zeros(1,length(c));
    for i=1:length(c)
        lambda1 = lambda0;

        K1 = ceil(1/(2*lambda1));
        n1 = -K1:1:K1;


        lambda2 = lambda1*c(i); 
        K2 = ceil(1/(2*lambda2));
        n2 = -K2:1:K2;
        
        C = zeros(length(n1),length(n2));
        for j=1:length(n1)
            for k=1:length(n2)
                if abs(n1(j))*lambda1>=1 || abs(n2(k))*lambda2>=1
                    C(j,k) = inf; % If at least one mode is 1 full rotation away or more disregard this
                else
                    C(j,k) = 1/2*abs(n1(j)*lambda1 - n2(k)*lambda2); % Expression to minimize in Eq 6.
                end
            end
        end
        
        if length(find(C==0)) > 1 %If more than 1 zero in C -> ambigious code! But not for lambda1 = 1, as each n1 represents the same mode.
            T_approx(i) = inf;  % Can never resolve ambiguity
        else

            idxC = find(C>0);  % Remove the (n1,n2) = (0,0) point

            delta_star(i) = min(C(idxC)); %Eq. 6
            Jinv(i) = (1/FI(lambda2,amps,M,width,D) + 1/FI(lambda1,amps,M,width,D));
            T_approx(i) = 2*erfinv(1-p_err)^2/delta_star(i)^2*Jinv(i);  %Eq. 8 in main text
        end
    end
end
function [J] = FI(lambda, amps, M, width, D)
    J = (2*pi)^2*M*amps/width*exp(-D/width)*besseli(0,1/width)^(D-1)*besseli(1,1/width)*mean((1/lambda).^2);    %Time-normalized version of Eq. 3 (not that N -> M, because this is FI for 1 module)
end