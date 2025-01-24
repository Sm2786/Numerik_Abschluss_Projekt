function [distance_to_mars_orbit, stop, dir] = MarsEncounter(t, u, constants)

    % Position der Sonde (x, y)
    position_probe = u(1:2);

    % Abstand der Sonde von der Marsbahn
    distance_to_mars_orbit = norm(position_probe) - constants.marsOrbitRadius;

    % Abbruchbedingung: Abstand erreicht (oder Annäherung überwachen)
    stop = 1;  % Stopp der Integration, wenn das Ereignis eintritt
    dir = 0;   % Ereignis sowohl bei Annäherung als auch Entfernung erkennen
end

