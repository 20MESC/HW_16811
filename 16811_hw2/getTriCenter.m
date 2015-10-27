function [x y] = getTriCenter(vx,vy)
%Returns center by utilizing barycentric coord transform and
%weights of 1/3
A=[vx;vy;ones(1,3)];
v=[1/3;1/3;1/3]; %equal weights give center

b=A*v;
x=b(1);
y=b(2);

end

