function [isRightTurn] = rightTurn(point_nminus2,point_nminus1,point_n)
% INPUTS: 3 2D points (n-2, n-1, n)
% OUTPUT: a boolean indicating whether the points in the order n-2,n-2,n
% form a right turn (returns false if they are all colinear)

%point_n   : B
%point_n-1 : C
%point_n-2 : A

Ax = point_n(1);
Ay = point_n(2);
Cx = point_nminus1(1);
Cy = point_nminus1(2);
Bx = point_nminus2(1);
By = point_nminus2(2);


result = sign(det([Bx-Ax, By-Ay ; Cx-Ax, Cy-Ay]));

if result < 0
    isRightTurn = true;
else
    isRightTurn = false;
end