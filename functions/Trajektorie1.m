function abstand = Trajektorie1(v0, constants)
pos0 = [constants.earthOrbitRadius + constants.earthRadius, 0, 0, v0 + constants.earthVelocity];
tSpan = [0, constants.simulationTime + 2000 *24 * 3600]; %Umrechung auf Sekunden

options = odeset('Events', @MarsEncounter);
[~, u, te, ue] = ode45(@(t, pos) calculateTrajectoryPlanets(constants, pos, t), tSpan, pos0, options);

[~, position_mars] = positionsCalcPlanets(constants, te);
        abstand = norm(ue(1:2) - position_mars);

end

