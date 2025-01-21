function uPunkt = calculateTrajectory(constants, pos)
u = pos;
distance = norm(u(1:2));
c = -((constants.G .* constants.sunMass)/(distance^3));
 
uPunkt = [u(3:4);
           c.*u(1:2)];
end
