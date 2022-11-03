clear all
addpath('utils')

load 'params.mat'


lambda1 = 1;

for D=1:Dmax
    mu = N*amps*besseli(0,1/width)^D*exp(-D/width); %Stimulus-related firing rate
   
    b = 2;
    main(D, N, width, loc(1:D,:), lambda1, c, L, b, T_vec, mu, s_FI(1:D,:), s_fixed(1:D,:), n_starting_points)
end


lambda1 = 1/2;
%all stimulus unambiguous choices of c in range 0.95 to 0.3 in 0.05
%increments

for D=1:Dmax
    mu = N*amps*besseli(0,1/width)^D*exp(-D/width); %Stimulus-related firing rate

    b = 2;
    main(D, N, width, loc(1:D,:), lambda1, c(2:end), L, b, T_vec, mu, s_FI(1:D,:), s_fixed(1:D,:), n_starting_points)
end
