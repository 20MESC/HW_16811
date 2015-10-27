function [ fInterp ] = ddInterp(n,x_2eval,x,f )
%Takes in n, x points to evaluate interp poly @, and (x,f(x)) coords to
%construct interpolated polynomial from.
%validated against Mathworks polyintrp

%create placeholder for values
fInterp = zeros(size(x_2eval));

for k=1:n
    %create divided differences placeholder
    dd=ones(size(x_2eval));
    %iterate over all values in x except for the current k
    for j=[1:k-1 k+1:n]
        dd= (x_2eval-x(j)) ./ (x(k)-x(j)) .*dd;
    end
    
    %multiply dd by fsubk to get final value
    fInterp = fInterp + dd*f(k);

end

