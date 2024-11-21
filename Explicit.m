
L = 10; 
dx = 2; 
Nx = L / dx + 1; 
alpha = 0.835; 
dt = 0.1; 
t_final = 10.0; 
if dt > dx^2 / (2 * alpha)
    error('Time step dt is too large for stability in explicit method.');
end


T = zeros(Nx, 1); 
T_new = zeros(Nx, 1); 


T(1) = 100; 
T(end) = 50;

time_steps = t_final / dt;
results = {}; 
times_to_record = [0.1, 0.2, 1.0, 3.0, 5.0, 10.0];

for t = 1:time_steps
    
    for i = 2:Nx-1
        T_new(i) = T(i) + alpha * dt / dx^2 * (T(i+1) - 2 * T(i) + T(i-1));
    end
    
    
    T_new(1) = 100; 
    T_new(end) = 50;
    
    
    T = T_new;
    
    
    current_time = t * dt;
    if ismember(current_time, times_to_record)
        fprintf('Temperature distribution at t = %.1f s:\n', current_time);
        disp(T');
        results{end+1} = T;
    end
end
