function [abstand, flight_time] = Trajektorie1(v0, constants)
    % Anfangswerte
    pos0 = [constants.earthOrbitRadius + constants.earthRadius, 0, 0, ...
            v0 + constants.earthVelocity];
    tSpan = [0, constants.simulationTime + 2000 * 24 * 3600]; % Zeitspanne (in Sekunden)

    % Integrationseinstellungen
    options = odeset('Events', @(t, pos) MarsEncounter(t, pos, constants), 'RelTol', 1e-6, 'AbsTol', 1e-8);

    % Numerische Lösung der Bewegungsgleichung
    [t, u, te, ue] = ode45(@(t, pos) calculateTrajectory(constants, pos), tSpan, pos0, options);
    
    
    % Marsposition zum Ereigniszeitpunkt berechnen
    %[~, position_mars] = positionsCalcPlanets(constants, te);
    %flight_time = (te/3600)/24;
    %pos_mars = position_mars
    %pos_sonde = ue(1:2)
    %pos_mars_norm = norm(position_mars)
    %pos_sonde_norm = norm(pos_sonde)
    disp(te);
    if isempty(te)
        abstand = Inf;
        v = v0;
        flight_time = Inf;
        % fprintf("V_0: %.2f\n", v);
    else
        [~, position_mars] = positionsCalcPlanets(constants, te);
        flight_time = te/(24*3600);

        % [position_Erde,position_Mars] = positionsCalcPlanets(constants, t_tagen);
        %  % Abstand zwischen Sonde und Marsbahn
        abstand = norm(ue(1:2) - position_mars);
        % figure;
        % hold on;
        % 
        % % Ensure valid plotting styles and check variable dimensions
        % plot(0, 0, 'ko'); % Plot origin with a black circle marker
        % 
        % % Plot 'ue' assuming it's a 2D array with coordinates
        % plot(ue(1, 1), ue(1, 2), 'g*'); % Green star for the point
        % 
        % % Plot Mars's position (correctly indexed)
        % plot(position_Mars(1), position_Mars(2), 'ro'); % Red circle
        % 
        % % Plot Earth's position (correctly indexed)
        % plot(position_Erde(1), position_Erde(2), 'bo'); % Blue circle
        % 
        % hold off;

    end


    
end

