%% part a.)

[x,y] = meshgrid(-2:.2:2, -2:.2:2);
z=(x.^3)+(y.^3)-(2.*x.^2)+(3.*y.^2)-8

surf(x,y,z);

%roots for df/dx=0
a = solve('3*x^2-4*x=0','x');

%roots for df/dy=0
b = solve('3*y^2+6*y=0','y');

hold on
plot3(a(1),b(1),-7,'ro')
plot3(a(1),b(2),-7,'ro')
plot3(a(2),b(1),-7,'ro')
plot3(a(2),b(2),-7,'ro')

syms x y z
z=(x.^3)+(y.^3)-(2.*x.^2)+(3.*y.^2)-8


%% part b.)

syms t

diff(simplify(((1+t)^3)+((-1+3*t)^3)-(2*(1+t)^2)+(3*(-1+3*t)^2)-8),t)

solve('84*t^2 + 2*t - 10=0',t)