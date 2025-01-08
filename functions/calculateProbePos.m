function posNew = calculateProbeTrajectory(constants, posEarth, posMars, posProbe)
  
   
    velocity = [0, constants.v0]; 

    force_vectorSun = calculateSunGravitationalField(posProbe, constants.sondeMass, constants);
    force_vectorMars = calculateSystemGravitationalField(constants,posProbe, constants.probeMars, posMars,constants.marsMass, constants); 
    force_vectorErde = calculateSystemGravitationalField(constants,posProbe, constants.probeMars, posEarth,constants.earthMass, constants);
    force_ges = force_vectorSun + force_vectorMars + force_vectorErde;
    acceleration = force_ges / constants.sondeMass;

        % Numerische Integration (Euler-Verfahren)
        velocity = velocity + acceleration * constants.timeStep; % Neue Geschwindigkeit
        posNew = posProbe + velocity * constants.timeStep; % Neue Position
end

