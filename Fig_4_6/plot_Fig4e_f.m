colors = [0.35    0.54    0.69;
    0.92    0.28    0.29;
    0.44    0.75    0.43;
    1.00    0.60    0.20];
    
c_vec = [0.4,0.6,0.8];
plt_pct = 99.8;
load_base = '.\Results';

b = 0;

for D=[1,2]

    figure()
    set(gcf,'position',[400,200,1300,400])

    if D == 1
        T_vec = [5,15,30];
    elseif D == 2
        T_vec = [20,60,100];
    end
    for i = 1:length(T_vec)
        T = T_vec(i);
        xi_1 = strcat('\fixed_T\D_',num2str(D),'_b_',num2str(b),'_xi_1_T_',num2str(T),'_L_5.mat');
        xi_2 = strcat('\fixed_T\D_',num2str(D),'_b_',num2str(b),'_xi_2_T_',num2str(T),'_L_5.mat');
        subplot_SQ_ERR(0,100,load_base, xi_1, xi_2, i, num2str(T), colors(2*(D-1)+1:2*(D-1)+2,:))
        subplot_SQ_ERR(1,plt_pct,load_base, xi_1, xi_2, i, num2str(T), colors(2*(D-1)+1:2*(D-1)+2,:))

    end
    addpath('utils')
    if D==1
        name = strcat('Figure_4e');
    else
        name = strcat('Figure_4f');
    end
    save_figure(strcat('.\Results\',name,'\'), name, gcf);

end


function [] = subplot_SQ_ERR(plt_fill, plt_pct, load_base, xi_1, xi_2, fig_idx, T, colors)
    % plt_qt plot the following quantile
    subplot(1,3,fig_idx);
    hold on;
    SP = load(strcat(load_base, xi_1),'sq_errs','MSE','c');
    MP = load(strcat(load_base,xi_2),'sq_errs','MSE','c');
    
    
    SP.RMSE = sqrt(mean(SP.MSE,1));
    plot(SP.c, SP.RMSE, 'Color', colors(1,:),'LineWidth',3)
    
    MP.RMSE = sqrt(mean(MP.MSE,1));
    plot(MP.c, MP.RMSE, 'Color', colors(2,:),'LineWidth',3)

    for i=1:length(SP.c)
        SP.quantile(i) = prctile(sqrt(SP.sq_errs(:,:,i)), plt_pct, [1 2]);
        
    end
    for i=1:length(MP.c)
        MP.quantile(i) = prctile(sqrt(MP.sq_errs(:,:,i)), plt_pct, [1 2]);
    end
    if plt_fill
        scatter(SP.c, SP.quantile, 80, colors(1,:),'filled','LineWidth',2)
        scatter(MP.c, MP.quantile, 80, colors(2,:),'filled','LineWidth',2)
    else
        scatter(SP.c, SP.quantile, 80, colors(1,:),'LineWidth',2)
        scatter(MP.c, MP.quantile, 80, colors(2,:),'LineWidth',2)
    end
    set(gca,'fontsize',22)
    ylim([0,0.5])
    xlim([0.3,1]);
    
    xlabel("Scale factor, c",'Interpreter','latex','fontsize',26);
    if fig_idx ==1
        ylabel({'RMSE / Percentiles'},'Interpreter','latex','fontsize',26)
    else
        yticklabels({});
    end
    title(strcat("$T = ", num2str(T),'$ (ms)'),'Interpreter','latex');
    yticks([0, 0.25, 0.5])
    xticks([0.3, 0.65, 1])
end