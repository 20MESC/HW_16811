% Import Data
pos2d = importdata('2d_positive_class.txt');
neg2d = importdata('2d_negative_class.txt');
x=[pos2d ; neg2d];
y=[ones(length(pos2d),1) ; -1*ones(length(neg2d),1) ];

% Set Parameters
C = 1;

% Call SVM solver
[w,b] = svmSolver(x',y',C);


figure; hold on;

subplot(1,3,1)
hold on
plot(pos2d(:,1),pos2d(:,2),'rx');
plot(neg2d(:,1),neg2d(:,2),'bd');

%center db
db_x=linspace(-5,5);
db_y=(-(w(1)/w(1))*db_x) +b;
plot(db_x,db_y,'r-');

%db+1
db_x=linspace(-5,5);
db_y=(-(w(1)/w(1))*db_x) +b -1;
plot(db_x,db_y,'c-');

%db-1
db_x=linspace(-5,5);
db_y=(-(w(1)/w(1))*db_x) +b +1;
plot(db_x,db_y,'m-');
axis([-5 5 -5 5])


% New Parameter
C = 0.1;

% Call SVM solver
[w,b] = svmSolver(x',y',C);

subplot(1,3,2)
hold on
plot(pos2d(:,1),pos2d(:,2),'rx');
plot(neg2d(:,1),neg2d(:,2),'bd');

%center db
db_x=linspace(-5,5);
db_y=(-(w(1)/w(1))*db_x) +b;
plot(db_x,db_y,'r-');

%db+1
db_x=linspace(-5,5);
db_y=(-(w(1)/w(1))*db_x) +b -1;
plot(db_x,db_y,'c-');

%db-1
db_x=linspace(-5,5);
db_y=(-(w(1)/w(1))*db_x) +b +1;
plot(db_x,db_y,'m-');
axis([-5 5 -5 5])


% New Parameter
C = 0.01;

% Call SVM solver
[w,b] = svmSolver(x',y',C);

subplot(1,3,3)
hold on
plot(pos2d(:,1),pos2d(:,2),'rx');
plot(neg2d(:,1),neg2d(:,2),'bd');

%center db
db_x=linspace(-5,5);
db_y=(-(w(1)/w(1))*db_x) +b;
plot(db_x,db_y,'r-');

%db+1
db_x=linspace(-5,5);
db_y=(-(w(1)/w(1))*db_x) +b -1;
plot(db_x,db_y,'c-');

%db-1
db_x=linspace(-5,5);
db_y=(-(w(1)/w(1))*db_x) +b +1;
plot(db_x,db_y,'m-');
axis([-5 5 -5 5])



%% 
hw_data_neg = load('handwriting_negative_class.txt');
hw_data_pos = load('handwriting_positive_class.txt');
hw_data = [hw_data_neg ; hw_data_pos];
y = [-1*ones(size(hw_data_neg,1),1) ; ones(size(hw_data_pos,1),1)];

indices = crossvalind('Kfold',y,10);
cp = classperf(y);
for i = 1:10
    test = (indices == i); train = ~test;
    class = classify(hw_data(test,:),hw_data(train,:),y(train,:));
    classperf(cp,class,test)
end
cp.ErrorRate


%%
load fisheriris                              %# load iris dataset
groups = ismember(species,'setosa');         %# create a two-class problem

%# number of cross-validation folds:
%# If you have 50 samples, divide them into 10 groups of 5 samples each,
%# then train with 9 groups (45 samples) and test with 1 group (5 samples).
%# This is repeated ten times, with each group used exactly once as a test set.
%# Finally the 10 results from the folds are averaged to produce a single 
%# performance estimation.
k=10;

cvFolds = crossvalind('Kfold', groups, k);   %# get indices of 10-fold CV
cp = classperf(groups);                      %# init performance tracker

for i = 1:k                                  %# for each fold
    testIdx = (cvFolds == i);                %# get indices of test instances
    trainIdx = ~testIdx;                     %# get indices training instances

    %# train an SVM model over training instances
    svmModel = svmtrain(meas(trainIdx,:), groups(trainIdx), ...
                 'Autoscale',true, 'Showplot',false, 'Method','QP', ...
                 'BoxConstraint',2e-1, 'Kernel_Function','rbf', 'RBF_Sigma',1);

    %# test using test instances
    pred = svmclassify(svmModel, meas(testIdx,:), 'Showplot',false);

    %# evaluate and update performance object
    cp = classperf(cp, pred, testIdx);
end



