% simulate results in Figure 4b-d

clear all
addpath('utils')
mkdir('Results')
load 'params.mat'


lambda1 = 1; % Largest spatial period
alpha = 1.2; % controls threshold sensitivity to classify MSE against CR-bound
for D=1:Dmax
    mu = N*amps*besseli(0,1/width)^D*exp(-D/width); % Average population firing rate
    b = 0; % spontaneous firing rate
    main(alpha, D, N, width, loc(1:D,:), lambda1, c, L, b, T_vec, mu, s_FI(1:D,:), s_fixed(1:D,:), n_starting_points)
end


lambda1 = 1/2; % Largest spatial period

for D=1:Dmax
    mu = N*amps*besseli(0,1/width)^D*exp(-D/width); % Average population firing rate
    b = 0; % spontaneous firing rate
    main(alpha, D, N, width, loc(1:D,:), lambda1, c(2:end), L, b, T_vec, mu, s_FI(1:D,:), s_fixed(1:D,:), n_starting_points)
end
