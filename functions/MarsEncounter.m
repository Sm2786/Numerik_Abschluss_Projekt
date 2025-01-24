function [distance_to_mars, stop, dir] = MarsEncounter(t, u, constants)
    
    position_probe = u(1:2);

    [~, position_mars] = positionsCalcPlanets(constants, t);

    % Abstand zwischen Sonde und Marsbahn
    distance_to_mars = norm(position_probe - position_mars);

    % Abbruchbedingung: Abstand unterhalb eines Toleranzwerts
    stop = 1; 
    dir = 0;  
end
