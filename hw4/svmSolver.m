function [w,b,a] = svmSolver(x, y, C)

% Setup some variables
num_labels = length(x);
a = zeros(num_labels, 1);



% Optimization to find argmax w.r.t. a and a_hat
cvx_begin
    variables a(num_labels)
    
    maximize( sum(a) - (1/2)*sum(sum((a'*a).*(y'*y).*(x'*x))) )
    subject to;
        a'*y' == 0;
        0 + eps <= a;
        a <= C - eps;
cvx_end

% calculate weight vector w
w = zeros(size(x,1),1);
for i=1:num_labels
    w = w + ( a(i)*y(i)*x(:,i) );
end
% sum over all labels, get w = [ w1 ]
%                              [ w2 ]
%                              [ w3 ]
%                                 .
%                                 .


% calculate intercept b
select_i = randi(num_labels);
b = ( 1/y(select_i) ) - ( dot(w,x(:,select_i)));


    
end