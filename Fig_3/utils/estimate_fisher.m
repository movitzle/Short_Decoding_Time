function [mean_FI] = estimate_fisher(D, f, q, q_i, grad_q_i, amps, s_true)
    n_stim = length(s_true);
    fisher_mat_per_stim = zeros(D,D,n_stim);
    for j=1:n_stim
        s = s_true(:,j);
        for k=1:D
            for l=1:D
                if l==k
                    fisher_mat_per_stim(k,l,j) = sum(amps.^2.*grad_q_i(s,k).^2.*q(s).^2./(f(s).*q_i(s,k).^2), 'omitnan');
                else
                    fisher_mat_per_stim(k,l,j) = sum(amps.^2.*grad_q_i(s,k).*grad_q_i(s,l).*q(s).^2./(f(s).*q_i(s,k).*q_i(s,l)), 'omitnan');
                end
            end
        end
    end
    
    mean_fisher_mat = mean(fisher_mat_per_stim,3);
    mean_FI = mean_fisher_mat;
end