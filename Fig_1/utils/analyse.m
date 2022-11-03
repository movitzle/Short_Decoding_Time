x = [];

for i=1:length(c(1:length(T_th)))
    if lambda0 == 1
        if c(i)==1
            lambda = 1;
        else
            lambda = (lambda0*c(i).^(0:(L-1)));
        end
    else
        lambda = (lambda0*c(i).^(0:(L-1)));
    end
    xi = 1./lambda;
    x(end + 1) = (mean(xi.^3)^2/mean(xi.^2)^3)
end
%% 
[x_sort, idx] = sort(x)
T_th_temp = T_th
s_temp = c(1:length(T_th));
coefficients = polyfit(x_sort, T_th_temp(idx), 1)
color = linspecer(2);
figure;
plot(s_temp(idx),T_th_temp(idx)*1000,'--o','LineWidth',1.5,'Color',color(2,:))
hold on; 
plot(s_temp(idx),(coefficients(1)*x_sort + coefficients(2))*1000,'k','LineWidth',1.5)
xlabel('X (= $ \bar{\xi^3}^2/ \bar{\xi^2}^3$)','Interpreter','latex','FontSize', 15)
ylabel('$T_{th}$ (ms)','Interpreter','latex','FontSize', 15)
%legend({'Simulation - D = 1', 'Simulation - D = 2', 'Fitted estimations'}, 'Interpreter','latex','Location','NorthWest')
%legend({strcat('Simulation - D = ',num2str(D)),'Fitted estimations', 'Simulation - D = 2', 'Simulation - D = 3'},'Interpreter','latex','Location','NorthWest')
SS_tot = sum((T_th_temp - mean(T_th_temp)).^2);

SS_res = sum((T_th_temp(idx) - (coefficients(1)*x_sort + coefficients(2))).^2);

R_sq = 1- SS_res/SS_tot


%% Rsidual plot
figure;
scatter(x_sort,T_th(idx)*1000 - (coefficients(1)*x_sort + coefficients(2))*1000)
hold on;
%% 

x_mean = [];
for i=1:length(xi_vec)
    xi_temps = nchoosek(xi_vec(2:end),i-1);
    for j=1:nchoosek(length(xi_vec(2:end)),i-1)
        xi = [1, xi_temps(j,:)]
        x_mean(end + 1) = mean(xi);
    end
end
[x_mean_sort, mean_idx] = sort(x_mean);
figure; plot(x_mean(mean_idx),T_th(mean_idx)*1000,'--o','LineWidth',1.5,'Color',c)

%% plot distributions of spatial frequencies
C = linspecer(3);
x = [];
edges = 0.5:1:4.5;
xi_cell = [xi_cell(1), xi_cell(6), xi_cell(8)];
for i=1:length(xi_cell)
    xi = cell2mat(xi_cell(i))
    x(end + 1) = mean(xi.^3)^2/mean(xi.^2)^3
    xi_vec = repmat(xi, [1 N/length(xi)]);
    figure('visible','off');
    xi_N = histogram(xi_vec, edges,'FaceColor',C(i,:));
    ylim([0,N])
    xlim([0, 5])
    xticks([1,2,3,4])
    xlabel('Spatial frequency / Number of peaks','Interpreter','latex','FontSize', 20)
    ylabel('Number of neurons','Interpreter','latex','FontSize', 20)
    save_to = '.\Results\histogram_xi\';
    
    name = strcat('xi_',num2str(xi));
    
    mkdir(strcat(save_to,'\eps'))
    fig_name_eps = strcat('\eps\', name);
    saveas(gcf, strcat(save_to, fig_name_eps) ,'epsc')

    mkdir(strcat(save_to,'\png'))
    fig_name_png = strcat('\png\', name);
    saveas(gcf, strcat(save_to,fig_name_png) ,'png')

    mkdir(strcat(save_to,'\fig'))
    fig_name_fig = strcat('\fig\', name);
    saveas(gcf, strcat(save_to,fig_name_fig) ,'fig')
end