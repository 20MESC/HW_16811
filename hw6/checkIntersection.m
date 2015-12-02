function [isIntersecting] = checkIntersection(A,B,C,D)
% Check to see if line segments AB and CD are properly intersecting
% INPUTS: points A,B,C,D each with (X,Y) coordinates
% OUTPUTS: boolean giving whether there is an intersection or not
% If lines are colinear in any way or T-intersecting, but not crossing each
% other, this function will still return False.

Ax = A(1,1);
Ay = A(2,1);
Bx = B(1,1);
By = B(2,1);
Cx = C(1,1);
Cy = C(2,1);
Dx = D(1,1);
Dy = D(2,1);

CAcrsCD = (Ax-Cx)*(Dy-Cy)-(Ay-Cy)*(Dx-Cx);
CBcrsCD = (Bx-Cx)*(Dy-Cy)-(By-Cy)*(Dx-Cx);
ACcrsAB = (Cx-Ax)*(By-Ay)-(Cy-Ay)*(Bx-Ax);
ADcrsAB = (Dx-Ax)*(By-Ay)-(Dy-Ay)*(Bx-Ax);

if CAcrsCD*CBcrsCD < 0 && ACcrsAB*ADcrsAB < 0
    isIntersecting = 1;
else
    isIntersecting = 0;
end



end