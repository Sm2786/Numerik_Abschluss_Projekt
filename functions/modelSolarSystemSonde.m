function [earthOrbit, marsOrbit, position_earth, position_mars] = modelSolarSystemSonde(constants, t, u, flight_time)

    % Convert time to days
    t_planeten = t / (24 * 3600);
    
    % Preallocate arrays for orbits
    num_steps = length(t_planeten);
    earthOrbit = zeros(num_steps, 2); % 2 columns for x and y coordinates
    marsOrbit = zeros(num_steps, 2);

    % Loop through time steps in t_planeten
    for i = 1:num_steps
        t_curr = t_planeten(i);
        % Calculate positions of Earth and Mars
        [earth_position, mars_position] = positionsCalcPlanets(constants, t_curr);
        
        % Store the positions in the respective orbit arrays
        earthOrbit(i, :) = earth_position;
        marsOrbit(i, :) = mars_position;
    end

    % Plot the orbits
    figure;
    hold on;
    plot(earthOrbit(:, 1), earthOrbit(:, 2), 'b', 'DisplayName', 'Earth Orbit');
    plot(marsOrbit(:, 1), marsOrbit(:, 2), 'r', 'DisplayName', 'Mars Orbit');
    plot(u(:, 1), u(:, 2), 'g', 'DisplayName', 'Spacecraft Trajectory');
    plot(0, 0, 'yo', 'MarkerSize', 10, 'MarkerFaceColor', 'yellow', 'DisplayName', 'Sun'); % Sun at origin
    axis equal;
    grid on;
    legend;
    title('Orbits of Earth, Mars, and the Spacecraft');
    xlabel('x (km)');
    ylabel('y (km)');

    % Animation
    earth = plot(earthOrbit(1, 1), earthOrbit(1, 2), 'bo', 'MarkerSize', 8, 'MarkerFaceColor', 'blue', 'DisplayName', 'Earth');
    mars = plot(marsOrbit(1, 1), marsOrbit(1, 2), 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'red', 'DisplayName', 'Mars');
    sonde = plot(u(1, 1), u(1, 2), 'go', 'MarkerSize', 8, 'MarkerFaceColor', 'green', 'DisplayName', 'Spacecraft');

    for i = 2:num_steps
        % Update positions for animation
        set(earth, 'XData', earthOrbit(i, 1), 'YData', earthOrbit(i, 2));
        set(mars, 'XData', marsOrbit(i, 1), 'YData', marsOrbit(i, 2));
        set(sonde, 'XData', u(i, 1), 'YData', u(i, 2));
        
        % Check if current time exceeds flight time
        if t_planeten(i) > flight_time * 24 * 3600
            break;
        end

        pause(0.01);
    end
end
