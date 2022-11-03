function [T_th] = main(D, N, width, lambda0, c, L, b, T_vec, mu, s_FI, s_fixed, n_starting_points)

% Hard coded vectors to save results.
    MSE = cell(1,length(c));%zeros(length(c), D, length(T_vec));
    
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
        loc = create_locations(D,N,xi);
        %load 'rand_loc.mat';
        [MSE{i}, r{i}, T_th(i), amps(:,i), approx_FI(1,i), est_FI(:,:,i), sq_errs{i}, s_est{i}, s_true{i}] = find_Tth(D, mu, T_vec, loc, width, xi, b, N, s_fixed, n_starting_points, s_FI);

        % uncomment if you want intermediate savings of the workspace
        %save(strcat('.\Results\workspace_D_', num2str(D), '_b_', num2str(b),'_xi_naugth_',num2str(xi(1)),'_L_',num2str(L),'_c_',num2str(c(i)*100)))
  
    end
    % save the workspace
    save(strcat('.\Results\workspace_D_', num2str(D), '_b_', num2str(b),'_xi_',num2str(xi(1)),'_L_',num2str(L)))
end