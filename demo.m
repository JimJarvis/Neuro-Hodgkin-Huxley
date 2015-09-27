%% W4020 HW#1 Supplement - Simulating the Hodgkin-Huxley Neuron

%% Simulating the Hodgkin-Huxley Neuron Model
% Define a constant current input to the neuron that starts at time 0:
t = -0.04:1e-5:.08;
I_ext = zeros(size(t));
I_ext(t >= 0) = 30;

%%
% Apply the stimulus and plot the results:
V = hodgkin_huxley(t, I_ext);
figure()
subplot(211); 
plot(t, I_ext);
axis([min(t) max(t) ...
      min(I_ext)-0.1*(abs(max(I_ext))+abs(min(I_ext))) ...
      max(I_ext)+0.1*(abs(max(I_ext))+abs(min(I_ext)))]);
ylabel('I_{ext}');
title('Input current');
subplot(212); 
plot(t,V); 
title('Hodgkin-Huxley membrane voltage');
xlabel('t (s)');
ylabel('V');
