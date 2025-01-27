function uPunkt = calculateTrajectoryPlanets(constants, pos, t)

    u = pos;

    distance_sun = norm(u(1:2));
    c_sonne = -((constants.G * constants.sunMass) / (distance_sun^3));

   

    %Berechnung der Positionen der Planeten
    position_earth = zeros(2,1);
    position_mars = zeros(2,1);
    
    earthOmega = 2 * pi / constants.earthPeriod;
    marsOmega = 2 * pi / constants.marsPeriod;
    
    theta = earthOmega * t;
    position_earth(1, 1) = constants.earthRadius * cos(theta);
    position_earth(2, 1) = constants.earthRadius * sin(theta);
    
    theta = marsOmega * t;
    position_mars(1, 1) = -constants.marsRadius * cos(theta);
    position_mars(2, 1) = -constants.marsRadius * sin(theta);

    % Einfluss der Erde
    vector_earth = u(1:2) - position_earth;
    distance_earth = norm(vector_earth);
    c_earth = -((constants.G * constants.earthMass) / (distance_earth^3));

    % Einfluss des Mars
    vector_mars = u(1:2) - position_mars;
    distance_mars = norm(vector_mars);
    c_mars = -((constants.G * constants.marsMass) / (distance_mars^3));

    % Gesamte Beschleunigung durch alle Einflüsse
    acceleration = c_sonne * u(1:2) + c_earth * vector_earth + c_mars * vector_mars;


    uPunkt = [u(3:4); acceleration];
end
