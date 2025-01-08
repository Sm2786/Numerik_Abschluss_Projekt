function [earthOrbit, marsOrbit] = modelSolarSystem(constants)  %Zeit input
   
    earthRadius = constants.earthRadius;
    marsRadius = constants.marsRadius;
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
    plot(0, 0, 'yo', 'MarkerSize', 10, 'DisplayName', 'Sun'); % Sun at origin
    axis equal;
    grid on;
    legend;
    title('Circular Orbits of Earth and Mars');
    xlabel('x (km)');
    ylabel('y (km)');

    % Animation der Planetenbewegung
    for i = 1:length(time)
        earth = plot(earthOrbit(i,1), earthOrbit(i,2), 'bo', 'MarkerSize', 8, 'MarkerFaceColor', 'blue'); % Erde
        mars = plot(marsOrbit(i,1), marsOrbit(i,2), 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'red'); % Mars
        pause(0.01); % Pause für Animation
        %if i < length(time)
            %delete(findobj(gca, 'MarkerFaceColor', 'blue')); % Erde entfernen
            %delete(findobj(gca, 'MarkerFaceColor', 'red')); % Mars entfernen
        %end
        delete(earth);
        delete(mars)
    end
end