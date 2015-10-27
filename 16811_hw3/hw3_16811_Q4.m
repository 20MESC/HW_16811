%% part a.)
clf;
hold on;

%load data
D = load('clear_table.txt');

%visualize point cloud
scatter3(D(:,1),D(:,2),D(:,3), 10, 'filled');

%calculate least squares approximation plane coefficients
c = D\ones(size(D,1),1)

%generate x,y grid
axis([-1.5 1.5 .25 .55 1.5 2.5])
[x y] = meshgrid(-1.5:0.5:2)

%generate surface from x,y grid
z = (1 - c(1)*x - c(2)*y)/c(3);

%plot surface
mesh(x,y,z)

%find avg. distance of point in dataset to plane
%|ax0+by0+cz0+d|/(sqrt(a^2+b^2+c^2))
%found on http://mathworld.wolfram.com/Point-PlaneDistance.html
avg_distance = sum(abs(c(1)*D(:,1)+c(2)*D(:,2)+c(3)*D(:,3)-1)/(sqrt(c(1)^2+c(2)^2+c(3)^2)))/length(D)


%% part b.)

clf;
hold on;

%load data
D = load('cluttered_table.txt');

%visualize point cloud
scatter3(D(:,1),D(:,2),D(:,3),10,'filled');

%compute least-squared plane coefficients
c = D\ones(size(D,1),1)

%generate x,y grid
axis([-1.5 1.5 .25 .55 1.5 2.5]);
[x y] = meshgrid(-1.5:0.5:2);

%generate surface from grid
z = (1 - c(1)*x - c(2)*y)/c(3);

%plot surface
mesh(x,y,z)

%% part c.)

clf;
hold on;

%load data
D = load('cluttered_table.txt');

%visualize data point cloud
scatter3(D(:,1),D(:,2),D(:,3), 10, 'filled');

%compute best model coefficients using 3D extension of commonly implemented RANSAC
%David A. Forsyth and Jean Ponce (2003). Computer Vision, a modern approach. Prentice Hall. ISBN 0-13-085198-1.
%These RANSAC parameters were gotten with much tweaking - please see
%RANSAC function for argument descriptions
[bestmodel] = ransac3D(D,100,6,.03,300);

%generate x,y grid
axis([-1.5 1.5 .25 .55 1.5 2.5])
[x y] = meshgrid(-1.5:0.5:2);

%generate surface from grid
z = (1 - bestmodel(1)*x - bestmodel(2)*y)/bestmodel(3);

%plot surface
mesh(x,y,z)

%% part d.)

clf;
hold on;

%load data
D = load('clean_hallway.txt');

%since we know the orientation of the data relative to where the "center"
%of the robot would be, we can "cut the data" into 4 chunks (each corresponding to a face)to make the
%data more ammenable to RANSAC
D_f1 = D((D(:,1)<0.5),:,:);
D_f2 = D((D(:,1)>2),:,:);
D_f3 = D((D(:,2)<0.5),:,:);
D_f4 = D((D(:,2)>2),:,:);

%visualize the data with a point cloud
scatter3(D(:,1),D(:,2),D(:,3), 10, 'filled');

%run RANSAC 4 times (once for each plane) using the same tweaking from c.)
[bestmodel_f1] = ransac3D(D_f1,20,6,.1,1000);
[bestmodel_f2] = ransac3D(D_f2,20,6,.1,1000);
[bestmodel_f3] = ransac3D(D_f3,20,6,.1,1000);
[bestmodel_f4] = ransac3D(D_f4,20,6,.1,1000);

%generate x,y grid
axis([-1 3 -1 3 1 3])
[x y] = meshgrid(-1:0.5:3);

%generate a surface for each face
z_f1 = (1 - bestmodel_f1(1)*x - bestmodel_f1(2)*y)/bestmodel_f1(3);
z_f2 = (1 - bestmodel_f2(1)*x - bestmodel_f2(2)*y)/bestmodel_f2(3);
z_f3 = (1 - bestmodel_f3(1)*x - bestmodel_f3(2)*y)/bestmodel_f3(3);
z_f4 = (1 - bestmodel_f4(1)*x - bestmodel_f4(2)*y)/bestmodel_f4(3);

%plot surfaces for each face
surf(x,y,z_f1,'FaceColor','red')
surf(x,y,z_f2,'FaceColor','green')
surf(x,y,z_f3,'FaceColor','cyan')
surf(x,y,z_f4,'FaceColor','magenta')

%% part e.)

clf;
hold on;

%load data
D = load('cluttered_hallway.txt');

%same reasoning as above
D_f1 = D((D(:,1)<-1),:,:);
D_f2 = D((D(:,1)>.8),:,:);
D_f3 = D((D(:,2)<0),:,:);
D_f4 = D((D(:,2)>.8),:,:);

%visualize the data with point cloud
scatter3(D(:,1),D(:,2),D(:,3), 10, 'filled');

%run RANSAC3D
[bestmodel_f1] = ransac3D(D_f1,20,6,.1,1000);
[bestmodel_f2] = ransac3D(D_f2,20,6,.1,1000);
[bestmodel_f3] = ransac3D(D_f3,20,6,.1,1000);
[bestmodel_f4] = ransac3D(D_f4,20,6,.1,1000);

%generate x,y grids. The red grid needed different bounds to be pleasing
%when graphically plotted
axis([-1 3 -1 3 1 3])
[x y] = meshgrid(-1:0.5:3);
[x1 y1] = meshgrid(-2:0.5:2);

%generate surfaces from x,y grids
z_f1 = (1 - bestmodel_f1(1)*x1 - bestmodel_f1(2)*y1)/bestmodel_f1(3);
z_f2 = (1 - bestmodel_f2(1)*x - bestmodel_f2(2)*y)/bestmodel_f2(3);
z_f3 = (1 - bestmodel_f3(1)*x - bestmodel_f3(2)*y)/bestmodel_f3(3);
z_f4 = (1 - bestmodel_f4(1)*x - bestmodel_f4(2)*y)/bestmodel_f4(3);

%plot surfaces
surf(x1,y1,z_f1,'FaceColor','red')
surf(x,y,z_f2,'FaceColor','green')
surf(x,y,z_f3,'FaceColor','cyan')
surf(x,y,z_f4,'FaceColor','magenta')

%measure some smoothness
avg_distance = sum(abs(bestmodel_f1(1)*D_f1(:,1)+bestmodel_f1(2)*D_f1(:,2)+bestmodel_f1(3)*D_f1(:,3)-1)/(sqrt(bestmodel_f1(1)^2+bestmodel_f1(2)^2+bestmodel_f1(3)^2)))/length(D_f1)
avg_distance = sum(abs(bestmodel_f2(1)*D_f2(:,1)+bestmodel_f2(2)*D_f2(:,2)+bestmodel_f2(3)*D_f2(:,3)-1)/(sqrt(bestmodel_f2(1)^2+bestmodel_f2(2)^2+bestmodel_f2(3)^2)))/length(D_f2)
avg_distance = sum(abs(bestmodel_f3(1)*D_f3(:,1)+bestmodel_f3(2)*D_f3(:,2)+bestmodel_f3(3)*D_f3(:,3)-1)/(sqrt(bestmodel_f3(1)^2+bestmodel_f3(2)^2+bestmodel_f3(3)^2)))/length(D_f3)
avg_distance = sum(abs(bestmodel_f4(1)*D_f4(:,1)+bestmodel_f4(2)*D_f4(:,2)+bestmodel_f4(3)*D_f4(:,3)-1)/(sqrt(bestmodel_f4(1)^2+bestmodel_f4(2)^2+bestmodel_f4(3)^2)))/length(D_f4)

