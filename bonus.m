%% bonus script

%% Part A
disp('======= Bonus =======')
disp('part 0')

% a_m set to 10
% initialize t
a_m = 10;
t = -0.05:1e-5:0.2;
I_ext = current2(a_m, t);

[V, ~, I_Na, ~, X_stable] = hodgkin_huxley(t, I_ext);
figure()
subplot(311); 
genplot('External input current', ...
  t, I_ext, 'I_{ext} (nA)');

subplot(312); 
genplot('Hodgkin-Huxley voltage', ...
  t, V, 'V (mV)'); 

subplot(313); 
genplot('Sodium current', ...
  t, 't (s)', I_Na, 'I_{Na} (nA)');

print('bonus_0.png', '-dpng')

%% =========================
disp('part 1')

[V, I_Na, x_Na, g_Na] = HH_Na(t, I_Na, X_stable);
figure()
subplot(511); 
genplot('Input current I_Na', ...
  t, I_Na, 'I_{Na} (nA)');

subplot(512); 
genplot('Sodium Hodgkin-Huxley voltage', ...
  t, V, 'V (mV)'); 

subplot(513); 
genplot('Sodium current', ...
  t, I_Na, 'I_{Na} (nA)'); 

subplot(514); 
genplot('Sodium internal state', ...
  t, x_Na, 'x_{Na}'); 

subplot(515); 
genplot('Sodium memconductance', ...
  t, 't (s)', g_Na, 'g_{Na}'); 

print('bonus_1.png', '-dpng')

%% =========================
disp('part 2')

figure()
subplot(211); 
genplot('Memconductance VS Voltage', ...
  V, 'V (mV)', g_Na, 'g_{Na}');

subplot(212); 
% flux is the cumulative integral of voltage
flux = cumtrapz(t, V);
genplot('Memconductance VS Flux', ...
  flux, '\Phi_{Na}', g_Na, 'g_{Na}');

print('bonus_2.png', '-dpng')

%% =========================
disp('part 3')

figure()
subplot(211); 
genplot('Voltage VS Current', ...
  I_Na, 'I_{Na} (nA)', V, 'V');

subplot(212); 
% flux is the cumulative integral of current
charge = cumtrapz(t, I_Na);
genplot('Flux VS Charge', ...
  charge, 'Q (nC)', flux, '\Phi_{Na}');

print('bonus_3.png', '-dpng')
