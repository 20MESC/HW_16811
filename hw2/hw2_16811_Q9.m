close all
clear
clc
load paths.txt
hold on

% 49 paths with 50 points each
% paths(1,1),paths(2,1) is (x,y) for t=0

start_1 = [0.8; 1.8];
start_2 = [2.2; 1.0];
start_3 = [2.7; 1.4];
dest = [8; 8];

axis([0 12.5 0 12.5])

% % Show all path starting points
% for i=1:2:size(paths,1)
%     plot(paths(i,1),paths(i+1,1

% Create Ring of Fire
    t = 0:pi/30:2*pi;
    r = 1.5;
    x_cc = 5;
    y_cc = 5;
    xc = x_cc + r*cos(t);
    yc = y_cc + r*sin(t);
    plot(xc,yc,'r');

    % % Plot All Paths
    % n=49;%3 of paths to plot (49 total)
    % for i = 1:2:(n*2)
    %     plot(paths(i,:),paths(i+1,:),'--')
    % end

    % % Decision boundary line
    % x=linspace(0,8);
    % y=x;
    % plot(y,x,'r-');



% Get points that have shortest L2 norm (Euclidian distance) to start position, save those
% indices, these points will form the vertices of our triangle and will be
% the starting points for each of the three paths we will interpolate from
for start = [start_1 start_2 start_3]
    first=9999;
    firsti=0;
    second=9999;
    secondi=0;
    third=9999;
    thirdi=0;
    for i=1:2:size(paths,1) 
        %calculate L2 norm
        L2 = norm(start-paths(i:i+1,1));
        if(L2<first)
            third=second;
            second=first;
            first=L2;

            thirdi=secondi;
            secondi=firsti;
            firsti=i;

        elseif(L2<second)
            third=second;
            second=L2;

            thirdi=secondi;
            secondi=i;

        elseif(L2<third)
            third=L2;

            thirdi=i;

        end
    end

    % Plot starting point and selected starting triangle
    plot(start(1),start(2),'go');
    plot(paths(firsti,1),paths(firsti+1,1),'ro',paths(secondi,1),paths(secondi+1,1),'ro',paths(thirdi,1),paths(thirdi+1,1),'ro')

    % Select which paths we want to use, (note each path takes into account x
    % and y coords within paths.txt so there are 49 total
    a=firsti+1;
    b=secondi+1;
    c=thirdi+1;


    % Plot the selected paths
    plot(paths((a-1),:),paths(a,:),'c')
    plot(paths((b-1),:),paths(b,:),'y')
    plot(paths((c-1),:),paths(c,:),'g')



    preIntrpP = []; %preinterpolated polynomial (just sampling points)
    % Go through each timestep for three paths and find center of triangle.
    % Create 1 preinterpolated polynomial based upon avg. of 3 paths
    for t = 1:1:50
        [xnew ynew] = getTriCenter([paths(a-1,t), paths(b-1,t), paths(c-1,t)],  [paths(a,t), paths(b,t), paths(c,t)]);;
        preIntrpP = [preIntrpP [xnew;ynew]];
    end


    % Put preinterpolated points into interpolation routine. 

    %decided to go with built-in spcrv (creates a nice spline curve given the
    %points and an order)
    %after trial and error, 4th order worked nicely
    %v = polyinterp(x,y,u);
    intrpP=spcrv(preIntrpP,4,10000);%this

    %plot interpolated curve
    plot(intrpP(1,:),intrpP(2,:),'b-')
end


%t must be from 0 to 49








