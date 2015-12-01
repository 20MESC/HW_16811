function [nodes] = visibilityGraph(polygon_struct)
% INPUTS: A list of structures where each structure corresponds to a
% polygon (or a free vertex). The field v consists of a clockwise ordered
% list of the n vertices (X,Y) pairs in the polygon. Edges can be made by connecting v_i
% and v_i+1 as well as v_n and v_1. If there is only one vertex in the list
% v, then this is a free vertex. (start or end point for instance)
% OUTPUTS: The visibility graph Gvis(S) which is a collection of nodes
% consisiting of all vertices from the set S and their accompanying list of
% vertices which are visible to them

% establish structure of nodes which can hold value 'v' indicating the vertex
% and a list value 'visible' which will hold list of references to other nodes
% that are visible to v
nodes = struct('v',[],'visible',[]);


n=size(polygon_struct,2);
% for all polygons P in set S
for i =1:n
    % for all vertices v within polygon P
    m = size(polygon_struct(i).v,2);
    for j = 1:m
        % create a separate node for each vertex v in P
        nodes(i*j).v = polygon_struct(i).v(:,j);
        % give each node default visibility to the edges it is a component
        % of (i.e. its neighbor vertices)
        if j == m % if we have the last vertex in the cycle, give it the first as a visible partner
            nodes(i*j).visible = [nodes(i*j).visible polygon_struct(i).v(:,1)];
            nodes(i*j).visible = [nodes(i*j).visible polygon_struct(i).v(:,j-1)];
        elseif j == 1 % if we have the first vertex in the cycle, give it the last as a visible partner
            nodes(i*j).visible = [nodes(i*j).visible polygon_struct(i).v(:,j+1)];
            nodes(i*j).visible = [nodes(i*j).visible polygon_struct(i).v(:,m)];
        else
            nodes(i*j).visible = [nodes(i*j).visible polygon_struct(i).v(:,j+1)];
            nodes(i*j).visible = [nodes(i*j).visible polygon_struct(i).v(:,j-1)];
        end
    end
    
    
end






end