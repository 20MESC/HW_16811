a = [7 7 9 9; -2 0 0 -2];
b = [0 0 2; 0 2 0];

b_flip = -b;

% Plot all polygon vertices
plot(a(1,:),a(2,:),'ro')
axis([-5 10 -5 10])
hold on;

plot(b(1,:),b(2,:),'bo')

mkSum_intm = [];
for i = 1:length(a)
    for j = 1:length(b)
        mkSum_intm = [mkSum_intm a(:,i)+b_flip(:,j)];
    end
end

mkSum = convexHull(mkSum_intm);


% Plot all polygon edges
nV = size(mkSum,2);
plot(mkSum(1,:),mkSum(2,:),'g-')
plot([mkSum(1,nV) mkSum(1,1)],[mkSum(2,nV) mkSum(2,1)],'g-')