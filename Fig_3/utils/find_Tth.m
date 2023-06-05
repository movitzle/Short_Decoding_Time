function [MSE, r_cell, T, amps, approx_FI, est_FI, sq_errs_cell, s_est_cell, s_true_cell] = find_Tth(alpha, D, mu, T_vec, loc, width, xi, background_activity, N, s_fixed, n_starting_points, s_FI)
    
    MSE = zeros(D,length(T_vec));    
    amps = get_amp_adj(D, N, loc, xi, width, mu, 'individual');
    [f,q, q_i,grad_q_i] = create_TCs(N, loc, xi, amps, width, background_activity);
    % Estimate fisher information based on 10'000 samples
    est_FI = estimate_fisher(D, f, q, q_i, grad_q_i, amps, s_FI);
    
    n_subgroups = max(size(xi));
    n_sub_pop_points = N/n_subgroups;
    xi_vec = repmat(xi, 1, n_sub_pop_points);
    
    approx_FI = (2*pi)^2*N/width*exp(-D/width)*besseli(0,1/width)^(D-1)*besseli(1,1/width)*mean(amps.*xi_vec.^2);
        
    for j=1:length(T_vec)
        
        T = T_vec(j)
        b = T*background_activity;

        lambda = 1./xi
        
        rates = T*amps;
        % Not the most efficient to redefine the tuning curves every time
        % step
        [f, ~, ~, ~] = create_TCs(N, loc, xi, rates, width, b);
        
        %Stimulus related part of the likelihood funtion
        log_likelihood = @(f, r) sum(r.*log(f) - (f));

        [MSE(:,j), r, sq_errs, s_est, s_true] = get_MSE(N, D, f, log_likelihood, s_fixed, n_starting_points);
        
        if mean(MSE(:,j)) < alpha*mean(diag(inv(T*est_FI)))
            break;
        end
    end
    r_cell = r;
    sq_errs_cell = sq_errs;
    s_est_cell = s_est;
    s_true_cell = s_true;
    MSE = MSE(:,1:j);
end