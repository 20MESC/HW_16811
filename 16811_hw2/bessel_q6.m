function [ out ] = bessel_q6(z)
%quick function to allow changing k globally
global maxk;


sum = 0;
for k=0:1:maxk
    
    sum = sum + (((-1.*z.^2)/4).^k)/(factorial(k)*(factorial(k+1)));
    
end

out = (z/2).*sum;


end

