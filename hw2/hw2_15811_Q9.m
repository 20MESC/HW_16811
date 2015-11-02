close all
clear
clc
load paths.txt
hold on

% 49 paths with 50 points each
% paths(1,1),paths(2,1) is (x,y) for t=0

start_1 = [0.8, 1.8];
start_2 = [2.2, 1.0];
start_3 = [2.7, 1.4];
dest = [8, 8];


% Plot All Paths
% n=49;%3 of paths to plot (49 total)
% for i = 1:2:(n*2)
% plot(paths(i,:),paths(i+1,:),'--')
% end
    

% Create Ring of Fire
t = 0:pi/30:2*pi;
r = 1.5;
x_cc = 5;
y_cc = 5;
xc = x_cc + r*cos(t);
yc = y_cc + r*sin(t);
plot(xc,yc,'r');

% Select which paths we want to use, (note each path takes into account x
% and y coords within paths.txt so there are 49 total
pathAnum=4;
pathBnum=5;
pathCnum=6;

a=pathAnum*2;
b=pathBnum*2;
c=pathCnum*2;

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
u = preIntrpP(1,1):.01:8;
deg = 4 %degree of interpolating polynomial + 1
indices = ceil(linspace(1,length(preIntrpP),deg)); 

x=preIntrpP(1,indices);
y=preIntrpP(2,indices);

%could also use built-in interp1 function
v = polyinterp(x,y,u);
plot(x,y,'o',u,v,'b-')



%t must be from 0 to 49








