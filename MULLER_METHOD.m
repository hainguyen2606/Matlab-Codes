
f = @(x) x^3 +x^2 -4*x -4;


x0 = 1;
x1 = 2;
x2 = 3;


tol = 1e-6;


root = muller(f, x0, x1, x2, tol);
disp(['Root: ', num2str(root)]);


function root = muller(f, x0, x1, x2, tol)
    while true
        h0 = x1 - x0;
        h1 = x2 - x1;
        delta0 = (f(x1) - f(x0)) / h0;
        delta1 = (f(x2) - f(x1)) / h1;
        a = (delta1 - delta0) / (h1 + h0);
        b = a * h1 + delta1;
        c = f(x2);
        
        if b > 0
            sign = 1;
        else
            sign = -1;
        end
        
        x3 = x2 - (2 * c) / (b + sign * sqrt(b^2 - 4 * a * c));
        
        if abs(f(x3)) < tol
            root = x3;
            break;
        end
        
        x0 = x1;
        x1 = x2;
        x2 = x3;
    end
end
