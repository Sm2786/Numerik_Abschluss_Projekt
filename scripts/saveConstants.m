constants.earthOrbitRadius = 149.6e6; %km
constants.earthRadius = 6357; %km
constants.earthPeriod = 365.25; %T
constants.earthMass = 5.9722e24;%kg

constants.marsOrbitRadius = 227.9e6; %km
constants.marsPeriod = 687; %T
constants.marsMass = 6.417e23;%kg

constants.sunMass = 1.989e30; %kg

constants.probeMass = 10000; %kg SpaceX Dragon
constants.probeIntialOrbitHeight = 35000; %km
constants.probeIntialVelocity = 15; %km/s

constants.G = 6.67430e-20;



constants.simulationTime = 365.25;
constants.timeStep = 1;



save('data/constants.mat', 'constants');

disp('Constants saved to data/constants.mat');