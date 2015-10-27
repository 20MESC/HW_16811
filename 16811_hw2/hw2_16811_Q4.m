clc
clear

% Bisection - referenced method from Numerical Analysis by Burden
% equivalent of tan(x)
f = inline('x*cos(x)-sin(x)','x');

    a=(-pi/2)+63*pi+eps;
    b=(pi/2)+63*pi-eps;
    p = (a + b)/2;
    err = abs(f(p));
    while err > 1e-5
        if f(a)*f(p)<0 
            b = p;
        else
            a = p;          
        end
        p = (a + b)/2
        err = abs(f(p));
    end
    
% Polish with Newton's Method
f = inline('tan(x)-x','x');
fprime = inline('tan(x)^2','x');
err = 1e-9;

x = p;
while abs(f(x)) > err
    x = x - (f(x)/fprime(x))
end

