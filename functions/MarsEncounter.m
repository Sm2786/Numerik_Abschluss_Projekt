function [distance_to_mars, stop, dir] = MarsEncounter(t, u, constants)
    % Position der Sonde (x, y)
    position_probe = u(1:2);
    
    t_tagen = t/(24*3600);
    % Aktuelle Position des Mars
    [~, mars_position] = positionsCalcPlanets(constants, t_tagen); % Funktion zur Berechnung der Marsposition

    % Abstand zwischen Sonde und Mars
    distance_to_mars = norm(position_probe - mars_position);
    %fprintf("Zeit: %.2f s / %.2f t\n", t, t_tagen);
    %fprintf("Distance to Mars: %.2f\n", distance_to_mars);

    % Ereignis tritt ein, wenn Sonde den Mars genau trifft
    if distance_to_mars <= constants.marsRadius
        stop = 1; % Trigger stop event
        disp("stop");
    else
        stop = 0; % Do not stop
    end
    dir = 0;   % Erkennung sowohl bei Annäherung als auch bei Entfernung
end


