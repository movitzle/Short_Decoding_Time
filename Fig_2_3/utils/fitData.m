function [R_sq, coefficients] = fitData(predictive, T_th, c, colors, color_idx, plot_prediction)
    %[predictive_sort, idx] = sort(predictive);

    %coefficients = polyfit(predictive_sort, T_th(idx), 1);
    coefficients = polyfit(predictive, T_th, 1);
    
    plot(c,T_th*1000,'--o','LineWidth',1.5,'Color',colors(color_idx,:))
    if plot_prediction == 1
        %plot(c(idx),(coefficients(1)*predictive_sort + coefficients(2))*1000,'k','LineWidth',1.5)
        plot(c,(coefficients(1)*predictive + coefficients(2))*1000,'k','LineWidth',1.5)
    end
    xlabel('Scale factor, c','Interpreter','latex','FontSize', 15)
    ylabel('$T_{th}$ (ms)','Interpreter','latex','FontSize', 15)
    ylim([0, 140])
    xlim([0.3,1])
    SS_tot = sum((T_th - mean(T_th)).^2); %total variation of data

    %SS_res = sum((T_th(idx) - (coefficients(1)*predictive_sort + coefficients(2))).^2); %variation explained by approximation
    SS_res = sum((T_th - (coefficients(1)*predictive + coefficients(2))).^2); %variation explained by approximation

    R_sq = 1- SS_res/SS_tot;
end