%%%%%%%%% Create map %%%%%%%%%%%%

poly_struct = struct('v',[],'P',[]);


poly_struct(1).v = [2 0 4 10 7; 2 6 10 7 3];
poly_struct(1).P = 1;
poly_struct(2).v = [7 7 9 9; -2 0 0 -2];
poly_struct(2).P = 2;
poly_struct(3).v = [22 20 24 30 27; 2 6 10 7 3];
poly_struct(3).P = 3;
poly_struct(4).v = [12 10 14 20 17; 22 26 30 27 23];
poly_struct(4).P = 4;
poly_struct(5).v = [12 17 26 23;12 15 15 12];
poly_struct(5).P = 5;

%start
poly_struct(6).v = [-3;-3];
poly_struct(6).P = 6;
%end
poly_struct(7).v = [33;33];
poly_struct(7).P = 7;



%%%%%%%%%%% Generate Graph %%%%%%%%%%%%%%

% get list of nodes and which nodes are visible to each node
[edges, nodes] = visibilityGraph(poly_struct);

% actually create visibility arcs (yes I know this should technically be
% built into the visibility graph function)
visArcs = struct('v1',[],'v2',[],'ID1',[],'ID2',[],'weight',[]);

% dummy values for first iteration
visArcs(1).v1 = [1000;1000];
visArcs(1).v2 = [-1000;-1000];

nNodes = size(nodes,1)*size(nodes,2);
count = 1;
for i = 1:nNodes
    nVisNodes = size(nodes(i).visible,2);
    for j = 1:nVisNodes
        exists = 0; %for each node and for each of its visible nodes, assume this pair doesnt exist in vsArc yet
        nVisArcs = size(visArcs,2);
        for k = 1:nVisArcs %run through all existing vis arcs
            % if an arc doesnt already exist between the two points being checked
            cond1 = isequal(visArcs(k).v1, nodes(i).v);
            cond2 = isequal(visArcs(k).v2, nodes(i).visible(:,j));
            cond3 = isequal(visArcs(k).v2, nodes(i).v);
            cond4 = isequal(visArcs(k).v1, nodes(i).visible(:,j));
            if (cond1 && cond2) || (cond3 && cond4)
                exists = 1;
            end
        end
        
        if exists == 0
            % create new arc
            visArcs(count).v1 = nodes(i).v;
            visArcs(count).ID1 = i
            visArcs(count).v2 = nodes(i).visible(:,j);
            idx = [nodes.v] ==  repmat(nodes(i).visible(:,j),[1,length(nodes)]); % eww
            
            % looking through matches from idx to see where there is a
            % [1;1] .... i know its terrible
            match = NaN; % intialize. should never get an ID2 with NaN
            for k = 1: size(idx,2)
                if idx(1,k) == 1 && idx(2,k) == 1
                    match = k;
                end
            end
            
            visArcs(count).ID2 = match
            % sorry to anyone reading this code, trying to understand it
            
            % also generate weight for arc (euclidian length)
            visArcs(count).weight = norm(visArcs(count).v1-visArcs(count).v2);
            
            count = count + 1; % increment count for # of arcs

        end
    end
end

% create adjacency matrix form for input to dijkstras
W = [visArcs.weight];
DG = sparse([visArcs.ID1],[visArcs.ID2],W,length(nodes),length(nodes));
UG = tril(DG + DG')

%h = view(biograph(UG,[],'ShowArrows','off','ShowWeights','on'))


%%%%%%%%% Find Shortest Path %%%%%%%%%%%
[dist,path,pred] = graphshortestpath(UG,length(nodes)-1,length(nodes),'directed',false);

%set(h.Nodes(path),'Color',[1 0.4 0.4])
%fowEdges = getedgesbynodeid(h,get(h.Nodes(path),'ID'));
%revEdges = getedgesbynodeid(h,get(h.Nodes(fliplr(path)),'ID'));
%edges = [fowEdges;revEdges];
%set(edges,'LineColor',[1 0 0])
%set(edges,'LineWidth',1.5)



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%% Plotting %%%%%%%%%%%%%%%%%%

% Plot all polygon vertices
plot(poly_struct(1).v(1,:),poly_struct(1).v(2,:),'ro')
axis([-5 35 -5 35])
hold on;


% Plot all visibility graph arcs
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

% Plot shortest path
for i = 1:size(path,2)-1
    

    % plot edges
    plot([nodes(path(i)).v(1,:) nodes(path(i+1)).v(1,:)],[nodes(path(i)).v(2,:) nodes(path(i+1)).v(2,:)],'r-');
 
end



