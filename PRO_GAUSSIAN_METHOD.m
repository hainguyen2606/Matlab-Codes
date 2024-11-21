a = [15 22 77;9 9.5 -5; 0 18 25];
b = [13 4.7 2];
tol = 0.001;
result = Gauss(a,b,tol)

function [x, er] = Gauss(a, b, tol)
    
    n = length(b);
    s = zeros(n, 1);
    x = zeros(n, 1);
    er = 0;

    for i = 1:n
        s(i) = abs(a(i, 1));
        for j = 2:n
            if abs(a(i, j)) > s(i)
                s(i) = abs(a(i, j));
            end
        end
    end

 
    [a, b, er] = Eliminate(a, s, n, b, tol);
    
  
    if er ~= -1
        x = Substitute(a, n, b);
    end
end

function [a, b, er] = Eliminate(a, s, n, b, tol)
    er = 0;
    
    for k = 1:n-1
     
        [a, b, s] = Pivot(a, b, s, n, k);
        
        if abs(a(k, k)) < tol
            er = -1;
            return;
        end
        
        for i = k+1:n
            factor = a(i, k) / a(k, k);
            for j = k+1:n
                a(i, j) = a(i, j) - factor * a(k, j);
            end
            b(i) = b(i) - factor * b(k);
        end
    end
    
    if abs(a(n, n)) < tol
        er = -1;
    end
end

function [a, b, s] = Pivot(a, b, s, n, k)
    p = k;
    big = abs(a(k, k) / s(k));
    
    for i = k+1:n
        dummy = abs(a(i, k) / s(i));
        if dummy > big
            big = dummy;
            p = i;
        end
    end
    
    if p ~= k
   
        for j = k:n
            dummy = a(p, j);
            a(p, j) = a(k, j);
            a(k, j) = dummy;
        end
      
        dummy = b(p);
        b(p) = b(k);
        b(k) = dummy;
  
        dummy = s(p);
        s(p) = s(k);
        s(k) = dummy;
    end
end

function x = Substitute(a, n, b)
    x = zeros(n, 1);
    x(n) = b(n) / a(n, n);
    
    for i = n-1:-1:1
        sum = 0;
        for j = i+1:n
            sum = sum + a(i, j) * x(j);
        end
        x(i) = (b(i) - sum) / a(i, i);
    end
end
