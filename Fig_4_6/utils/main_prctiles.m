function [] = main_prctiles(n_samples, D, N, width, loc, lambda1, c, L, background_activity, T, mu, s_fixed, n_starting_points, stimuli)
    MSE = zeros(D,length(c));

    sq_errs = zeros(D,n_samples,length(c));
    s_est = zeros(D,n_samples,length(c));
    for i =1:length(c)  
        lambda1
        c
        L
        
        lambda = (lambda1*c(i).^(0:(L-1)));

        % Simulations defined using relative spatial frequencies xi=(1/lambda)
        xi = 1./lambda;

        amps = get_amp_adj(D, N, loc, xi, width, mu, 'individual');
        
        b = T*background_activity;
        
        rates = T*amps;
        
        [f, ~, ~, ~] = create_TCs(N, loc, xi, rates, width, b);
        
        %Stimulus related part of the likelihood funtion
        log_likelihood = @(f, r) sum(r.*log(f) - (f));
        %Get MSE for the specific choice of decoding time
        [MSE(:,i), ~, sq_errs(:,:,i), s_est(:,:,i)] = get_MSE_prctiles(n_samples, N, D, f, log_likelihood, s_fixed, n_starting_points, stimuli);

        save(strcat('./Results/fixed_T/D_', num2str(D), '_b_', num2str(background_activity),'_xi_',num2str(xi(1)),'_T_',num2str(T*1000),'_L_',num2str(L)))
    end
end