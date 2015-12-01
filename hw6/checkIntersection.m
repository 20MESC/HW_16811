function [isIntersecting] = checkIntersection(A,B,C,D)
% Check to see if line segments AB and CD are properly intersecting
% INPUTS: points A,B,C,D each with (X,Y) coordinates
% OUTPUTS: boolean giving whether there is an intersection or not

Ax = A(1,1);
Ay = A(2,1);
Bx = B(1,1);
By = B(2,1);
Cx = C(1,1);
Cy = C(2,1);
Dx = D(1,1);
Dy = D(2,1);

isInersecting = A


(AB × BC) * (AB × BD) < 0  and
        (CD × DA) * (CD × DB) < 0:
        return True
        
end