function [y] = get_intial_stim(D, n_per_dim, n_initial_stims, stim_start, stim_stop)
    stim_checks = linspace(stim_start,stim_stop,n_per_dim+1);
    stim_checks = stim_checks(1:end-1);
    
    [stim_grid{1:D}] = ndgrid(stim_checks);
    
    stim_fixed = zeros(D,n_per_dim^D);
    
    for i=1:D
        stim_fixed(i,:) = reshape(stim_grid{:,i},1,n_per_dim^D);
    end
    
    y = datasample(stim_fixed',n_initial_stims,'Replace',false);
end
