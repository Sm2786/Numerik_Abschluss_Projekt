function [position_earth,position_mars] = positionsCalcPlanets(constants, time)
%Function to calculate the position of earth and mars at a wanted time
earthRadius = constants.earthOrbitRadius;
marsRadius = constants.marsOrbitRadius;
earthPeriod = constants.earthPeriod;
marsPeriod = constants.marsPeriod;

position_earth = zeros(2,1);
position_mars = zeros(2,1);

earthOmega = 2 * pi / earthPeriod;
marsOmega = 2 * pi / marsPeriod;

theta = earthOmega * time;
position_earth(1, 1) = earthRadius * cos(theta);
position_earth(2, 1) = earthRadius * sin(theta);

theta = marsOmega * time;
position_mars(1, 1) = marsRadius * cos(theta);
position_mars(2, 1) = marsRadius * sin(theta);
end