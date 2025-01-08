function force_vector = calculateSystemGravitationalField(object_position, object_mass, planet_position, planet_mass)
    r_vector = planet_position - object_position;
    r_magnitude = norm(r_vector);
    if r_magnitude == 0
        error('The position of the object coincides with the planet!');
    end
    force_magnitude = constants.G * planet_mass * object_mass / r_magnitude^2;
    force_vector = force_magnitude * (r_vector / r_magnitude);
end
