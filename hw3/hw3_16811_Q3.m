%% part a.)

T6=sym('32*x^6-48*x^4+18*x^2-1');
T7=sym('64*x^7-112*x^5+56*x^3-7*x');
inner=('(1-x^2)^(-1/2)');

int(inner*T6*T7,-1,1)

%% part b.)

f=sym('cos(n*t)^2');
g=sym('(1+cos(2*n*t))/2');

int(f,pi,2*pi);

sqrt(pi/2)

