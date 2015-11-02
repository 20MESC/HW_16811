%
%   15-811
%   HW1 Prob #5 RigidBodyXform
%   Author: Rosario Scalise
%   Date: 9-13-15
%   Implemented paper by Eggert et al.
%   http://graphics.stanford.edu/~smr/ICP/comparison/eggert_comparison_mva97.pdf
%  

function [R,T] = RigidBod2(P,Q)

%get means (for centroids)

    %addressing P
    pbar = mean(P, 2); 

    %addressing Q
    qbar = mean(Q, 2);
    
%Xform relative to centroids

    %addressing P
    Pc=zeros(size(P,1),size(P,2));
    for i = 1:size(P,2)
        Pc(:,i) = P(:,i)-pbar;
    end
    
    %addressing Q
    Qc=zeros(size(Q,1),size(Q,2));
    for i = 1:size(Q,2)
        Qc(:,i) = Q(:,i)-qbar;
    end
    
    
%Form correlation matrix
    H = Pc*Qc';
    
%Get SVD for correlation matrix
    [U S V] = svd(H);

%Get Rotation Matrix
    D = diag([ 1 1 sign(det(V * U')) ]); %paper 2
    %%D = diag([ 1 1 det(U * V') ])*V'; %paper 1
    R = V * D * U'; % paper 2
    %%R = U * D * V'; paper 1

    %R=V*U'; %paper 3

%Get Translation Matrix
    T = qbar - R*pbar;


end