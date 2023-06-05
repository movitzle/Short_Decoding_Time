clear all
addpath('utils')
mkdir Results
load 'params.mat'
T_vec = 0.001:0.005:0.1;
alpha = 2;
lambda0 = 1;
c = [1:-0.01:0.05];
for D=1:Dmax
    mu = N*amps*besseli(0,1/width)^D*exp(-D/width);
    b = 0;
    main(alpha, D, N, width, lambda0, c, L, loc, b, T_vec, mu, s_FI(1:D,:), s_fixed(1:D,:), n_starting_points);
end


lambda0 = 1/2;
%all stimulus umbigious choices of c in range 0.95 to 0.1 in 0.01
%increments
c = [0.95:-0.01:0.51, 0.49:-0.01:0.26,0.24:-0.01:0.21,0.19:-0.01:0.15,0.14:-0.01:0.11, 0.09:-0.01:0.06];
for D=1:Dmax
    mu = N*amps*besseli(0,1/width)^D*exp(-D/width);
    b = 0;
    main(alpha, D, N, width, lambda0, c, L, loc, b, T_vec, mu, s_FI(1:D,:), s_fixed(1:D,:), n_starting_points);
end