function [earthOrbit, marsOrbit] = modelSolarSystem(constants)  %Zeit input
   
    earthRadius = constants.earthOrbitRadius;
    marsRadius = constants.marsOrbitRadius;
    earthPeriod = constants.earthPeriod;
    marsPeriod = constants.marsPeriod;
    simulationTime = constants.simulationTime;
    timeStep = constants.timeStep;

    time = 0:timeStep:simulationTime;

    earthOmega = 2 * pi / earthPeriod;
    marsOmega = 2 * pi / marsPeriod;

    earthOrbit = zeros(length(time), 2);
    for i = 1:length(time)
        theta = earthOmega * time(i);
        earthOrbit(i, 1) = earthRadius * cos(theta);
        earthOrbit(i, 2) = earthRadius * sin(theta);
    end

    marsOrbit = zeros(length(time), 2);
    for i = 1:length(time)
        theta = marsOmega * time(i);
        marsOrbit(i, 1) = marsRadius * cos(theta);
        marsOrbit(i, 2) = marsRadius * sin(theta);
    end

    figure;
    hold on;
    plot(earthOrbit(:, 1), earthOrbit(:, 2), 'b', 'DisplayName', 'Earth Orbit');
    plot(marsOrbit(:, 1), marsOrbit(:, 2), 'r', 'DisplayName', 'Mars Orbit');
    plot(0, 0, 'yo', 'MarkerSize', 10,'MarkerFaceColor', 'yellow', 'DisplayName', 'Sun'); % Sun at origin
    axis equal;
    grid on;
    legend;
    title('Circular Orbits of Earth and Mars');
    xlabel('x (km)');
    ylabel('y (km)');

   % Animation
    earth = plot(earthOrbit(1,1), earthOrbit(1,2), 'bo', 'MarkerSize', 8, 'MarkerFaceColor', 'blue');
    mars = plot(marsOrbit(1,1), marsOrbit(1,2), 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'red');
    for i = 2:length(time)
        set(earth, 'XData', earthOrbit(i,1), 'YData', earthOrbit(i,2));
        set(mars, 'XData', marsOrbit(i,1), 'YData', marsOrbit(i,2));
        pause(0.01);
    end
end