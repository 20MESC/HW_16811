x=[1 3 5; 2 4 6];
y = [2 1 6];
a = [3 4 5];

n_labels = length(x);

total = 0

for i = 1:n_labels
    for j = 1:n_labels
        total = total + y(i)*y(j)*a(i)*a(j)*(x(:,i)'*x(:,j));
    end
end

total




total = 0

total = cumsum((a.*y*x').cumsum((a.*y)*x))