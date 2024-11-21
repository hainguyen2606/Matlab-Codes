% Parameters
L = 10; % Length of the rod in cm
dx = 2; % Spatial step in cm
Nx = L / dx + 1; % Number of spatial nodes
alpha = 0.835; % Thermal diffusivity in cm^2/s
dt = 0.1; % Time step in seconds
t_final = 10.0; % Final time in seconds

% Stability criterion: Crank-Nicolson is unconditionally stable, but we still consider accuracy
if dt > dx^2 / (2 * alpha)
    warning('Time step dt is larger than recommended for accuracy.');
end

% Initialize temperature array
T = zeros(Nx, 1); % Temperature at the current time step
T_new = zeros(Nx, 1); % Temperature at the next time step

% Boundary conditions
T(1) = 100; % Left boundary temperature (x = 0)
T(end) = 50; % Right boundary temperature (x = L)

% Coefficients for the Crank-Nicolson scheme
r = alpha * dt / (2 * dx^2);

% Construct the matrix A for the system Ax = b
A = (1 + 2 * r) * eye(Nx) - r * diag(ones(Nx - 1, 1), 1) - r * diag(ones(Nx - 1, 1), -1);

% Adjust the boundary conditions in matrix A
A(1, :) = 0; A(1, 1) = 1; % Left boundary
A(Nx, :) = 0; A(Nx, Nx) = 1; % Right boundary

% Time loop
time_steps = t_final / dt;
results = {}; % To store results at specific times
times_to_record = [0.1, 0.2, 1.0, 3.0, 5.0, 10.0];

for t = 1:time_steps
    % Construct the right-hand side (b) based on the Crank-Nicolson scheme
    b = T; % Initialize b with the current temperature distribution
    for i = 2:Nx-1
        b(i) = (1 - 2 * r) * T(i) + r * (T(i+1) + T(i-1));
    end
    
    % Boundary conditions in vector b
    b(1) = 100; % Left boundary
    b(end) = 50; % Right boundary
    
    % Solve the system of equations A * T_new = b
    T_new = A \ b;
    
    % Update T for the next time step
    T = T_new;
    
    % Store results at specific time steps
    current_time = t * dt;
    if ismember(current_time, times_to_record)
        fprintf('Temperature distribution at t = %.1f s:\n', current_time);
        disp(T');
        results{end+1} = T;
    end
end
