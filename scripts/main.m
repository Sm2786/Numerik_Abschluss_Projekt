clear all
% Load constants
load('data/constants.mat');
%load('functions\calculateSunGravitationalField.m')

time = 0:constants.timeStep:constants.simulationTime;

[t, u] = ode45(@(t, pos) calculateSunGravitationalField(constants, pos), time, ...
               [(constants.earthOrbitRadius + constants.probeIntialOrbitHeight) 0 0 constants.probeIntialVelocity]);
figure;
plot(u(:,1), u(:,2))

