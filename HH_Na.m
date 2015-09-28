%HODGKIN_HUXLEY Hodgkin-Huxley neuron model for sodium only
%   V = HODGKIN_HUXLEY(T,I_EXT) simulates the membrane voltage V of
%   the Hodgkin-Huxley neuron model in response to an external current
%   I_EXT over time T. The lengths of T and I_EXT must be the same.
%
%   units: T(seconds), I_EXT(nA), V(mV)

function [V, I_Na, x_Na, g_Na] = HH_K(t, I_ext, X_stable)
% X_stable: internal states from the joint model to stabilize this isolated model

% Assume that the time is given in seconds, and convert it to
% number of milliseconds:
t = 1000*t;
dt = diff(t(1:2));

% Reverse potentials for Na, R (mV):
E = [115 10.613];

% Initialize membrane voltage:
V  = zeros(1,length(t)); 
V(1) = -10;

% Alpha and beta variables:
% (m, h)
a = zeros(1, 2);
b = zeros(1, 2);

% Channel conductances (mmho/cm^2) [mho -> ohm^{-1}]
gmax_Na = 120;

% Channel activations:
g_Na = [0];

% internal state (m, h)
x = [0.0, 1.0];

% Record individual current over time
% Sodium, C*dV/dt
I = [0 0];

BAD_NUM = 0;
% Perform numerical integration of the ODEs:
for i=2:length(t),
    a(1) = (25-V(i-1))/(10*(exp((25-V(i-1))/10)-1));
    a(2) = 0.07*exp(-V(i-1)/20);
    
    b(1) = 4*exp(-V(i-1)/18);
    b(2) = 1/(exp((30-V(i-1))/10)+1);

    x_prev = x(i-1, :);
    x(i, :) = x_prev + dt*(a .* (1 - x_prev) - b .* x_prev);
    if any(x(i, :) > 1 | x(i, :) < 0)
      x(i, :) = X_stable(i, 2:3);
      BAD_NUM = BAD_NUM + 1;
    end
    
    g_Na(i) = gmax_Na * x(i, 1)^3 * x(i, 2);

    % Update the ionic currents and membrane voltage:
    % g_R is a constant = 0.3
    I(i, :) = [g_Na(i) 0.3] .* (V(i-1) - E);
    V(i) = V(i-1) + dt*(I_ext(i) - sum(I(i, :)));
end

disp('fking')
disp(BAD_NUM)

% Na current is the first column of I
I_Na = I(:, 1)';

% Na internal state is the first column of x
x_Na = x(:, 1)';

end
