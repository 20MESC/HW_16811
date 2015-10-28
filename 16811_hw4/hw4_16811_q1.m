%% Part a.)
    
    % Analytic Solution
    
    t=-.05; %step size
    x=[1:t:0]; %going backwards from 1 to 0 to cover interval [0,1]
    y_anly=[-1];
    
    y_anly = 1 - 2 ./ sqrt(x);


%% Part b.)

    % Euler's Method

    %initial conditions
    t=-.05; %step size
    x=[1:t:0]; %going backwards from 1 to 0 to cover interval [0,1]
    y_eul=[-1];
 
    diffEq = @(x,y) ( 2 / ((x^2)*(1-y)) );
    
    
    % Equation from notes
    % y(n+1) = y(n) + h * f(x(n),y(n))
    
    for i = 1 : length(x)-1
        y_eul(i+1) = y_eul(i) + diffEq(x(i),y_eul(i))*t;
    end
    
%% Part c.)

    % Runge-Kutta Method (4th Order)
    
    %initial conditions
    t=-.05; %step size
    x=[1:t:0]; %going backwards from 1 to 0 to cover interval [0,1]
    y_rk4=[-1];
    
    % Equation from notes
    % y(n+1) = y(n) + (1/6)*(k1+2k2+2k3+k4)
    % k1 = h*f(xn,yn)
    % k2 = h*f(xn+(h/2),yn+(k1/2))
    % k3 = h*f(xn+(h/2),yn+(k2/2))
    % k4 = h*f(xn+h,yn+k3)
    
    for i = 1 : length(x)-1
        
        k1 = t*diffEq(x(i),y_rk4(i));
        k2 = t*diffEq((x(i)+t/2),(y_rk4(i)+(k1/2)));
        k3 = t*diffEq((x(i)+t/2),(y_rk4(i)+(k2/2)));
        k4 = t*diffEq((x(i)+t),(y_rk4(i)+k3));
        
        y_rk4(i+1) = (y_rk4(i) + (1/6)*(k1+2*k2+2*k3+k4));
        
    end

 %% Part d.)
 
    % Adams-Bashforth (4th Order)
    
    %initial conditions
    t=-.05; %step size
    x=[1:t:0]; %going backwards from 1 to 0 to cover interval [0,1]
    y_ab4=[-1];
    
    %initializing fn array with 4 values
    fn_ab4 = [ diffEq(1.15, -0.865009616)  diffEq(1.10, -0.906925178)    diffEq(1.05, -0.951800146)   diffEq(1, -1)];
    
    % Equation from notes
    % y(n+1) = y(n) + h/24 * (55f(n)-59f(n-1)+37f(n-2)-9f(n-3))
    for i = 1 : length(x)-1
       n=length(fn_ab4);
       y_ab4(i+1) = y_ab4(i) + (t/24)*(55*fn_ab4(n)-59*fn_ab4(n-1)+37*fn_ab4(n-2)-9*fn_ab4(n-3));
       fn_ab4 = [ fn_ab4 diffEq(x(i+1), y_ab4(i+1)) ];
    end
    
%% Plotting
    hold on
    plot(x,y_anly,'ro');
    plot(x,y_eul,'b-');
    plot(x,y_rk4,'g-');
    plot(x,y_ab4,'c-');
    legend('Analytic','Euler','Rugne-Kutta4','Adams-Bashforth4','Location','East');
    
    norm(y_anly(1:length(x)-1)-y_eul(1:length(x)-1),2)
    norm(y_anly(1:length(x)-1)-y_rk4(1:length(x)-1),2)
    norm(y_anly(1:length(x)-1)-y_ab4(1:length(x)-1),2)
