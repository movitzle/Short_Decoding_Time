function [T_th] = main(alpha, D, N, width, loc, lambda1, c, L, b, T_vec, mu, s_FI, s_fixed, n_starting_points)
    % Save results to the following folder
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
    %% For each choice of scale factor, simulate the minimal decoding time Tth

    for i=1:length(c)
        
        % This is now redundant. Enough to have "lambda =
        % (lambda1*c(i).^(0:(L-1)));"
        if lambda1 == 1
            if c(i)==1
                lambda = lambda1;
            else
                lambda = (lambda1*c(i).^(0:(L-1)));
            end
        else
            lambda = (lambda1*c(i).^(0:(L-1)));
        end
        % Simulations defined using relative spatial frequencies xi=(1/lambda)
        xi = 1./lambda;
        
        %start searching for the minimal decoding time for the specific
        %population (lambda1, c)
        [MSE{i}, r{i}, T_th(i), amps(:,i), approx_FI(1,i), est_FI(:,:,i), sq_errs{i}, s_est{i}, s_true{i}] = find_Tth(alpha, D, mu, T_vec, loc, width, xi, b, N, s_fixed, n_starting_points, s_FI);
        
        save(strcat(save_base,'/workspace_D_', num2str(D), '_b_', num2str(b),'_xi_',num2str(xi(1)),'_L_',num2str(L)))
  
    end
end