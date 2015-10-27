%%  part a.)
    % Plot contours
    hold on;

    x= linspace(-3,3);
    y= linspace(-3,3);
    
    [X,Y]= meshgrid(x,y);
    Z=2.*X.^2.+2.*Y.^2-1;
    V=[0,0];
    contour(X,Y,Z,V,'g');

    Z=X.^2+Y.^2+2.*X.*Y+X-Y;
    V=[0,0];
    contour(X,Y,Z,V,'r');

    
%%  part b.) 
    syms x y;
    Q = [2 0 (2*x^2-1) 0; 0 2 0 (2*x^2-1); 1 (2*x-1) (x^2+x) 0; 0 1 (2*x-1) (x^2+x)];
    x = solve('16*x^4 - 16*x^3 + 12*x - 1','x');
    y1 = solve('2*(0.0840587)^2+2*y^2-1','y'); %for root x(1)
    y2 = solve('2*(-0.7020927)^2+2*y^2-1','y'); %for root x(2)
    
    f1 = inline('2*x^2+2*y^2-1','x','y');
    f2 = inline('x^2 + y^2 + 2*x*y + x - y', 'x', 'y');
    
    f1(x(2),y2(2));
    
%%  part c.)
    % Plot Roots
    plot(0.084,0.702,'bo');
    plot(0.084,-0.702,'bo');
    plot(-0.702,0.084,'bo');
    plot(-0.702,-0.084,'bo');
    