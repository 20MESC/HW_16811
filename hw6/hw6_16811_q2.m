%nodes(1).visible(1).v
%nodes(1).visible(2).v

poly_struct = struct('v',[]);
%poly_struct(1).v = [2 2 7 7; 1 7 7 1];
poly_struct(1).v = [2 0 4 10 7; 2 6 10 7 3];
poly_struct(2).v = [7 7 9 9; -2 0 0 -2];

plot(poly_struct(1).v(1,:),poly_struct(1).v(2,:),'ro')
axis([-5 15 -5 15])
hold on;

% Plot the edges of an arbitrary polygon
for i = 1:size(poly_struct,2)
    % plot vertices
    plot(poly_struct(i).v(1,:),poly_struct(i).v(2,:),'ro')
    nV = size(poly_struct(i).v,2);
    % plot edges
    plot(poly_struct(i).v(1,:),poly_struct(i).v(2,:),'g-');
    plot([poly_struct(i).v(1,nV) poly_struct(i).v(1,1)],[poly_struct(i).v(2,nV) poly_struct(i).v(2,1)],'g-')
end

[nodes] = visibilityGraph(poly_struct)