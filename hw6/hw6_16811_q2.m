%nodes(1).visible(1).v
%nodes(1).visible(2).v

poly_struct = struct('v',[]);
%poly_struct(1).v = [2 2 7 7; 1 7 7 1];
poly_struct(1).v = [2 0 4 10 7; 2 6 10 7 3];

plot(poly_struct(1).v(1,:),poly_struct(1).v(2,:),'ro')
axis([-2 15 -2 15])
hold on;

% Plot the edges of an arbitrary polygon
nV = size(poly_struct(1).v,2);
plot(poly_struct(1).v(1,:),poly_struct(1).v(2,:),'g-');
plot([poly_struct(1).v(1,nV) poly_struct(1).v(1,1)],[poly_struct(1).v(2,nV) poly_struct(1).v(2,1)],'g-')

[nodes] = visibilityGraph(poly_struct)