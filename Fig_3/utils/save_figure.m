function [] = save_figure(save_to, name, gcf)
    % save figure
    %save_to = './Results/';
    %name = 'Fig3a';
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
