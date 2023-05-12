% Simulate results for Figure 4e-f and Figure 5

clear all
addpath('utils')
mkdir('Results/fixed_T/')
load 'params.mat'

n_samples = 15000;
stimuli = rand(2,n_samples); % fix stimulus conditions to compare error distribution
for D = [1,2]
    if D == 1
        T_vec = [5,15,30]/1000;
    elseif D == 2
        T_vec = [20,60,100]/1000;
    end
    mu = N*amps*besseli(0,1/width)^D*exp(-D/width);
    
        

    for T = T_vec
        lambda1 = 1;
        b = 0;
        main_prctiles(n_samples, D, N, width, loc(1:D,:), lambda1, c, L, b, T, mu, s_fixed(1:D,:), n_starting_points, stimuli(1:D,:))

        lambda1 = 1/2;
        main_prctiles(n_samples, D, N, width, loc(1:D,:), lambda1, c(2:end), L, b, T, mu, s_fixed(1:D,:), n_starting_points, stimuli(1:D,:))
    end
    
end