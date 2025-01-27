function [abstand, flight_time] = Trajektorie1(v0, constants)
    % Anfangswerte
    pos0 = [constants.earthOrbitRadius + constants.earthRadius, 0, 0, ...
            v0 + constants.earthVelocity];
    tSpan = [0, constants.simulationTime + 2000 * 24 * 3600]; % Zeitspanne (in Sekunden)

    % Integrationseinstellungen
    options = odeset('Events', @(t, pos) MarsEncounter(t, pos, constants), 'RelTol', 1e-10, 'AbsTol', 1e-12);

    % Numerische Lösung der Bewegungsgleichung
    [t, u, te, ue] = ode45(@(t, pos) calculateTrajectory(constants, pos), tSpan, pos0, options);

    % Marsposition zum Ereigniszeitpunkt berechnen
    %[~, position_mars] = positionsCalcPlanets(constants, te);
    %flight_time = (te/3600)/24;
    %pos_mars = position_mars
    %pos_sonde = ue(1:2)
    %pos_mars_norm = norm(position_mars)
    %pos_sonde_norm = norm(pos_sonde)

    if isempty(te)
        abstand = Inf;
        v = v0
        return;
    else
        [~, position_mars] = positionsCalcPlanets(constants, te);
        flight_time = (te/3600)/24;
    end


    

    % Abstand zwischen Sonde und Marsbahn
    abstand = norm(ue(1:2) - position_mars);
end

