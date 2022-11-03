function [MSE, r_cell, T, amps, approx_FI, est_FI, sq_errs_cell, s_est_cell, s_true_cell] = find_Tth(D, mu, T_vec, loc, width, xi, background_activity, N, s_fixed, n_starting_points, s_FI)
    
    MSE = zeros(D,length(T_vec));
    % Find amplitudes such that the average (stimulus-related) firing rate 
    % across the population is given by mu. Options:
    % 'individual' - all neurons have the same average firing rate mu/N.
    % 'population' - all neurons have the same maximal amplitude and the
    % population have the average firing rate mu.
    amps = get_amp_adj(D, N, loc, xi, width, mu, 'individual');
    % Create tuning curves according to Eq. 1
    [f,q, q_i,grad_q_i] = create_TCs(N, loc, xi, amps, width, background_activity);
    % Estimate fisher information based on 10'000 samples
    est_FI = estimate_fisher(D, f, q, q_i, grad_q_i, amps, s_FI);
    
    % Check approximation of Fisher information in Eq (3)
    % Note the inclusion of amplitureds in the mean().
    % See main text for motivation of this choice
    n_subgroups = max(size(xi));
    n_sub_pop_points = N/n_subgroups;
    xi_vec = repmat(xi, 1, n_sub_pop_points);
    approx_FI = (2*pi)^2*N/width*exp(-D/width)*besseli(0,1/width)^(D-1)*besseli(1,1/width)*mean(amps.*xi_vec.^2);  
    
    for j=1:length(T_vec)
        
        T = T_vec(j)
 
        b = T*background_activity;
        
        rates = T*amps;
        
        % This is a bit unnecessary to redefine the population every time
        % step
        [f, ~, ~, ~] = create_TCs(N, loc, xi, rates, width, b);
        
        %Stimulus related part of the likelihood funtion
        log_likelihood = @(f, r) sum(r.*log(f) - (f));
        %Get MSE for the specific choice of decoding time
        [MSE(:,j), r, sq_errs, s_est, s_true] = get_MSE(N, D, f, log_likelihood, s_fixed, n_starting_points);
        % Compare to the lower bound predicted by Fisher information
        if mean(MSE(:,j)) < 2*mean(diag(inv(T*est_FI)))
            break; % If average MSE is within the range - exit and save T as decoding time.
        end
    end
    r_cell = r;
    sq_errs_cell = sq_errs;
    s_est_cell = s_est;
    s_true_cell = s_true;
    MSE = MSE(:,1:j);
end