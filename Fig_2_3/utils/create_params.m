clear all
addpath('utils')

width = 0.3;
L = 5;
M = 120;
N = M*L;
T_vec = (1:1:300)./1000;
amps = 20;
Dmax = 2;
c = [1:-0.05:0.55, 0.45:-0.05:0.3];
n_stim = 10000;
s_FI = rand(Dmax,n_stim); %Stimulus conditions to decode
n_x_fixed = 100; %number of fixed stimulus points used in initial 
                 %search for optimal likelihood.
% Get a random sample of stimulus conditions used in initial search
s_fixed = get_intial_stim(Dmax, ceil(10000^(1/Dmax)), n_x_fixed, 0, 1)';
n_starting_points = 4;

loc = rand(Dmax,N);

save 'params.mat'