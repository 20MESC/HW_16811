function [P, L, D, U] = myLDU5(A)

%A must be square

%get size of input matrix
n=length(A);

%instantiate P, L, D, U
P=eye(n);
L=eye(n);
D=eye(n);
U=A;

% process
for i=1:n
    
    %Row Permutation
    if U(i,i) == 0
        maxofU = max(abs(U(i:end,i)));
        for j=1:n
            if maxofU == abs(U(j,i))
                temp = U(i,:);
                U(i,:) = U(j,:);
                U(j,:) = temp;
                
                temp = P(i,:);
                P(i,:) = P(j,:);
                P(j,:) = temp;
            end
        end
    end
    
    if U(i,i) ~=1 %if a pivot is not 1
        temp = eye(n);
        temp(i,i)=U(i,i);
        L=L*temp; %put it in the L matrix
        U(i,:) = U(i,:)/U(i,i); %now divide row by pivot value to ensure it goes to 1
    end
    
    if i~=n
        
        for k=i+1:length(U)
            temp = eye(n);
            temp(k,i) = U(k,i);
            L=L*temp; %add coefficients from row reduc entries to L
            U(k,:)=U(k,:)-U(k,i)*U(i,:); %update row in U
        end
    end
end

disp(L)
disp(U)

%Now seperate old L into L and D
for i=1:n
    D(i,i)=L(i,i);
    L(:,i) = L(:,i)/L(i,i);
end

P = P'; %necessary?
end