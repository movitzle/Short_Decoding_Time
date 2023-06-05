function [MSE, r, amps, approx_FI, est_FI, sq_errs, s_est] = find_Tth(n_samples, D, mu, T_vec, loc, width, xi, background_activity, N, s_fixed, n_starting_points, s_FI, stimuli)
    
    MSE = zeros(D,length(T_vec));
    sq_errs = zeros(D,n_samples,length(T_vec));
    s_est = zeros(D,n_samples,length(T_vec)); 
    r = zeros(n_samples, N, length(T_vec));
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

        xi
        
        rates = T*amps;
        
        [f, ~, ~, ~] = create_TCs(N, loc, xi, rates, width, b);
        
        %Stimulus related part of the likelihood funtion
        log_likelihood = @(f, r) sum(r.*log(f) - (f));

        [MSE(:,j), r(:,:,j), sq_errs(:,:,j), s_est(:,:,j)] = get_MSE(n_samples, N, D, f, log_likelihood, s_fixed, n_starting_points, stimuli);
        
    end
end