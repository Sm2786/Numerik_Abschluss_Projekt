function abstand = Trajektorie1(v0, constants)
    % Anfangswerte
    pos0 = [constants.earthOrbitRadius + constants.earthRadius, 0, 0, ...
            v0 + constants.earthVelocity];
    tSpan = [0, constants.simulationTime + 2000 * 24 * 3600]; % Zeitspanne (in Sekunden)

    % Integrationseinstellungen
    options = odeset('Events', @(t, pos) MarsEncounter(t, pos, constants));

    % Numerische Lösung der Bewegungsgleichung
    [t, u, te, ue] = ode45(@(t, pos) calculateTrajectory(constants, pos), tSpan, pos0, options);

    % Marsposition zum Ereigniszeitpunkt berechnen
    [~, position_mars] = positionsCalcPlanets(constants, te);

    % Abstand zwischen Sonde und Marsbahn
    abstand = norm(ue(1:2) - position_mars);
end

