function [] = main(n_samples, D, N, width, lambda1, c, L, loc, b, T, mu, s_FI, s_fixed, n_starting_points, stimuli)
    MSE = zeros(D,length(c));
    amps = zeros(N,length(c));
    approx_FI = zeros(1,length(c));
    est_FI = zeros(D,D,length(c));
    sq_errs = zeros(D,n_samples,length(c));
    s_est = zeros(D,n_samples,length(c));
    for i =1:length(c)  
        lambda = (lambda1*c(i).^(0:(L-1)));

        % Simulations defined using relative spatial frequencies xi=(1/lambda)
        xi = 1./lambda;

        %start searching for the minimal decoding time for the specific
        %population (lambda1, c)
        [MSE(:,i), r, amps(:,i), approx_FI(:,i), est_FI(:,:,i), sq_errs(:,:,i), s_est(:,:,i)] = find_Tth(n_samples, D, mu, T, loc, width, xi, b, N, s_fixed, n_starting_points, s_FI, stimuli);

        save(strcat('./Results/D_', num2str(D), '_b_', num2str(b),'_xi_',num2str(xi(1)),'_T_',num2str(T*1000),'_L_',num2str(L)))
    end
end