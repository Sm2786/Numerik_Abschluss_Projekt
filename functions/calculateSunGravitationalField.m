function force_vector = calculateSunGravitationalField(pos, mass_object)

    r_vector = sun_position - pos;
    r_magnitude = norm(r_vector);

    if r_magnitude == 0
        error('The position of the object coincides with the Sun!');
    end

    force_magnitude = constants.G * constants.sunMass * mass_object / r_magnitude^2;

    force_vector = force_magnitude * (r_vector / r_magnitude);
end
