function [edges,nodes] = visibilityGraph(polygon_struct)
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


%%%%%%%%%Create Nodes List%%%%%%%%%%%

n=size(polygon_struct,2);
% for all polygons P in set S
for i =1:n
    % for all vertices v within polygon P
    m = size(polygon_struct(i).v,2);
    for j = 1:m
        % create a separate node for each vertex v in P
        nodes(i,j).v = polygon_struct(i).v(:,j);
        % nodes remember which polygon they were from
        nodes(i,j).P = polygon_struct(i).P;
        % give each node default visibility to the edges it is a component
        % of (i.e. its neighbor vertices)
        if m == 1 %if there is only one vertex, we are dealing with start or end point
            % it has no neighbor vertices on its own 'polygon' so do nothing
        elseif j == m % if we have the last vertex in the cycle, give it the first as a visible partner
            nodes(i,j).visible = [nodes(i,j).visible polygon_struct(i).v(:,1)];
            nodes(i,j).visible = [nodes(i,j).visible polygon_struct(i).v(:,j-1)];
        elseif j == 1 % if we have the first vertex in the cycle, give it the last as a visible partner
            nodes(i,j).visible = [nodes(i,j).visible polygon_struct(i).v(:,j+1)];
            nodes(i,j).visible = [nodes(i,j).visible polygon_struct(i).v(:,m)];
        else
            nodes(i,j).visible = [nodes(i,j).visible polygon_struct(i).v(:,j+1)];
            nodes(i,j).visible = [nodes(i,j).visible polygon_struct(i).v(:,j-1)];
        end
    end
      
end

%%%%%%%%%Create Edges List%%%%%%%%%%%

% create a struct which holds all edges
edges = struct('v1',[],'v2',[]);


for i =1:n
    % for all vertices v within polygon P
    m = size(polygon_struct(i).v,2);
    for j = 1:m
        if j == m % if we have the last vertex in the cycle, give it the first as a visible partner
            edges(i,j).v1 = polygon_struct(i).v(:,j);
            edges(i,j).v2 = polygon_struct(i).v(:,1);
        else
            edges(i,j).v1 = polygon_struct(i).v(:,j);
            edges(i,j).v2 = polygon_struct(i).v(:,j+1);
        end
    end  
end


%%%%%% now we will do the pairwise checking %%%%%%%%%%%

% for each polygon P
for i =1:n
    % for each vertex v within polygon P
    m = size(polygon_struct(i).v,2);
    for j = 1:m
        
        % for each vertex
        nNodes = size(nodes,1)*size(nodes,2);
        for k =1:nNodes
            if ~(isempty(nodes(k).v)) && nodes(k).P ~= i %ensure the node is there and it is not a member of the same polygon being checked
                % got pairs
                %[polygon_struct(i).v(:,j) nodes(k).v]
                
                % now we must check them against ALL edges
                visibilityBlocked = 0; % start with this assumption
                nEdges = size(edges,1)*size(edges,2);
                for h = 1:nEdges
                    if ~(isempty(edges(h).v1))
                        % the two sets of pairs we need to check for intersection
                        %[polygon_struct(i).v(:,j), nodes(k).v, edges(h).v1, edges(h).v2]
                        if checkIntersection(polygon_struct(i).v(:,j), nodes(k).v, edges(h).v1, edges(h).v2)
                            visibilityBlocked = 1;
                        end     
                    end
                end
                
                % if after all edges checked for a specific vertex, visibility is still unblocked
                if ~visibilityBlocked
                    % add current node being checked as partner to visibility for the (i,j)th node 
                    % - (corresponds to ith polgyon and jth vertex)
                    nodes(i,j).visible = [nodes(i,j).visible nodes(k).v];
                    %disp('node added')
                end
            end
        end
    end
      
end





end