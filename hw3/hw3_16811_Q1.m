%% Part b.)
f = inline('sinh(x)','x');

x = linspace(-2,2);

plot(x,f(x));

%% Part c.)
close all

f = @(x) sinh(x);

x = linspace(-2,2);

hold on;
%axis([(-2-.2) (2+.2) -10 10]);
%plot(x,f(x));

x0=-2;
x2=solve('cosh(x) = (sinh(x) - sinh(-2))/(2+x)')
x1=-x2;
x3=2;

b=cosh(x2);
%NOTE: p(x) = bx
p = @(x) b*x;

points=[[x0; p(x0)] [x1; p(x1)] [x2; p(x2)] [x3; p(x3)]];

%plot(points(1,:),points(2,:),'ro');

e0 = f(x0)-p(x0)
e1 = f(x1)-p(x1)
e2 = f(x2)-p(x2)
e3 = f(x3)-p(x3)


% e = 
% e2 = (sinh(x)-b*x)^2;

xi=[x0 x1 x2 x3];

syms x
f = sinh(x);
p = b*x;

plot(subs(f,x,-2:.001:2),subs(x,x,-2:.001:2),'r-',subs(p,x,-2:.001:2),subs(x,x,-2:.001:2),'b-')


%errors
linf = max(abs(subs((f-p),x,-2,.001:2)))
l2 = sqrt(int((f-p).^2,-2,2))

%% part d.)

syms x

f =sinh(x);

%establish legendre bases to n=3 in phi cell array
phi = {1;x;(1/2)*(3*x^2-1)};

%calculate polynomial using orthoganilization procedure described in notes
%seems very similar to gram-schmidt
p = 0;
for i=1:3
    p = p + phi{i}*(int(f*phi{i},-2,2)/int(sym(phi{i}*phi{i}),-2,2))
end


pnice=vpa(p,4)


%errors
linf = max(abs(subs(f-p,x,-2:0.001:2)))
l2 = eval(sqrt(int((f-p)^2,-2,2)))




