clear all
% Load constants
load('data/constants.mat');

time = 0:constants.timeStep:constants.simulationTime;
zeit = time';

[t, u] = ode45(@(t, pos) calculateSunGravitationalField(constants,pos), zeit, ...
               [(constants.earthOrbitRadius + constants.probeIntialOrbitHeight) 0 0 constants.probeIntialVelocity]);
figure;
plot(u(:,1), u(:,2))
%% figure; visualisation der Geschwindigkeit (nur für Info)
subplot(2,1,1);
plot(t, u(:,3)); % vx (Geschwindigkeit in x)
xlabel('Zeit (s)');
ylabel('vx (m/s)');
title('Geschwindigkeit in x-Richtung');
grid on;

subplot(2,1,2);
plot(t, u(:,4)); % vy (Geschwindigkeit in y)
xlabel('Zeit (s)');
ylabel('vy (m/s)');
title('Geschwindigkeit in y-Richtung');
grid on;





