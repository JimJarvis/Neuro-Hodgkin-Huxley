function [ noise ] = wgn( t, power )
% Band-limited white noise of power = sigma^2

dt = t(2) - t(1);

Fs = 1/ dt;

noise = randn(size(t)) * sqrt(power);

fc = 1e3; % set cutoff
fc_norm = 2 * fc / Fs; 
num = fir1(40, fc_norm);
noise = filter(num, 1, noise);

end

