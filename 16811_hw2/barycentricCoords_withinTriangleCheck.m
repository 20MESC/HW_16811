clear
clc
close all
hold on
%define x and y coord vectors for vertices of triangle
vx=[-4 -4 3];
vy=[-4 3 3];
%point to check
checkPt=[3 2];

axis([-5 5 -5 5])
plot(vx,vy,'bo');
plot(vx,vy);
plot([vx(3) vx(1)],[vy(3),vy(1)]);
plot(checkPt(1),checkPt(2),'ro');

%Barycentric Coords
A=[vx;vy;ones(1,3)];
b=[checkPt(1); checkPt(2); 1];

v=A\b
%Essentially, if any value of v is 0, the coord is on the edge of the
%triangle. If any value of v is neg, the coord is outside the triangle
