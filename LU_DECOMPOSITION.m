a = [31 2 29;1.5 5 7;4 3 3];
n = length(a);
[L, U] = Decompose(a, n)

function [L, U] = Decompose(a, n)
    L = eye(n); 
    for k = 1:n-1
        for i = k+1:n
            factor = a(i,k) / a(k,k);
            L(i,k) = factor; 
            for j = k:n
                a(i,j) = a(i,j) - factor * a(k,j);
            end
        end
    end
    U = a; 
end
