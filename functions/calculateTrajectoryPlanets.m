function uPunkt = calculateTrajectoryPlanets(constants, pos)
u_mars = pos;
distance_mars = norm(u(1:2) - positionsCalcPlanets(constants,t).position_mars);
c_mars = -((constants.G .* constants.marsMass)/(distance_mars^3));
 
uPunkt = [u(3:4)+ ;
           c_mars.*u(1:2)];
end
