clear all
% Load constants
load('data/constants.mat');

time = 0:constants.timeStep:constants.simulationTime;

posProbe = [constants.earthOrbitRadius+constants.earthRadius+constants.probeIntialOrbitHeight,0];

for t = 1:length(time)
    [posEarth, posMars] = postionsCalcPlanets(constans, t);

    posNewProbe = calculateProbePos(posEarth, posMars, posProbe);
    
    posProbe = posNewProbe;

end
