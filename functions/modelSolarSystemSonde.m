function [earthOrbit, marsOrbit, position_earth, position_mars] = modelSolarSystemSonde(constants, t, u, flight_time) 
   
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


   % Zeitpunkte der Sonde
t_u = linspace(0, constants.simulationTime, size(u, 1));

% Interpolation auf dieselben Zeitpunkte wie Erde und Mars
u_interp = interp1(t_u, u(:, 1:2), time);



    figure;
    hold on;
    plot(earthOrbit(:, 1), earthOrbit(:, 2), 'b', 'DisplayName', 'Erd Umlaufbahn');
    plot(marsOrbit(:, 1), marsOrbit(:, 2), 'r', 'DisplayName', 'Mars Umlaufbahn');
    plot(u(:,1), u(:,2), 'g', 'DisplayName', 'Sonde Umlaufbahn');
    plot(0, 0, 'yo', 'MarkerSize', 10,'MarkerFaceColor', 'yellow', 'DisplayName', 'Sonne'); % Sun at origin
    axis equal;
    grid on;
    legend;
    title('Umlaufbahnen von der Erde und Mars');
    xlabel('x (km)');
    ylabel('y (km)');
    hold on;

   % Animation
    earth = plot(earthOrbit(1,1), earthOrbit(1,2), 'bo', 'MarkerSize', 8, 'MarkerFaceColor', 'blue', 'DisplayName','Erde');
    mars = plot(marsOrbit(1,1), marsOrbit(1,2), 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'red', 'DisplayName','Mars');
    sonde = plot(u(1,1), u(1,2), 'go', 'MarkerSize', 8, 'MarkerFaceColor', 'green', 'DisplayName','Sonde');
    for i = 2:flight_time
        set(earth, 'XData', earthOrbit(i,1), 'YData', earthOrbit(i,2));
        set(mars, 'XData', marsOrbit(i,1), 'YData', marsOrbit(i,2));
        set(sonde, 'XData', u_interp(i,1), 'YData', u_interp(i,2));
        pause(0.01);
    end
end
