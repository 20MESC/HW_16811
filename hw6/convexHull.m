function [ L ] = convexHull(setOfPoints)
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
    
    % 3. for i=3 to n
    for i=3:n
        % 4. Append pi to L_upper
        L_upper = [ L_upper , sorted(:,i)];
        
        % 5. While L_upper contains more than two points and the last three
        % points in L_upper do not make a right turn
        nLup = size(L_upper,2); % number of points in L_upper
        while ( nLup > 2 ) && ~(rightTurn(L_upper(:,nLup-2),L_upper(:,nLup-1),L_upper(:,nLup)))
            % 6. Delete the middle of the last three points from Lupper
            L_upper = [L_upper(:,1:(nLup-2)) L_upper(:,nLup)];
            nLup = size(L_upper,2); % number of points in L_upper
        end
        
    end
    
    % 7. Put points pn and pn-1 in a list Llower with pn as first point
    L_lower = [sorted(:,n) sorted(:,n-1)];
    
    %%%%SPECIAL MODIFICATION%%%%%
    % reverse sort the y values for any points with identical x values for
    % lower traversal
    %L_lower = sortByYDescend(L_lower);
    
    % 8. for i=n-2 downto 1
    for i=n-2:-1:1
        % 9. Append pi to L_lower
        L_lower = [ L_lower , sorted(:,i)];
        
        % 10. While L_lower contains more than two points and the last three
        % points in L_lower do not make a right turn
        nLow = size(L_lower,2); % number of points in L_upper
        while ( nLow > 2 ) && ~(rightTurn(L_lower(:,nLow-2),L_lower(:,nLow-1),L_lower(:,nLow)))
            % 11. Delete the middle of the last three points from Lupper
            L_lower = [L_lower(:,1:(nLow-2)) L_lower(:,nLow)];
            nLow = size(L_lower,2); % number of points in L_upper
        end
        
    end
    
    % 12. Remove the first and last point from L_lower to avoid duplication
    % of the points where the upper and lower hull meet.
    nLow = size(L_lower,2); % number of points in L_upper
    L_lower = L_lower(:,2:nLow-1);
    
    % 13. Append L_lower to L_upper and call the resulting list L
    L = [L_upper L_lower];
    
   

end