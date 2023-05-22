clear all;

% Construct the signals
t = linspace(0, 1, 100);
s1 = rectangularPulse(0, 1, t); 
s1(1) = 0; s1(end) = 0;

s2 = rectangularPulse(0, 0.75, t) - 1 * rectangularPulse(0.75, 1, t);
s2(1) = 0; s2(end) = 0;

% Calculate GM bases
[phi1, phi2] = calculateGM_Bases(s1, s2);

% Plot basis functions
figure('Name', 'Basis Functions', 'NumberTitle', 'off');
plot(t, phi1, 'LineWidth', 2);
legend('Basis 1');
xlabel('Time');
ylabel('Amplitude');
title('Basis Function 1');
grid on;

figure('Name', 'Basis Functions', 'NumberTitle', 'off');
plot(t, phi2, 'LineWidth', 2);
legend('Basis 2');
xlabel('Time');
ylabel('Amplitude');
title('Basis Function 2');
grid on;

% Signal space representation
[s1_v1, s1_v2] = signalSpace(s1, phi1, phi2);
[s2_v1, s2_v2] = signalSpace(s2, phi1, phi2);

% Plot signal space representation
figure('Name', 'Signal Space Representation', 'NumberTitle', 'off');
plot([0 s1_v1], [0 s1_v2], '-o', 'LineWidth', 2);
hold on;
plot([0 s2_v1], [0 s2_v2], '-o', 'LineWidth', 2);
legend('Signal 1', 'Signal 2');
xlabel('Phi1');
ylabel('Phi2');
title('Signal Space Representation');
grid on;

% Plot signals with noise
plotSignalWithNoise(1, s1_v1, s1_v2, s2_v1, s2_v2, s1, s2, phi1, phi2);
plotSignalWithNoise(2, s1_v1, s1_v2, s2_v1, s2_v2, s1, s2, phi1, phi2);
plotSignalWithNoise(3, s1_v1, s1_v2, s2_v1, s2_v2, s1, s2, phi1, phi2);
