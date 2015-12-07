setOfPoints = [1 3 5 0 6 2 5 1 4 5 6 2 3 8 9 3 2 4 5 6 7 8 8 10 11 1;...
               3 5 1 8 6 4 2 3 6 2 4 5 6 8 7 5 1 5 4 5 13 13 5 3 1 7];

plot(setOfPoints(1,:),setOfPoints(2,:),'ro');
axis([-3 15 -3 15]);

L = convexHull(setOfPoints);




hold on;
plot(L(1,:),L(2,:),'bo');

plot(L(1,:),L(2,:),'b-');
plot([L(1,length(L)) L(1,1)], [L(2,length(L)) L(2,1)],'b-');

