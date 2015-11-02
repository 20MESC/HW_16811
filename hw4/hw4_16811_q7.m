% Import Data
pos2d = importdata('2d_positive_class.txt');
neg2d = importdata('2d_negative_class.txt');
x=[pos2d ; neg2d];
y=[ones(length(pos2d),1) ; -1*ones(length(neg2d),1) ];


% Setup parameters
eps = 10^-5;
num_l = length(y);
H=(x*x').*(y*y'); %put the Langrangian in the proper form for the quadratic program
f=-1*ones(num_l,1); % "
C=1; % variable upperbound
Aeq=y'; % constraint equation 'matrix'
beq=0;  % constraint equation coefficient vector
lb=eps*zeros(num_l,1);
ub=(C-eps)*ones(num_l,1);

% Do the Deed
alfs = quadprog(H,f,[],[],Aeq,beq,lb,ub,[], optimset('Algorithm', 'interior-point-convex', 'Display','off') );

% Calulate support vectors, w and b
indxs = find((alfs > (0 + eps)) & (alfs < (C - eps)));
svs = x(indxs,:);


% Plotting
w=svs'*(alfs(indxs).*y(indxs));
b=1./y(indxs) - svs*w;
b_avg = mean(b);

hold on
plot(pos2d(:,1),pos2d(:,2),'rx');
plot(neg2d(:,1),neg2d(:,2),'bd');
plot(svs(:,1),svs(:,2),'go');

%center db
db_x=linspace(-5,5);
db_y=(-(w(1)/w(1))*db_x) +b_avg;
plot(db_x,db_y,'r-');

%db+1
db_x=linspace(-5,5);
db_y=(-(w(1)/w(1))*db_x) +b_avg -1;
plot(db_x,db_y,'c-');

%db-1
db_x=linspace(-5,5);
db_y=(-(w(1)/w(1))*db_x) +b_avg +1;
plot(db_x,db_y,'m-');