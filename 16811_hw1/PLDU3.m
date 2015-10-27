%
%   15-811
%   HW1 Prob #1 LDU Decomposition
%   Author: Rosario Scalise
%   Date: 9-12-15
%   Some Inspiration from past project I had done during undergrad
%   We had used the text "Numerical Analysis" by Richard Burden 

function [P, L, D, U] = PLDU3(A)

    %A must be square
    [m, n] = size(A);
    
        %instantiate P, L, D, U
        P=eye(m);
        L=eye(m);
        D=eye(m);
        U=A;

    % Decomp process
    for i=1:n
        
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

    %Now seperate old L into L and D
    for i=1:n
        D(i,i)=L(i,i);
        L(:,i) = L(:,i)/L(i,i);
    end

    %Construct final P matrix
    %for i=1:m
    %    P(i, p(i)) = 1;
    %end

end