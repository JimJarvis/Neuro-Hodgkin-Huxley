function [ I ] = current2(a_m, t)
%% Calculates the external current in problem 2

% sinc(t) = sin(pi * t) / (pi * t)
% predefined resistance
omega = 2 * 20;
T = 1/ omega;

kT = (0:15) * T;

% calculate t - k*T with vectorization
t_kT = repmat(t, numel(kT), 1) - repmat(kT', 1, numel(t));

% I is the sum of the fourier series
% sum over the row dimension of a rank-one matrix 
I = a_m * sum(sinc(omega * t_kT));

end

