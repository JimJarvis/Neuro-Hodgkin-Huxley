function [ I ] = current1(a_m, t)
%% Calculates the external current in problem 1

% predefined resistance
omega = 2 * pi * 50;

% 1/M * (-M : M)
M = -1 : 1/5 : 1;

% I is the sum of the fourier series
% sum over the row dimension of a rank-one matrix 
I = a_m * sum(exp(1j * omega * M' * t));

end

