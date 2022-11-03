function [MSE_ML, r, sq_errs_lst, s_est, s_true] = get_MSE(N, D, f, log_likelihood, s_fixed, n_starting_points)
    
    max_n_trial = 10^5;
    old_MSE = zeros(D,1);
    old_mean_MSE_ML = 0;
    stable_counter = 0;
    % simulate until MSE stable for limit number of stimulus trials
    limit = 1000; 
    
    % counter to keep track of trial index with batch of trials
    counter = 0;
    batch_size = 4000;  % number of trials per batch
    
    r = zeros(max_n_trial, N);
    s_est = zeros(D, max_n_trial);
    s_true = zeros(D, max_n_trial);
    sq_errs_lst = zeros(D, max_n_trial);
    
    while stable_counter < limit &&  batch_size*counter < max_n_trial
        % To speed up calculations, use parallel computing of stimulus trials 
        numOutputs = 4;
        for idx = 1:batch_size
          par_work(idx) = parfeval(@decoder, numOutputs, D, f, log_likelihood, s_fixed, n_starting_points);
        end
        % catch the next completed worker
        for idx = 1:batch_size
            idx_long = idx + counter*batch_size;
            
            [~, sq_errs, r(idx_long,:), s_true(:,idx_long), s_est(:, idx_long)] = fetchNext(par_work);
            
            sq_errs_lst(:,idx_long) = sq_errs;           
            %Calculate MSE in each stimulus dimension, then take average
            %across dimensions
            MSE_ML = (sq_errs + old_MSE*(idx-1 + counter*batch_size))/(idx_long);
            mean_MSE_ML = mean(MSE_ML);
            
            %get the first 2 significant decimal points (only the location 
            %of them)
            d = get_first_decimal(mean_MSE_ML) + 1; 
            
            %check if the first 2 significant decimals of the MSE haven't 
            %changed 
            if floor(10^d*mean_MSE_ML) == floor(10^d*old_mean_MSE_ML)
                    stable_counter = stable_counter + 1;
            else
                    stable_counter = 0;
            end
            if stable_counter == limit
            % We're done, and can break out of the loop now
                break;
            end
            old_MSE = MSE_ML;
            old_mean_MSE_ML = mean_MSE_ML;
        end
        
        counter = counter + 1;
    end
    clear par_work
    %reduce the vectors to correct size
    r = r(1:idx_long,:);
    s_est = s_est(:, 1:idx_long);
    s_true = s_true(:, 1:idx_long);
    sq_errs_lst = sq_errs_lst(:, 1:idx_long);
end

function [sq_errs, r, s_true, s_ML] = decoder(D, f, log_likelihood, stim_fixed, n_starting_points)
        options = optimset('Display','off');
        
        s_true = rand(D,1); % sample a random stimulus condition
        r = poissrnd(f(s_true));    % sample a random response to the stim
        
        %get number of fixed stimulus conditions to check the log
        %likelihood (LL)
        n_stim_fixed = size(stim_fixed,2);
         
        %check the LLs for the stim cond. in stim fixed
        L_init = arrayfun(@(s_idx) log_likelihood(f(stim_fixed(:,s_idx)),r),1:n_stim_fixed);
        
        %take the 4  stim. cond. with highest LL.
        [max_L_init, idx] = maxk(L_init,n_starting_points); 
        
        %Add the true stim. cond. to not overestimate catastrophic errors
        stim_fixed_temp = [s_true, stim_fixed(:,idx)];

        %find local minima with selected initial starting locations

        L_1 = arrayfun(@(s_idx) fminsearch(@(s) -log_likelihood(f(s),r), stim_fixed_temp(:,s_idx),options), 1:size(stim_fixed_temp,2),'UniformOutput',false);
        L_1 = cell2mat(L_1);
        %check all local minimas and extract the stimulus condition with
        %largest LL
        [max_log_likelihood, arg_ML] = max(arrayfun(@(s_idx) log_likelihood(f(L_1(:,s_idx)),r), 1:n_starting_points));

        %get ML-estimate    
        s_ML = mod(L_1(:,arg_ML),1);
        %Because stimulus is circular, check 3 conditions to find the
        %minimal distance between s_ML and s_true
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

%Get the two first non-zero decimals of the MSE
function [d] = get_first_decimal(MSE)
    d = 0;
    while MSE*10^d < 1
        d = d + 1;
    end
end
