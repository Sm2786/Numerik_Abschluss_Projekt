function [earthOrbit, marsOrbit] = modelSolarSystem(constants)
    % modelSolarSystem - Simulates the circular orbits of Earth and Mars around the Sun
    %
    % Inputs:
    %   constants - Struct containing necessary constants such as:
    %               - earthRadius (in km)
    %               - marsRadius (in km)
    %               - earthPeriod (in days)
    %               - marsPeriod (in days)
    %               - simulationTime (in days)
    %               - timeStep (in days)
    %
    % Outputs:
    %   earthOrbit - Nx2 matrix of Earth's (x, y) positions over time (in km)
    %   marsOrbit - Nx2 matrix of Mars's (x, y) positions over time (in km)

    % Extract constants
    earthRadius = constants.earthRadius; % Semi-major axis of Earth's orbit (km)
    marsRadius = constants.marsRadius;   % Semi-major axis of Mars's orbit (km)
    earthPeriod = constants.earthPeriod; % Orbital period of Earth (days)
    marsPeriod = constants.marsPeriod;   % Orbital period of Mars (days)
    simulationTime = constants.simulationTime; % Total simulation time (days)
    timeStep = constants.timeStep;       % Simulation time step (days)

    % Time vector
    time = 0:timeStep:simulationTime; % Time steps for simulation

    % Angular velocities (rad/day)
    earthOmega = 2 * pi / earthPeriod;
    marsOmega = 2 * pi / marsPeriod;

    % Calculate Earth's orbit
    earthOrbit = zeros(length(time), 2); % Initialize position matrix
    for i = 1:length(time)
        theta = earthOmega * time(i); % Angle at time t
        earthOrbit(i, 1) = earthRadius * cos(theta); % x-coordinate
        earthOrbit(i, 2) = earthRadius * sin(theta); % y-coordinate
    end

    % Calculate Mars's orbit
    marsOrbit = zeros(length(time), 2); % Initialize position matrix
    for i = 1:length(time)
        theta = marsOmega * time(i); % Angle at time t
        marsOrbit(i, 1) = marsRadius * cos(theta); % x-coordinate
        marsOrbit(i, 2) = marsRadius * sin(theta); % y-coordinate
    end

    % Plot the orbits
    figure;
    hold on;
    plot(earthOrbit(:, 1), earthOrbit(:, 2), 'b', 'DisplayName', 'Earth Orbit');
    plot(marsOrbit(:, 1), marsOrbit(:, 2), 'r', 'DisplayName', 'Mars Orbit');
    plot(0, 0, 'yo', 'MarkerSize', 10, 'DisplayName', 'Sun'); % Sun at origin
    axis equal;
    grid on;
    legend;
    title('Circular Orbits of Earth and Mars');
    xlabel('x (km)');
    ylabel('y (km)');
    hold off;
end