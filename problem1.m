%% Problem 1 script

%% Part A
disp('======= Problem 1 =======')
disp('part 1')

% a_m set to 0.3
% initialize t
a_m = 3.0;
t = -0.05:1e-5:0.2;
I_ext = real(current1(a_m, t));

V = hodgkin_huxley(t, I_ext);
figure()
subplot(211); 
plot(t, I_ext);
setaxis(t, I_ext);
ylabel('I_{ext}');
title('Input current');
subplot(212); 
[~, spikes] = find_spikes(V);
plot(t, V, 'b-', t(spikes), V(spikes), 'r*'); 
setaxis(t, V);
title('Hodgkin-Huxley voltage with spikes');
xlabel('t (s)');
ylabel('V');
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
disp('part C')

