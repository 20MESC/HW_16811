function [ isInside ] = checkInsideTri(vert1,vert2,vert3,toCheck)
%returns whether point toCheck is inside trinagle defined by vertices 1,2,3
%vert1,2,3 and toCheck should be of the form [x;y]

A=[[vert1(1) vert2(1) vert3(1)]; [vert1(2) vert2(2) vert3(2)] ;ones(1,3)];
b=[toCheck(1);toCheck(2);1]; %equal weights give center

v=A\b;

isInside = (v(1)>=0 && v(2)>=0 && v(3)>=0);


end

