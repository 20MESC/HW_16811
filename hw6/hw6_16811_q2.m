
poly_struct = struct('v',[],'P',[]);
%poly_struct(1).v = [2 2 7 7; 1 7 7 1];
poly_struct(1).v = [2 0 4 10 7; 2 6 10 7 3];
poly_struct(1).P = 1;
poly_struct(2).v = [7 7 9 9; -2 0 0 -2];
poly_struct(2).P = 2;
poly_struct(3).v = [22 20 24 30 27; 2 6 10 7 3];
poly_struct(3).P = 3;
poly_struct(4).v = [12 10 14 20 17; 22 26 30 27 23];
poly_struct(4).P = 4;

plot(poly_struct(1).v(1,:),poly_struct(1).v(2,:),'ro')
axis([-5 35 -5 35])
hold on;

[edges, nodes] = visibilityGraph(poly_struct)

% plot all visibility graph arcs
nNodes = size(nodes,1)*size(nodes,2);
for i = 1:nNodes
    for j = 1:size(nodes(i).visible,2)
        % plot edges
        plot([nodes(i).v(1,1) nodes(i).visible(1,j)], [nodes(i).v(2,1) nodes(i).visible(2,j)],'b-');
    end
end

% Plot all polygon edges
for i = 1:size(poly_struct,2)
    % plot vertices
    plot(poly_struct(i).v(1,:),poly_struct(i).v(2,:),'ro')
    nV = size(poly_struct(i).v,2);
    % plot edges
    plot(poly_struct(i).v(1,:),poly_struct(i).v(2,:),'g-');
    plot([poly_struct(i).v(1,nV) poly_struct(i).v(1,1)],[poly_struct(i).v(2,nV) poly_struct(i).v(2,1)],'g-')
end