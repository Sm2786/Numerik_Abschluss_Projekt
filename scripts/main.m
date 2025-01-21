clear all
% Load constants
load('data/constants.mat');

tSpan = [0, constants.simulationTime *24 * 3600]; %Umrechung auf Sekunden
pos0 = [constants.earthOrbitRadius + constants.probeIntialOrbitHeight, 0, 0, constants.probeIntialVelocity];

[t, u] = ode45(@(t, pos) calculateTrajectory(constants,pos), tSpan, pos0);
figure;
%% figure; visualisation der Geschwindigkeit (nur für Info)
subplot(2,1,1);
plot(t, u(:,3)); % vx (Geschwindigkeit in x)
xlabel('Zeit (s)');
ylabel('vx (km/s)');
title('Geschwindigkeit in x-Richtung');
grid on;

subplot(2,1,2);
plot(t, u(:,4)); % vy (Geschwindigkeit in y)
xlabel('Zeit (s)');
ylabel('vy (km/s)');
title('Geschwindigkeit in y-Richtung');
grid on;

plot(u(:,1), u(:,2))
hold on;
plot(0,0, 'ro','MarkerSize',10,'MarkerFaceColor','r')




