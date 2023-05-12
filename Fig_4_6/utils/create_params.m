% Script to create parameters to use in the simulation of Figures 4-6 in 
%
% width = parameter controlling the tuning curve width
% L = Number of modules (subpopulations) with distinct spatial periods
% M = Number of neurons per module
% N = Total number of neurons in the population (N = L*M)
% T_vec = Array of decoding times to use for searching after T_th
% Dmax = The largest stimulus dimensionality used in the search
% amps = Controls the average firing rate of neurons. Note that for an
%   individual neuron, this parameter may not be the peak firing rate.
%   Instead, each neuron have a peak firing rate which makes all neurons have
%   the same average firing rate across stimulus dimenions (i.e., peak
%   amplitude can also depend on the spatial period of the tuning curves).
% c = different scale factors to check in the simulations of T_th
%   n_stim = number of stimulus conditions used to numerically calculate
%   Fisher information
% s_FI = Sampled stimulus conditions used to calculate Fisher information
% n_x_fixed = number of fixed stimulus points used in initial search for 
%   optimal log-likelihood
% s_fixed = sampled stimulus conditions used in intial search for optimal
%   log-likelihood
% n_starting_points = Given the log-likelihood values for a given response
%   r, this parameter controls how many of the top stimulus candidates from
%   s_fixed are used in the Nelder-Mead method to find s_ML.
% loc = sample preferred stimulus conditions for each (multi-dimensional)
%   tuning curve

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