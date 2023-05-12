function [MSE_ML, r, sq_errs_lst, s_est, s_true, bias] = get_MSE(N, D, f, log_likelihood, s_fixed, n_starting_points)

    limit = 15000; % Number of random stimulus conditions used to evaluate MSE
    
    r = zeros(limit, N);
    s_est = zeros(D, limit);
    s_true = zeros(D, limit);
    sq_errs_lst = zeros(D, limit);
    bias = zeros(D, limit);
    parfor i=1:limit
        [sq_errs_lst(:,i), r(i,:), s_true(:,i), s_est(:, i), bias(:, i)] = f_ML_decode_N_D_FAST_poiss(D, f, log_likelihood, s_fixed, n_starting_points);
    end
    MSE_ML = mean(sq_errs_lst,2);

end

function [sq_errs, r, s_true, s_ML, bias] = f_ML_decode_N_D_FAST_poiss(D, f, log_likelihood, stim_fixed, n_starting_points)
        options = optimset('Display','off');
        
        s_true = rand(D,1);
        r = poissrnd(f(s_true));
        
        n_stim_fixed = size(stim_fixed,2);
         
        %check the LLs for the stim cond.
        L_init = zeros(1,n_stim_fixed);
        for i=1:n_stim_fixed
            s = stim_fixed(:,i);
            L_init(i) = log_likelihood(f(s),r);
        end
        
        %take the 4  stim. cond. with highest LL.
        [max_L_init, idx] = maxk(L_init,n_starting_points); 
        
        stim_fixed_temp = [s_true, stim_fixed(:,idx)];

        %find local minima with selected initial starting locations
        
        %check all local minimas and extract the stimulus condition with
        %largest LL (-> smallest negative LL)
        
        s_ML = s_true; % initialization, but set the -log_likelihood to + infinity
        current_min = inf;
        for i=1:1:size(stim_fixed_temp,2)
            s_init = stim_fixed_temp(:,i);
            [s_opt, min_val] = fminsearch(@(s) -log_likelihood(f(s),r), s_init, options); % find local minima
            if min_val < current_min % if local minima have a better log_likelihood -> change s_ML
                current_min = min_val;
                s_ML = s_opt;
            end
        end
        
        s_ML = mod(s_ML,1); % shift estimates into the [0,1)^D domain
        
        % find the square errors
        sq_errs = min(min((s_true-s_ML).^2,(s_true - s_ML + 1).^2),(s_true - s_ML - 1).^2);
        
        for i=1:D
            s_x = s_true(i);
            while s_ML(i) - s_x > 1/2
                s_ML(i) = s_ML(i) - 1;
            end
            while s_ML(i) - s_x < - 1/2
                s_ML(i) = s_ML(i) + 1;
            end
        end
        bias = s_ML - s_true;

end