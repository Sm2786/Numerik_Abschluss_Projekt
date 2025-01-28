function [value, stop, dir] = MarsEncounter(t, u, constants)
    % Position of the probe (x, y)
    position_probe = u(1:2);

    t_tagen = t / (24 * 3600);
    % Current position of Mars
    [~, mars_position] = positionsCalcPlanets(constants, t_tagen); % Function to calculate Mars position

    % Distance between the probe and Mars
    distance_to_mars = norm(position_probe - mars_position);

    % Define tolerance for encounter
    tolerance = 1000; % in meters

    % Define the value for the event function (distance - tolerance)
    value = distance_to_mars - (constants.marsRadius * 1000);

    % Stop the solver when value crosses 0 (within tolerance)
    stop = 1; % Stop integration when event occurs
    dir = 0; % Detect only decreasing distances (approaching Mars)

    % Debugging output
    %fprintf('Time: %.2f, Distance to Mars: %.2f, Event Value: %.2f\n', t, distance_to_mars, value);
end
