setOfPoints = [1 3 5 7 4 3 2 7 2; 3 5 1 4 6 4 2 3 6];

plot(setOfPoints(1,:),setOfPoints(2,:),'ro');
axis([-3 10 -3 10]);

L = convexHull(setOfPoints);




hold on;
plot(L(1,:),L(2,:),'bo');
