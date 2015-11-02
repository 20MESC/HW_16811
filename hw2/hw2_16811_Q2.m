%%  part a.)
    % choosing interpolation resolution
    x_2eval = 1:.01:4;
    x = 1:.5:4;
    % calculating data points for log(7,x)^2
    f = (log(x)/log(7)).^(2);

    n = length(x);

    % run interpolation
    fInterp = ddInterp(n,x_2eval,x,f);
    plot(x,f,'o',x_2eval,fInterp,'-');
    
    % gives exact desired interpolated value 
    key = find(x_2eval==2.25);
    fInterp(key)
    
%% part b.)
    n=40;%change n manually
    x = ((0:n)*(2/n) - 1);
    f = 5./(1+36.*x.^2);
    
    m = length(x);
    x_2eval = 0:.01:1;
    
    
    fInterp = ddInterp(m,x_2eval,x,f);
    plot(x,f,'o',x_2eval,fInterp,'-');
    
    % gives exact desired interpolated value 
    key = find(x_2eval==0.05);
    fInterp(key)
    
    
    % calculate actual value
    f = 5/(1+36*(0.005)^2);
    
%% part c.)

    x = linspace(-1,1,1000);
    f = 5./(1+36.*x.^2);
    
    vals = [];
    %specified n values to check error at
    for n = [2:2:20 40]
      xpre = (0:n)*2/n - 1;
      fpre = 5./(1 + 36*xpre.^2);
      pn = ddInterp(n+1,x,xpre,fpre);
      %calculate error
      En = max(abs(f-pn));
      vals = [vals En];
    end