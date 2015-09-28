%% Problem 2 script

%% Part A
disp('======= Problem 2 =======')
disp('part 0')

% a_m set to 0.3
% initialize t
a_m = 10.0;
t = -0.05:1e-5:0.2;
I_ext = current2(a_m, t);

[V, I_K, I_Na, CdV_dt] = hodgkin_huxley(t, I_ext);
figure()
subplot(511); 
genplot('External input current', ...
  t, I_ext, 'I_{ext} (nA)');

subplot(512); 
genplot('Hodgkin-Huxley voltage', ...
  t, V, 'V (mV)'); 

subplot(513); 
genplot('Potassium current', ...
  t, I_K, 'I_K (nA)'); 

subplot(514); 
genplot('Sodium current', ...
  t, I_Na, 'I_{Na} (nA)');

subplot(515); 
genplot({'Capacitive current $$C \frac{dV}{dt}$$', 1, 0, 2}, ...
  t, 't (s)', CdV_dt, 'C \frac{dV}{dt}'); 

print('2_0.png', '-dpng')

%% =========================
disp('part 1')

[V, I_K, x_K, g_K] = HH_K(t, I_K);
figure()
subplot(511); 
genplot('Input current I_K', ...
  t, I_K, 'I_K (nA)');

subplot(512); 
genplot('Potassium Hodgkin-Huxley voltage', ...
  t, V, 'V (mV)'); 

subplot(513); 
genplot('Potassium current', ...
  t, I_K, 'I_K (nA)'); 

subplot(514); 
genplot('Potassium internal state', ...
  t, x_K, 'x_K'); 

subplot(515); 
genplot('Potassium memconductance', ...
  t, 't (s)', g_K, 'g_K'); 

print('2_1.png', '-dpng')

%% =========================
disp('part 2')

figure()
subplot(211); 
genplot('Memconductance VS Voltage', ...
  V, 'Voltage (mV)', g_K, 'g_K');

subplot(212); 
% flux is the cumulative integral of voltage
flux = cumtrapz(t, V);
genplot('Memconductance VS Flux', ...
  flux, '\Phi_K', g_K, 'g_K');

print('2_2.png', '-dpng')

%% =========================
disp('part 3')

figure()
subplot(211); 
genplot('Voltage VS Current', ...
  I_K, 'I_K (nA)', V, 'Voltage (mV)');

subplot(212); 
% flux is the cumulative integral of current
charge = cumtrapz(t, I_K);
genplot('Flux VS Charge', ...
  charge, 'Q (nC)', flux, '\Phi_K');

print('2_3.png', '-dpng')
