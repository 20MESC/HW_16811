%setOfPoints = [1 3 5 7 4 3 2 7 2; 3 5 1 4 6 4 2 3 6];
setOfPoints = [1 3 5 7 4 3 2 7 2; 3 5 1 4 6 4 2 3 6];

plot(setOfPoints(1,:),setOfPoints(2,:),'ro');
axis([-3 10 -3 10]);


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

hold on;
plot(L_upper(1,:),L_upper(2,:),'bo');


