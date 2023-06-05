function [T_th] = main(alpha, D, N, width, lambda0, c, L, loc, b, T_vec, mu, s_FI, s_fixed, n_starting_points)
    save_base = strcat('./Results/alpha_', num2str(alpha));
    mkdir(save_base);    
    % Hard coded vectors to save results.
    MSE = cell(1,length(c));
    
    T_th = zeros(1,length(c));
    amps = zeros(N,length(c));
    approx_FI = zeros(1, length(c));
    est_FI = zeros(D,D,length(c));
    r = cell(1, length(c));
    s_true = cell(1, length(c));
    sq_errs = cell(1, length(c));
    s_est = cell(1, length(c));
    %% For each choice of baseline compute the Fisher information and decode for all time instances in T_vec.
    
    for i=1:length(c)     
        if lambda0 == 1
            if c(i)==1
                lambda = lambda0;
            else
                lambda = (lambda0*c(i).^(0:(L-1)));
            end
        else
            lambda = (lambda0*c(i).^(0:(L-1)));
        end
        
        xi = 1./lambda;
        [MSE{i}, r{i}, T_th(i), amps(:,i), approx_FI(1,i), est_FI(:,:,i), sq_errs{i}, s_est{i}, s_true{i}] = find_Tth(alpha, D, mu, T_vec, loc, width, xi, b, N, s_fixed, n_starting_points, s_FI);

        % uncomment if you want intermediate savings of the workspace
        %save(strcat(save_base,'workspace_D_', num2str(D), '_b_', num2str(b),'_xi_',num2str(xi(1)),'_L_',num2str(L)), 'c', 'MSE', 'T_th', 'amps', 'approx_FI', 'est_FI','sq_errs','s_est','s_true')
        %save(strcat(save_base,'save_responses_D_', num2str(D), '_b_', num2str(b),'_xi_',num2str(xi(1)),'_L_',num2str(L)), 'r')
    end
    % save the workspace
    save(strcat(save_base,'workspace_D_', num2str(D), '_b_', num2str(b),'_xi_',num2str(xi(1)),'_L_',num2str(L)), 'c', 'MSE', 'T_th', 'amps', 'approx_FI', 'est_FI','sq_errs','s_est','s_true')
    save(strcat(save_base,'save_responses_D_', num2str(D), '_b_', num2str(b),'_xi_',num2str(xi(1)),'_L_',num2str(L)), 'r')
    
end