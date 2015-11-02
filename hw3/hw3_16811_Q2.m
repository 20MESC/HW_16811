
%Divide ninto two piecewise functions
%x
x = 0:.1:10;
x1=x(1:floor(length(x)/2)+1);
x2=x(ceil(length(x)/2)+1:length(x));
x1=x1';
x2=x2';

%f
f = load('problem2.txt');
f1=f(1:floor(length(f)/2)+1);
f2=f(ceil(length(f)/2)+1:length(f));
f1=f1';
f2=f2';

%polynomial bases
phi_11=ones(length(f1),1);
phi_21=x1;
phi_31=x1.^2;
phi_41=x1.^3;

phi_12=ones(length(f2),1);
phi_22=x2;
phi_32=x2.^2;
phi_42=x2.^3;

%construct bases matrix
A1=[phi_11 phi_21 phi_31 phi_41];
A2=[phi_12 phi_22 phi_32 phi_42];


%Previously using SVD, left for posterity
% [U S V] = svd(A);
%   
% 
%     %Follows form given in class
%     Sinv = zeros(size(S));
%     for i=1:min(size(S))
%         if S(i,i) > 0.0001
%             Sinv(i,i) = 1/S(i,i);
%         end
%     end

% c=V*Sinv'*U'*f;
% c=flipud(c)

%Do L-S 
c1=A1\f1
c2=A2\f2
    

hold on;
plot(x1,f1,'bo');
plot(x2,f2,'bo');

%calculate y values from coefficients (bsxfun - Thanks for the tip Dhruv)
y1=sum(bsxfun(@times,A1,repmat(c1',length(A1),1)),2);
y2=sum(bsxfun(@times,A2,repmat(c2',length(A2),1)),2);

%plot
plot(x1,y1,'r-');
plot(x2,y2,'r-');

%calculate error
norm([f1 ; f2] - [y1 ; y2],2)

%check with sample matrix
