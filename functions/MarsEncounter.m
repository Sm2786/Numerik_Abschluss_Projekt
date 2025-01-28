function [value, stop, dir] = MarsEncounter(t, u, constants)
    position_probe = u(1:2);

    t_tagen = t / (24 * 3600);

    [~, mars_position] = positionsCalcPlanets(constants, t_tagen); 

    distance_to_mars = norm(position_probe - mars_position);



    value = distance_to_mars - (constants.marsRadius * 1000);

    stop = 1;
    dir = 0;

    %fprintf('Time: %.2f, Distance to Mars: %.2f, Event Value: %.2f\n', t, distance_to_mars, value);
end
