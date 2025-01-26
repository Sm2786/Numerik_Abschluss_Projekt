% Optimized MATLAB Script to plot gravitational field lines of the Sun with Earth and Mars
clc;
clear;
close all;

% Constants
G = 6.67430e-11;   % Gravitational constant (m^3 kg^-1 s^-2)
M_sun = 1.989e30;  % Mass of the Sun (kg)
AU = 1.496e11;     % Astronomical Unit (m), distance from the Earth to the Sun

% Define the grid for the plot (2D space around the Sun)
x = linspace(-2*AU, 2*AU, 100);  % Reduced grid size (100 points)
y = linspace(-2*AU, 2*AU, 100);
[X, Y] = meshgrid(x, y);

% Gravitational field (force per unit mass)
R = sqrt(X.^2 + Y.^2);
R(R == 0) = NaN;  % Avoid division by zero at the Sun's location
F = G * M_sun ./ R.^2;

% Calculate the components of the gravitational field (pointing towards the Sun)
Ex = -F .* X ./ R;  % X-component of the field
Ey = -F .* Y ./ R;  % Y-component of the field

% Create the figure
figure;
hold on;
axis equal;
xlim([-2*AU, 2*AU]);
ylim([-2*AU, 2*AU]);
xlabel('x (m)');
ylabel('y (m)');
title('Gravitational Field of the Sun with Earth and Mars');

% Plot the Sun as a yellow circle at the origin
sun_radius = 696340e3;  % Radius of the Sun in meters
theta = linspace(0, 2*pi, 100);
plot(sun_radius * cos(theta), sun_radius * sin(theta), 'y', 'LineWidth', 2);

% Plot Earth and Mars' positions (approximate positions in AU)
earth_x = 1 * AU;  % 1 AU from the Sun
earth_y = 0;       % On the x-axis for simplicity
plot(earth_x, earth_y, 'go', 'MarkerFaceColor', 'g', 'MarkerSize', 10);

% Mars - 1.524 AU from the Sun (simplified)
mars_x = 1.524 * AU; % 1.524 AU from the Sun
mars_y = 0;         % On the x-axis for simplicity
plot(mars_x, mars_y, 'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 10);

% Create the 2D field lines using quiver with reduced density of arrows
quiver(X(1:5:end, 1:5:end), Y(1:5:end, 1:5:end), ...
    Ex(1:5:end, 1:5:end), Ey(1:5:end, 1:5:end), ...
    'k', 'AutoScale', 'off', 'LineWidth', 1.5);

% Display
legend('Sun', 'Earth', 'Mars', 'Gravitational Field Lines', 'Location', 'best');
hold off;
