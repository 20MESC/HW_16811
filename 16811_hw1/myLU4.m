function [L, U, P] = myLU4(A)

%A must be square

%get size of input matrix
sizeofA=size(A);
n=sizeofA(1);

%instantiate L, P, U
L=eye(n);
P=eye(n);
U=A;

% process
for i=1:n
    
    %Row Reduction
    if U(i,i) == 0
        maxofU = max(abs(U(i:end,1)));
        for j=1:n
            if maxofU == abs(U(j,i))
                temp = U(1,:);
                U(1,:) = U(j,:);
                U(j,:) = temp;
                
                temp = P(:,1);
                P(1,i) = P(j,:);
                P(j,:) = temp;
            end
        end
    end
    
    if U(i,i) ~=1
        temp = eye(n);
        temp(i,i)=U(i,i);
        L=L*temp;
        U(i,:) = U(i,:)/U(i,i); %Ensure pivots are 1
    end
    
    if i~=n
        
        for k=i+1:length(U)
            temp = eye(n);
            temp(k,i) = U(k,i);
            L=L*temp;
            U(k,:)=U(k,:)-U(k,i)*U(i,:);
        end
    end
end

P = P';
end