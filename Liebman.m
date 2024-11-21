

nx = 20; 
ny = 20; 
tolerance = 1e-5; 
max_iter = 10000; 


T_top = 100;      
T_bottom = 0;     
T_left = 75;      
T_right = 50;     

T = zeros(nx, ny);

T(1, :) = T_top;        
T(end, :) = T_bottom;   
T(:, 1) = T_left;       
T(:, end) = T_right;    


for iter = 1:max_iter
    T_old = T; 
    for i = 2:nx-1
        for j = 2:ny-1
            T(i, j) = 0.25 * (T_old(i+1, j) + T_old(i-1, j) + T_old(i, j+1) + T_old(i, j-1));
        end
    end
    
    
    if max(max(abs(T - T_old))) < tolerance
        disp(['Converged after ' num2str(iter) ' iterations']);
        break;
    end
end

if iter == max_iter
    disp('Maximum number of iterations reached without convergence');
end


[X, Y] = meshgrid(1:nx, 1:ny);
figure;
surf(X, Y, T);
title('Temperature Distribution on the Plate');
xlabel('X-axis');
ylabel('Y-axis');
zlabel('Temperature');
colorbar;
