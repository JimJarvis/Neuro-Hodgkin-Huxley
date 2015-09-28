%HODGKIN_HUXLEY Hodgkin-Huxley neuron model for potassium only
%   V = HODGKIN_HUXLEY(T,I_EXT) simulates the membrane voltage V of
%   the Hodgkin-Huxley neuron model in response to an external current
%   I_EXT over time T. The lengths of T and I_EXT must be the same.
%
%   units: T(seconds), I_EXT(nA), V(mV)

function [V, I_K, x_K, g_K] = HH_K(t, I_ext)

% Assume that the time is given in seconds, and convert it to
% number of milliseconds:
t = 1000*t;
dt = diff(t(1:2));

% Reverse potentials for K (mV):
E = -12;

% Initialize membrane voltage:
V  = zeros(1,length(t)); 
V(1) = -10;

% Alpha and beta variables:
a = 0;
b = 0;

% Channel conductances (mmho/cm^2) [mho -> ohm^{-1}]
gmax_K = 36; % gmax_Na = 120; g_R = 0.3;

% Channel activations:
g_K = [0];

% internal state
x_K = [0];

% Record individual current over time
% Potassium
I_K = [0];

% Perform numerical integration of the ODEs:
for i=2:length(t),
    a = (10-V(i-1))/(100*(exp((10-V(i-1))/10)-1));
    
    b = 0.125*exp(-V(i-1)/80);
    
    x_prev = x_K(i-1);
    x_K(i) = x_prev + dt*(a * (1 - x_prev) - b * x_prev);
    
    g_K(i) = gmax_K * x_K(i)^4;

    % Update the ionic currents and membrane voltage:

    I_K(i) = g_K(i) * (V(i-1) - E);
    V(i) = I_ext(i) / g_K(i) + E;
    % V(i) = V(i-1) + dt*(I_ext(i)-I_K(i));
end
