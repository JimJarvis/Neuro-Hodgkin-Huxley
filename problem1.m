%% Problem 1 script

%% Part A
disp('======= Problem 1 =======')
disp('part 1')

% a_m set to 3
% initialize t
a_m = 3;
t = -0.05:1e-5:0.2;
I_ext = real(current1(a_m, t));

V = hodgkin_huxley(t, I_ext);
figure()
subplot(211); 
genplot('External stimulus current', ...
  t, I_ext, 'I_{ext} (nA)');

subplot(212); 
[~, spikes] = find_spikes(V);
plot(t, V, 'b-', t(spikes), V(spikes), 'r*'); 
setaxis(t, V);
title('Hodgkin-Huxley voltage with spikes');
xlabel('t (s)');
ylabel('Voltage (mV)');
print('1_1.png', '-dpng')

%% =========================
disp('part 2')
% generate a_m 
am_range = .1:.1:4;
num_spikes = [];

for am = am_range
  V = hodgkin_huxley(t, current1(am, t));
  V = V(t >= 0);
  num_spikes(end + 1) = find_spikes(V);
end

figure()
subplot(211);
plot(am_range, num_spikes);
setaxis(am_range, num_spikes);
title('a_{m} VS total spikes');
ylabel('Total spikes');

subplot(212);
avg_spikes = num_spikes / .2;
plot(am_range, avg_spikes);
setaxis(am_range, avg_spikes);
title('a_{m} VS average spikes/s');
xlabel('a_{m}');
ylabel('Average spikes/s');

print('1_2.png', '-dpng')

%% =========================
disp('part 3')
figure()
I_ext = real(current1(0.3, t)) + wgn(t, 1);

V = hodgkin_huxley(t, I_ext);
figure()
subplot(211); 
genplot({'Input current with noise $$\sigma^2 = 1$$', 1}, ...
  t, I_ext, 'I_{ext} (nA)');

subplot(212); 
[~, spikes] = find_spikes(V);
plot(t, V, 'b-', t(spikes), V(spikes), 'r*'); 
setaxis(t, V);
title('Hodgkin-Huxley voltage with spikes');
xlabel('t (s)');
ylabel('Voltage (mV)');
print('1_3a.png', '-dpng')

% experiment with noise powers
row = 1;
power_range = 5:5:20;
am_range = am_range(1:10);
num_spikes = zeros(numel(am_range), numel(power_range));
for am = am_range
  col = 1;
  for power = power_range
    V = hodgkin_huxley(t, wgn(t, power) + real(current1(am, t)));
    V = V(t >= 0);
    num_spikes(row, col) = find_spikes(V);
    col = col + 1;
  end
  row = row + 1;
end
figure()
% divided by .2 s to get frequency: spikes per second
surf(power_range, am_range, num_spikes / .2);
xlabel('Noise power $$\sigma^2$$', 'interpreter', 'latex')
ylabel('a_m')
zlabel('Firing frequency (spikes/s)')
