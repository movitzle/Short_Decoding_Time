M = 300;
width = 0.3;
D = 1;
c_pred = 1:-0.001:0.005;
amps = 20; % mean peak amplitude
p_err = 10^(-3);

T_approx = zeros(2, length(c_pred));
delta_star = zeros(2, length(c_pred));
Jinv = zeros(2, length(c_pred));
% get the predicted mimimal decoding times
lambda0 = 1;
[T_approx(1,:),delta_star(1,:), Jinv(1,:)] = get_prediction(amps, c_pred, lambda0, p_err, M, width, D);

lambda0 = 1/2;
[T_approx(2,:),delta_star(2,:), Jinv(2,:)] = get_prediction(amps, c_pred, lambda0, p_err, M, width, D);

figure; 
plot(c_pred,T_approx(1,:)*1000, 'Color', [100 100 100]/255,'LineWidth',3)
hold on;
plot(c_pred,T_approx(2,:)*1000, 'Color', [100 100 100]/255,'LineWidth',3)

C_color = [0.35    0.54    0.69; 0.92    0.28    0.29];
% import the saved simulated minimal decoding times
load('workspace_D_1_b_0_xi_1_L_2.mat');
plot(c,T_th*1000,'o','LineWidth',2,'Color',C_color(1,:))

%amps = 20;
%[T_approx, ~, ~] = get_prediction(amps, c, lambda0, p_err, M, width, D);

SS_tot = sum((T_th - mean(T_th)).^2);
SS_res = sum((T_th - T_approx(1,:)).^2);
R_sq = 1- SS_res/SS_tot

load('workspace_D_1_b_0_xi_2_L_2.mat');
plot(c,T_th*1000,'o','LineWidth',2,'Color',C_color(2,:))

%amps = 20;
%[T_approx, ~, ~] = get_prediction(amps, c, lambda0, p_err, M, width, D);

SS_tot = sum((T_th - mean(T_th)).^2);
SS_res = sum((T_th - T_approx(2,:)).^2);
R_sq = 1- SS_res/SS_tot

xlabel('Scale factor, c','Interpreter','latex','FontSize', 16)
ylabel('$T_{th}$ (ms)','Interpreter','latex','FontSize', 16)
xlim([0,1])
ylim([0,250])


%plot insets
figure;
plot(c_pred,  1./delta_star(1,:), 'Color', C_color(1,:),'LineWidth',2)
hold on;

y = 1./delta_star(2,:);
xs = c_pred(~isnan(y));
ys = y(~isnan(y));
plot(xs,  ys, 'Color', C_color(2,:),'LineWidth',2)
xlabel('Scale factor, c','Interpreter','latex','FontSize', 16)
ylabel('$1/\delta^*$','Interpreter','latex','FontSize', 16)
ylim([0,200])
figure;
plot(c_pred, Jinv(1,:), 'Color', C_color(1,:),'LineWidth',2)
hold on;
plot(c_pred, Jinv(2,:), 'Color', C_color(2,:),'LineWidth',2)
set(gca,'YScale','log')
xlabel('Scale factor, c','Interpreter','latex','FontSize', 16)
ylabel('$1/\bar J_1 + 1/\bar J_2$','Interpreter','latex','FontSize', 16)

function [T_approx, delta_star, Jinv] = get_prediction(amps,c,lambda0,p_err,M,width,D)
    delta_star = zeros(1,length(c));
    T_approx = zeros(1,length(c));
    Jinv = zeros(1,length(c));
    for i=1:length(c)
        lambda1 = lambda0;
        if lambda1 < 1
            n1 = -ceil(1/2/lambda1):1:ceil(1/2/lambda1);
        else
            n1 = 0; %for lambda1 = 1, after one rotation we have the same peak -> only 1 mode
        end
        a = n1*lambda1;
        lambda2 = lambda0*round(c(i),3); % round to avoid trucation errors
        n2 = -ceil(1/2/lambda2):1:ceil(1/2/lambda2);
        b = n2*lambda2;
        [A,B] = meshgrid(a,b);
        C = 1/2*abs(A - B); % Expression to minimize in Eq 6.
        if length(find(C==0)) > 1  %If more than 1 zero in C -> ambigious code!
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