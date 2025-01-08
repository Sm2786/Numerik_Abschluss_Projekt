clear all
% Load constants
load('data/constants.mat');

% Model the solar system
[earthOrbit, marsOrbit] = modelSolarSystem(constants, 30);

% Compute gravitational fields
gFieldSun = calculateSunGravitationalField(pos, sunData);
gFieldSystem = calculateSystemGravitationalField(pos, [sunData, earthData, marsData]);

% Calculate probe trajectory
trajectory = calculateProbeTrajectory(v0, duration, gFieldSystem);

% Trajectory 1: Mars arrival velocity
[vRequired, flightDuration] = computeMarsTrajectory1();

% Trajectory 2: Mars lower velocity
[startAngle, flightDuration] = computeMarsTrajectory2();

% Plot results
plotTrajectories(earthOrbit, marsOrbit, trajectory);
