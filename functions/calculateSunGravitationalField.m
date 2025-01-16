function uPunkt = calculateSunGravitationalField(constants, pos)
u = pos; 
c = ((constants.G .* constants.sunMass)/(norm(u(1:2)))^3);
 
uPunkt = [u(1:2);
           c.*u(1:2)];
end
