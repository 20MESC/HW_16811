function [mkSum] = minkowskiSum(a,b)
% computes Minkowski sum for two convex polygons
% INPUTS : a, b - two sets of ordered points of the format [X;Y] which
% describe two convex polygons
% OUTPUT : mkSum - a single set of ordered points of the format [X;Y] which
% describes the Minkowski sum of the two convex polygons (also a conv.poly)


mkSum_intm = [];
for i = 1:size(a,2)
    for j = 1:size(b,2)
        mkSum_intm = [mkSum_intm a(:,i)+b(:,j)];
    end
end

mkSum = convexHull(mkSum_intm);

end
