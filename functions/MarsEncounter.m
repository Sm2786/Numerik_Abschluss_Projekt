function [distance_to_mars, stop, dir] = MarsEncounter(t, u, constants)
    % Position der Sonde (x, y)
    position_probe = u(1:2);

    % Aktuelle Position des Mars
    [~, mars_position] = positionsCalcPlanets(constants, t); % Funktion zur Berechnung der Marsposition

    % Abstand zwischen Sonde und Mars
    distance_to_mars = norm(position_probe - mars_position);

    % Ereignis tritt ein, wenn Sonde den Mars genau trifft
    stop = 1;  % Stopp der Integration, wenn Abstand = 0
    dir = 0;   % Erkennung sowohl bei Annäherung als auch bei Entfernung
end


