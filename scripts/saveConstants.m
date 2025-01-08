% Define constants
constants.earthRadius = 149.6e6;      % Earth's orbital radius in km
constants.marsRadius = 227.9e6;       % Mars's orbital radius in km
constants.earthPeriod = 365.25;       % Earth's orbital period in days
constants.marsPeriod = 687;           % Mars's orbital period in days
constants.simulationTime = 1000;      % Simulation duration in days
constants.timeStep = 1;               % Time step in days

% Save constants to a .mat file
save('data/constants.mat', 'constants');

disp('Constants saved to data/constants.mat');