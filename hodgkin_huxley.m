%HODGKIN_HUXLEY Hodgkin-Huxley neuron model.
%   V = HODGKIN_HUXLEY(T,I_EXT) simulates the membrane voltage V of
%   the Hodgkin-Huxley neuron model in response to an external current
%   I_EXT over time T. The lengths of T and I_EXT must be the same.
%
%   units: T(seconds), I_EXT(nA), V(mV)

function [V, I_K, I_Na, CdV_dt, X] = hodgkin_huxley(t, I_ext)

% Assume that the time is given in seconds, and convert it to
% number of milliseconds:
t = 1000*t;
dt = diff(t(1:2));

% Reverse potentials for K, Na, R (mV):
E = [   -12 115 10.613];
% Initial states [n, m, h]
x = [   0   0   1.0];

% Initialize membrane voltage:
V  = zeros(1,length(t)); 
V(1) = -10;

% Alpha and beta variables:
a = zeros(1,3);
b = zeros(1,3);

% Channel conductances (mmho/cm^2) [mho -> ohm^{-1}]
g_K = 36; g_Na = 120; g_R = 0.3;

% Channel activations:
gnmh = zeros(1,3);
gnmh(3) = g_R; %constant no need to be in a loop

% Record individual current over time
% Potassium
I_K = [0];
% Sodium
I_Na = [0];
% Capacitive current
CdV_dt = [0];
% Record internal states
X(1, :) = x;

% Perform numerical integration of the ODEs:
for i=2:length(t),
    a(1) = (10-V(i-1))/(100*(exp((10-V(i-1))/10)-1));
    a(2) = (25-V(i-1))/(10*(exp((25-V(i-1))/10)-1));
    a(3) = 0.07*exp(-V(i-1)/20);
    
    b(1) = 0.125*exp(-V(i-1)/80);
    b(2) = 4*exp(-V(i-1)/18);
    b(3) = 1/(exp((30-V(i-1))/10)+1);
    
    x = x + dt*(a.*(1-x) - b.*x);
    X(i, :) = x;
    
    gnmh(1) = g_K*x(1)^4;
    gnmh(2) = g_Na*x(2)^3*x(3);

    % Update the ionic currents and membrane voltage:
    I = (gnmh.*(V(i-1)-E));  % nA

    % add to individual records
    I_K(i) = I(1);
    I_Na(i) = I(2);
    CdV_dt(i) = I_ext(i) - sum(I);

    V(i) = V(i-1) + dt*(I_ext(i)-sum(I));
end
