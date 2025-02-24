clear all
% Load constants
load('data/constants.mat');

tSpan = [0, constants.simulationTime + 2000 *24 * 3600]; %Umrechung auf Sekunden
pos0 = [constants.earthOrbitRadius + constants.earthRadius, 0, 0, constants.probeIntialVelocity + constants.earthVelocity];
options = odeset('RelTol', 1e-13, 'AbsTol', 1e-16 * ones(size(pos0)));
[t, u] = ode45(@(t, pos) calculateTrajectory(constants,pos), tSpan, pos0, options);
%figure;

v = fminsearch(@Trajektorie1,[50 50])


% Plot der Ergebnisse
figure;
plot(u(:, 1), u(:, 2)); % Trajektorie der Sonde
xlabel('x-Position [m]');
ylabel('y-Position [m]');
title('Trajektorie der Sonde');
grid on;
axis equal;
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




