function [ vertsOnConvHull ] = convexHull(setOfPoints)
% INPUTS: a set of 2D points (x,y) belonging to {X,Y}
% OUTPUT: a list containing the vertices (xi,yi) in clockwise order of the
% minimal convex hull formed by the outer most points from the input set
    n = length(setOfPoints);
    
    % 1. Sort points by x-coordinate
    [x_sorted, idx_sort] = sort(setOfPoints(1,:));   
    y_sorted = setOfPoints(2,idx_sort);
    sorted = [x_sorted; y_sorted];
    
    % 2. Put points p1 and p2 in list Lupper with p1 as first point
    L_upper = sorted(:,1:2);
    
    %for i=3 to n
    for i=3:n
        % 4. Append pi to L_upper
        L_upper = [ L_upper , sorted(:,i)];
        
        % 5. While L_upper contains more than two points and the last three
        % points in L_upper do not make a right turn
        nLup = size(L_upper,2); % number of points in L_upper
        while ( nLup > 2 ) && ~(rightTurn(L_upper(:,nLup-2),L_upper(:,nLup-1),L_upper(:,nLup)))
            % 6. Delete the middle of the last three points from Lupper
            L_upper = [L_upper(:,1:(nLup-2)) L_upper(:,nLup)]
            nLup = size(L_upper,2); % number of points in L_upper
        end
        
    end




end



% 4. do Append pi
% to Lupper.
% 5. while Lupper contains more than two points and the last three points in Lupper do
% not make a right turn
% 6. do Delete the middle of the last three points from Lupper.
% 7. Put the points pn and pn?1 in a list Llower, with pn as the first point.
% 8. for i ? n?2 downto 1
% 9. do Append pi
% to Llower.
% 10. while Llower contains more than 2 points and the last three points in Llower do not
% make a right turn
% 11. do Delete the middle of the last three points from Llower.
% 12. Remove the first and the last point from Llower to avoid duplication of the points where the
% upper and lower hull meet.
% 13. Append Llower to Lupper, and call the resulting list L.
% 14. return L