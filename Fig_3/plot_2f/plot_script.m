colors = [0.35    0.54    0.69;
    0.92    0.28    0.29;
    0.44    0.75    0.43;
    1.00    0.60    0.20];
    
c_vec = [0.4,0.6,0.8];
plt_pct = 99.8; % plot percentile of root-squared error distribution
load_base = '.\Results';

for D=[1]
    for b=[0]

        figure()
        set(gcf,'position',[400,200,1300*1.6,400])

        if D == 1
            T_vec = [10,50,100];
        elseif D == 2
            T_vec = [10,50,100];
        end
        for i = 1:length(T_vec)
            T = T_vec(i);
            xi_1 = strcat('\D_',num2str(D),'_b_',num2str(b),'_xi_1_T_',num2str(T),'_L_2.mat'); % lambda_1 = 1 data
            xi_2 = strcat('\D_',num2str(D),'_b_',num2str(b),'_xi_2_T_',num2str(T),'_L_2.mat'); % lambda_1 = 1/2 data
            % plot maxiamal errors (open circles)
            subplot_SQ_ERR(0,100,load_base, xi_1, xi_2, i, num2str(T), colors(2*(D-1)+1:2*(D-1)+2,:))
            % plot percentile given in plt_pct (closed circles)
            subplot_SQ_ERR(1, plt_pct,load_base, xi_1, xi_2, i, num2str(T), colors(2*(D-1)+1:2*(D-1)+2,:))
        end
        addpath('utils')
        name = strcat('Error_Distributions_D_',num2str(D),'_b_',num2str(b));
        save_figure('.\Results', name, gcf);
    end
end

function [] = subplot_SQ_ERR(plt_fill, plt_pct, load_base, xi_1, xi_2, fig_idx, T, colors)
    % plt_qt plot the following quantile
    subplot(1,3,fig_idx);
    hold on;
    SP = load(strcat(load_base, xi_1),'sq_errs','T_vec','MSE','est_FI','c');
    MP = load(strcat(load_base,xi_2),'sq_errs','T_vec','MSE','est_FI','c');
    
    
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
    xlim([0.05,1]);
    
    xlabel("Scale factor, c",'Interpreter','latex','fontsize',26);
    if fig_idx ==1
        ylabel({'RMSE / Percentiles'},'Interpreter','latex','fontsize',26)
    else
        yticklabels({});
    end
    title(strcat("$T = ", num2str(T),'$ (ms)'),'Interpreter','latex');
    yticks([0, 0.25, 0.5])
    xticks([0.2, 0.4, 0.6,0.8, 1])
    set(gca,'TickLabelInterpreter','latex')
end