function [R_sq, coefficients] = fitData(predictive, T_th, b, c, colors, color_idx, plot_prediction, y_lim)
    switch nargin
        case 8
            y_ticks = [0,50,100,150,200];
            font_size = 18;
        case 7
            y_lim = 140;
            y_ticks = [0,20,40,60,80,100,120,140];
            font_size = 16;
        otherwise
            error('Not enough/ Too many input parameters');
    end
    
    coefficients = polyfit(predictive, T_th, 1); % Find the coefficients K_1 and K_2 in equation (47)
    
    if b==0
        mark = 'o';
    else
        mark = 'd';
    end
    
    plot(c,T_th*1000,'--','LineWidth',1.5,'Color',colors(color_idx,:),'Marker',mark)
    if plot_prediction == 1
        plot(c,(coefficients(1)*predictive + coefficients(2))*1000,'k','LineWidth',1.5)
    end
    xlabel('Scale factor, c','Interpreter','latex','FontSize', font_size)
    ylabel('Minimal decoding time, $T_{th}$ (ms)','Interpreter','latex','FontSize', font_size)
    yticks(y_ticks)
    
    ylim([0, y_lim])
    xlim([0.3,1])
    SS_tot = sum((T_th - mean(T_th)).^2); %total variation of data
    
    SS_res = sum((T_th - (coefficients(1)*predictive + coefficients(2))).^2); %variation explained by approximation

    R_sq = 1- SS_res/SS_tot;
end