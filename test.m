clear all
% Load constants
load('data/constants.mat');

% Convert simulation time to seconds
tSpan = [0, constants.simulationTime * 24 * 3600];

% Initial conditions (position and velocity)
pos0 = [constants.earthOrbitRadius + constants.probeIntialOrbitHeight, 0, 0, constants.probeIntialVelocity];

% ODE solver options
options = odeset('RelTol', 1e-13, 'AbsTol', 1e-16 * ones(size(pos0)));

% Solve the differential equation
[t, u] = ode45(@(t, pos) calculateTrajectory(constants, pos), tSpan, pos0, options);

% Animation parameters
timeSteps = 0:constants.timeStep:(constants.simulationTime * 24 * 3600);
nFrames = length(timeSteps);

% Create figure
figure;
axis equal;
hold on;
grid on;
xlabel('x (km)');
ylabel('y (km)');
title('Visualization of Gravitational Field and Trajectory');

% Set up objects for animation
probeTrajectory = plot(0, 0, 'r', 'LineWidth', 1.5); % Probe trajectory
earthMarker = plot(0, 0, 'bo', 'MarkerSize', 10, 'MarkerFaceColor', 'b'); % Earth marker
marsMarker = plot(0, 0, 'go', 'MarkerSize', 10, 'MarkerFaceColor', 'g'); % Mars marker
sunMarker = plot(0, 0, 'yo', 'MarkerSize', 15, 'MarkerFaceColor', 'y'); % Sun marker

% Function to generate radial field points around a planet
generateRadialPoints = @(center, radius, numArrows) deal( ...
    center(1) + radius * cos(linspace(0, 2 * pi, numArrows)), ...
    center(2) + radius * sin(linspace(0, 2 * pi, numArrows)) ...
);

% Loop for animation
for frame = 1:nFrames
    time = timeSteps(frame);

    % Calculate positions of Earth and Mars
    [position_earth, position_mars] = positionsCalcPlanets(constants, time);
    earthPos = position_earth';
    marsPos = position_mars';

    % Update markers for Earth, Mars, and Sun
    set(earthMarker, 'XData', earthPos(1), 'YData', earthPos(2));
    set(marsMarker, 'XData', marsPos(1), 'YData', marsPos(2));
    set(sunMarker, 'XData', 0, 'YData', 0);

    % Generate radial field points for Earth
    [earthFieldX, earthFieldY] = generateRadialPoints(earthPos, constants.earthRadius * 5, 20);
    [marsFieldX, marsFieldY] = generateRadialPoints(marsPos, constants.marsRadius * 5, 20);

    % Calculate field vectors for Earth and Mars
    earthFieldVectors = calculateGravitationalField(constants, [earthFieldX; earthFieldY], earthPos, constants.earthMass);
    marsFieldVectors = calculateGravitationalField(constants, [marsFieldX; marsFieldY], marsPos, constants.marsMass);

    % Plot arrows radially around Earth
    quiver(earthFieldX, earthFieldY, earthFieldVectors(1, :), earthFieldVectors(2, :), ...
        'AutoScale', 'on', 'AutoScaleFactor', 1, 'Color', 'b');

    % Plot arrows radially around Mars
    quiver(marsFieldX, marsFieldY, marsFieldVectors(1, :), marsFieldVectors(2, :), ...
        'AutoScale', 'on', 'AutoScaleFactor', 1, 'Color', 'g');

    % Update probe trajectory
    set(probeTrajectory, 'XData', u(1:frame, 1), 'YData', u(1:frame, 2));

    % Force figure redraw
    drawnow;
    pause(0.01);
end

%% Supporting Functions

% Function to calculate the probe's trajectory
function dPos = calculateTrajectory(constants, pos)
    % Extract positions and velocities
    x = pos(1);
    y = pos(2);
    vx = pos(3);
    vy = pos(4);

    % Position vector
    object_pos = [x; y];

    % Calculate gravitational field contributions
    gFieldEarth = calculateGravitationalField(constants, object_pos, [0; 0], constants.earthMass);
    gFieldSun = calculateGravitationalField(constants, object_pos, [0; 0], constants.sunMass);

    % Total gravitational field
    totalGField = gFieldEarth + gFieldSun;

    % Return derivatives (dx/dt, dy/dt, dvx/dt, dvy/dt)
    dPos = [vx; vy; totalGField(1); totalGField(2)];
end

% Function to calculate gravitational field
function gField = calculateGravitationalField(constants, object_pos, planet_pos, planet_mass)
    r = object_pos - planet_pos; % Vector from planet to object
    r_magnitude = sqrt(sum(r.^2));
    if r_magnitude == 0
        gField = [0; 0];
    else
        gField = -constants.G * planet_mass / r_magnitude^3 * r;
    end
end

% Function to calculate positions of Earth and Mars
function [position_earth, position_mars] = positionsCalcPlanets(constants, time)
    earthRadius = constants.earthOrbitRadius;
    marsRadius = constants.marsOrbitRadius;
    earthPeriod = constants.earthPeriod;
    marsPeriod = constants.marsPeriod;

    earthOmega = 2 * pi / earthPeriod;
    marsOmega = 2 * pi / marsPeriod;

    thetaEarth = earthOmega * time;
    thetaMars = marsOmega * time;

    position_earth = [earthRadius * cos(thetaEarth); earthRadius * sin(thetaEarth)];
    position_mars = [marsRadius * cos(thetaMars); marsRadius * sin(thetaMars)];
end
