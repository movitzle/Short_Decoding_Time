clear all
addpath('utils')
% Tuning curve / populations parameters
width = 0.3;
amps = 20;
L = 2;
M = 300;
N = M*L;
T_vec = (1:1:300)./1000;
Dmax = 1;

n_stim = 10000;
s_FI = rand(Dmax,n_stim); %Stimulus conditions to decode
%Parameter for ML-estimation
n_x_fixed = 100; %number of fixed stimulus points used in initial 
                 %search for optimal likelihood.
% Get a random sample of stimulus conditions used in initial search
s_fixed = get_intial_stim(Dmax, ceil(10000^(1/Dmax)), n_x_fixed, 0, 1)';
n_starting_points = 4;  %no. of local minima to select from first search -> these local minima will be used for convex optimization

lambda0 = 1;
c = 1:-0.05:0.05;
for D=1:Dmax
    mu = N*amps*besseli(0,1/width)^D*exp(-D/width);
    b = 0;
    main(D, N, width, lambda0, c, L, b, T_vec, mu, s_FI(1:D,:), s_fixed(1:D,:), n_starting_points)
end


lambda0 = 1/2;
%all stimulus umbigious choices of c in range 0.95 to 0.1 in 0.05
%increments
c = [0.95:-0.05:0.55, 0.45:-0.05:0.3,0.15];
for D=1:Dmax
    mu = N*amps*besseli(0,1/width)^D*exp(-D/width);
    b = 0;
    main(D, N, width, lambda0, c, L, b, T_vec, mu, s_FI(1:D,:), s_fixed(1:D,:), n_starting_points)
end