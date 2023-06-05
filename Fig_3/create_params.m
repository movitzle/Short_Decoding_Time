clear all
addpath('utils')

% Tuning curve / populations parameters
width = 0.3;
amps = 20;
L = 2;
M = 300;
N = M*L;
T_vec = (1:1:400)./1000;
Dmax = 1;

n_stim = 10000;
s_FI = rand(Dmax,n_stim); %Stimulus conditions to decode
%Parameter for ML-estimation
n_x_fixed = 100; %number of fixed stimulus points used in initial 
                 %search for optimal likelihood.
% Get a random sample of stimulus conditions used in initial search
s_fixed = get_intial_stim(Dmax, ceil(10000^(1/Dmax)), n_x_fixed, 0, 1)';
n_starting_points = 4;  %no. of local minima to select from first search -> these local minima will be used for convex optimization

loc = rand(Dmax,N);

save './utils/params.mat'