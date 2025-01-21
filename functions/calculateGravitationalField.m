function gravitational_field = calculateGravitationalField(constants, object_position, planet_position, planet_mass)
    
    r_vector = planet_position - object_position;
    
    r_magnitude = norm(r_vector);
   
    if r_magnitude < 1e-9
        error('The position of the object coincides with the planet!');
    end
    
    field_magnitude = constants.G * planet_mass / r_magnitude^2;
    
    gravitational_field = field_magnitude * (r_vector / r_magnitude);
end
