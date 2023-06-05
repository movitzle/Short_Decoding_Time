clear all
addpath('utils')
mkdir Results
load 'params.mat'

lambda0 = 1;
T_vec = [1]/1000;
c = [1:-0.05:0.05];
n_samples = size(stimuli,2);
L = 2;
for D=1:1
    mu = N*amps*besseli(0,1/width)^D*exp(-D/width);
    b = 0;
    for T=T_vec
        main(n_samples, D, N, width, lambda0, c, L, loc, b, T, mu, s_FI(1:D,:), s_fixed(1:D,:), n_starting_points, stimuli(1:D,:));
            
    end
end


lambda0 = 1/2;
%all stimulus umbigious choices of c in range 0.95 to 0.1 in 0.05
%increments
c = [0.95:-0.05:0.55, 0.45:-0.05:0.3,0.15];
for D=1:1
    mu = N*amps*besseli(0,1/width)^D*exp(-D/width);
    b = 0;
    for T=T_vec
        main(n_samples, D, N, width, lambda0, c, L, loc, b, T, mu, s_FI(1:D,:), s_fixed(1:D,:), n_starting_points, stimuli(1:D,:));
    end
end