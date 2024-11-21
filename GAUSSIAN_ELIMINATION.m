A = [4, -2, 1; -2, 4, -2; 1, -2, 4]; 
b = [11; -16; 17]; 
x = gaussElimination(A, b);
disp(x);
function x = gaussElimination(A, b)

    n = length(b);


    for k = 1:n-1
        for i = k+1:n
            factor = A(i,k) / A(k,k);
            for j = k+1:n
                A(i,j) = A(i,j) - factor * A(k,j);
            end
            b(i) = b(i) - factor * b(k);
        end
    end


    x = zeros(n, 1); 
    x(n) = b(n) / A(n,n);
    for i = n-1:-1:1
        x(i) = (b(i) - A(i,i+1:n) * x(i+1:n)) / A(i,i);
    end
end
