%
%   15-811
%   HW1
%   Author: Rosario Scalise
%   Date: 9-12-15
%  

%   1.)
    %Test of algorithm
    A=[2 1 1; 3 6 -5; -7 7 9];
    
    [P L D U] = PLDU3(A);


%   2a.)
    A=[4 7 0; 2 2 -6; 1 2 1];

    %LDU
    [L U]=lu(A);
    D = diag(diag(U));
    U = D\U;

    %SVD
    [U S V] = svd(A);

%   2b.)
    A=[4 8 0 0; 2 0 -2 0; 0 4 -1 0; 0 -2 0 2; 0 0 2 -1]

    %LDU
    [L U]=lu(A);
    D = diag(diag(U));
    U = D\U;

    %SVD
    [U S V] = svd(A);

%   2c.)
    A=[2 2 5; 3 2 5; 1 1 5]

    %LDU
    [L U P]=lu(A);
    D = diag(diag(U));
    U = D\U;

    %SVD
    [U S V] = svd(A);
    
%   3a.)
    A=[2 1 3; 2 1 2; 5 5 5];
    b=[5; -5; 0];
    
    %SVD
    [U S V] = svd(A);
  
    %x= V*((U'*b)./diag(S));
    
    %Follows form given in class
    Sinv = zeros(size(S));
    for i=1:size(S,1)
        if S(i,i) > 0.0001
            Sinv(i,i) = 1/S(i,i);
        end
    end
    x=V*Sinv*U'*b
    
    
%   3b.)
    A=[4 7 0; 2 2 -6; 1 2 1];
    b=[3; 5; 1];
    
    %SVD for A
    [U S V] = svd(A);
  
    Sinv = zeros(size(S));
    for i=1:size(S,1)
        if S(i,i) > 0.0001
            Sinv(i,i) = 1/S(i,i);
        end
    end
    x=V*Sinv*U'*b; 
    
    A*x; %gives b of [3.2429; 4.8780; .2683] not far off...
    
    %SVD for augmented matrix [A b]
    [U S V] = svd([A b]);
  
    Sinv = zeros(size(S));
    for i=1:size(S,1)
        if S(i,i) > 0.0001
            Sinv(i,i) = 1/S(i,i);
        end
    end
    
  
%   3c.)
    A=[4 7 0; 2 2 -6; 1 2 1];
    b=[18; -12; 8];
    
    %SVD for A
    [U S V] = svd(A);
  
    Sinv = zeros(size(S));
    for i=1:size(S,1)
        if S(i,i) > 0.0001
            Sinv(i,i) = 1/S(i,i);
        end
    end
    x=V*Sinv*U'*b;%SVD solution
    
    %SVD for augmented matrix [A b]
    [U S V] = svd([A b]);
  
    Sinv = zeros(size(S));
    for i=1:size(S,1)
        if S(i,i) > 0.0001
            Sinv(i,i) = 1/S(i,i);
        end
    end
    x=V*Sinv*U'*b;
 
    
    
%   4b.)
    A=[4 14 -6; 14 49 -21; -6 -21 9];
    
    %Find Rank (could use SVD as well)
    rref(A); %rk(A)=1
    
%   5.)
    %Test
    %Define random points in 3D Space
    P = [[1 0 0]' [0 1 0]' [0 0 1]'];
    
    %Pick arbitrary rotation matrix
    theta=rand(0, 180);
    R = [1 0 0; 0 cos(theta) -sin(theta); 0 sin(theta) cos(theta)];
    
    %Pick arbitrary translation
    T = rand([3,1]);

    %Calculate Q
    Q = R*P + repmat(T,[1, size(P,1)]);

    %Output estimated R and T matrices given P and Q
    [R_est, T_est] = RigidBod2(P,Q);
    
    %Original R for comparison
    R;
    
    %Original T for comparison
    T;

