function [earthOrbit, marsOrbit, position_earth, position_mars] = modelSolarSystem(constants) 
   
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
        marsOrbit(i, 1) = -marsRadius * cos(theta);
        marsOrbit(i, 2) = -marsRadius * sin(theta);
    end


    figure;
    hold on;
    plot(earthOrbit(:, 1), earthOrbit(:, 2), 'b', 'DisplayName', 'Erd Umlaufbahn');
    plot(marsOrbit(:, 1), marsOrbit(:, 2), 'r', 'DisplayName', 'Mars Umlaufbahn');
    plot(0, 0, 'yo', 'MarkerSize', 10,'MarkerFaceColor', 'yellow', 'DisplayName', 'Sonne'); % Sun at origin
    axis equal;
    grid on;
    legend;
    title('Umlaufbahnen von der Erde und Mars');
    xlabel('x (km)');
    ylabel('y (km)');

   % Animation
    earth = plot(earthOrbit(1,1), earthOrbit(1,2), 'bo', 'MarkerSize', 8, 'MarkerFaceColor', 'blue', 'DisplayName','Erde');
    mars = plot(marsOrbit(1,1), marsOrbit(1,2), 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'red', 'DisplayName','Mars');
    for i = 2:constants.simulationTime
        set(earth, 'XData', earthOrbit(i,1), 'YData', earthOrbit(i,2));
        set(mars, 'XData', marsOrbit(i,1), 'YData', marsOrbit(i,2));
        pause(0.01);
    end
end