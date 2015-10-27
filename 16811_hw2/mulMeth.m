function [ p ] = mulMeth(p0, p1, p2, func, tol, maxI)

    h1 = p1 - p0;
    h2 = p2 - p1;
        
    delta1 = (func(p1)-func(p0))/h1;
    delta2 = (func(p2)-func(p1))/h2;
        
    d = (delta2 - delta1)/ (h2 + h1);

    for i = 3:maxI

        b = delta2+ h2*d;
        bigD = (b^2 - 4*func(p2)*d)^(1/2);
        
        if abs(b-bigD) < abs(b+bigD)
            E = b + bigD;
        else
            E = b - bigD;
        end
        
        h = (-2*func(p2))/E;
        p = p2+h;
            
        if abs(h) < tol
            return;
        end
        
        p0 = p1;
        p1 = p2;
        p2 = p;
        
        h1 = p1 - p0;
        h2 = p2 - p1;
        
        delta1 = (func(p1)-func(p0))/h1;
        delta2 = (func(p2)-func(p1))/h2;
        
        d = (delta2 - delta1)/ (h2 + h1);
        
        
    end
    
    %If we make it here, it failed
    fprintf('mulers failed after %i iterations\n', i);
        

end