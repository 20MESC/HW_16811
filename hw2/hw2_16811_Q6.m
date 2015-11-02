%% part b

func=inline('x-tan(x)','x');
maxI=1000;
tol=10^-6;
tol2 = 10^-15;

zeros = [];

for i = .5:.1:12.5
    p0=i-.1;
    p1=i;
    p2=i+.1;
    
    z = mulMeth(p0,p1,p2,func,tol,maxI);
    
    if  min(abs(z - zeros)) < tol
        continue;
    end
    
    if abs(imag(z))<tol2
        zeros = [zeros z];
    end
    
    
end
    
%% part c

global maxk;


z = linspace(0,20);

close all;
hold on;
%plot(z,bessel_q6(z));

%for comparison against built in MATLAB bessel function
%plot(z,besselj(1,z),'r');

func = @bessel_q6;
maxI=1000;
tol=10^-7;


for maxk=0:25; %keep incresing the truncation of the sum until hitting 4 roots
    zeros = [];
    for i = .5:.1:12.5
        p0=i-.1;
        p1=i;
        p2=i+.1;

        z = mulMeth(p0,p1,p2,func,tol,maxI);

        if  min(abs(z - zeros)) < tol
            continue;
        end

        if z > tol
            zeros = [zeros z];
        end

    end
    maxk
    zeros
end
