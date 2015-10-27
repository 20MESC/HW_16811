%
%   15-811
%   HW2
%   Author: Rosario Scalise
%   Date: 9-24-15
%  

%   2.)
%   a.)
    % choosing interpolation resolution
    x_2eval = 1:.01:4;
    x = 1:.5:4;
    % calculating data points for log(7,x)^2
    f = (log(x)/log(7)).^(2);

    n = length(x);

    % run interpolation
    fInterp = ddInterp(n,x_2eval,x,f);
    plot(x,f,'o',x_2eval,fInterp,'-');
    
    % gives exact desired interpolated value 
    key = find(x_2eval==2.25);
    fInterp(key)
    
%   b.)
    n=40;%change n manually
    x = ((0:n)*(2/n) - 1);
    f = 5./(1+36.*x.^2);
    
    m = length(x);
    x_2eval = 0:.01:1;
    
    
    fInterp = ddInterp(m,x_2eval,x,f);
    plot(x,f,'o',x_2eval,fInterp,'-');
    
    % gives exact desired interpolated value 
    key = find(x_2eval==0.05);
    fInterp(key)
    
    
    % calculate actual value
    f = 5/(1+36*(0.005)^2);
    
%   c.)

    x = linspace(-1,1,1000);
    f = 5./(1+36.*x.^2);
    
    vals = [];
    %specified n values to check error at
    for n = [2:2:20 40]
      xpre = (0:n)*2/n - 1;
      fpre = 5./(1 + 36*xpre.^2);
      pn = ddInterp(n+1,x,xpre,fpre);
      %calculate error
      En = max(abs(f-pn));
      vals = [vals En];
    end



    
%   3.)
    % n=1 (linear)
    sqrt(((5*10^-7)*8));
    ((3*pi/2)-(-pi/2))/.002;
    
    % n=2 (quadratic)
    nthroot(((5*10^-7)*9*sqrt(3)),3);
    ((3*pi/2)-(-pi/2))/.0198;

%   4.)
    %see bisection.m

%   7.)
%   a.)
    Q = [1 -12 41 -42 0 ; 0 1 -12 41 -42; 1 -2 -35 0 0; 0 1 -2 -35 0; 0 0 1 -2 -35];
    det(Q);
    
%   b.)
    Q1=Q;
    Q1(5,:) = [];
    Q1(:,1) = [];
    
    Q2=Q;
    Q2(5,:) = [];
    Q2(:,2) = [];
    root = (-1)*det(Q1)/det(Q2);
    
    
%   8.)
%   a.)
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

    
%   b.) 
    syms x y;
    Q = [2 0 (2*x^2-1) 0; 0 2 0 (2*x^2-1); 1 (2*x-1) (x^2+x) 0; 0 1 (2*x-1) (x^2+x)];
    x = solve('16*x^4 - 16*x^3 + 12*x - 1','x');
    y1 = solve('2*(0.0840587)^2+2*y^2-1','y'); %for root x(1)
    y2 = solve('2*(-0.7020927)^2+2*y^2-1','y'); %for root x(2)
    
    f1 = inline('2*x^2+2*y^2-1','x','y');
    f2 = inline('x^2 + y^2 + 2*x*y + x - y', 'x', 'y');
    
    f1(x(2),y2(2));
    
%   c.)
    % Plot Roots
    plot(0.084,0.702,'bo');
    plot(0.084,-0.702,'bo');
    plot(-0.702,0.084,'bo');
    plot(-0.702,-0.084,'bo');
    