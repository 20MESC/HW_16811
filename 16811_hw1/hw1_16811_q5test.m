%   5.)
    %Test
    %Define random points in 3D Space
    P = [[1 0 0]' [0 1 0]' [0 0 1]'];
    
    %Pick arbitrary rotation matrix
    theta=rand(0, 180);
    R = [1 0 0; 0 cos(theta) -sin(theta); 0 sin(theta) cos(theta)];
    
    %Pick arbitrary translation
    T = rand([3,1]);

    %Calculate Q
    Q = R*P + repmat(T,[1, size(P,1)]);

    %Output estimated R and T matrices given P and Q
    [R_est, T_est] = RigidBod2(P,Q);
    
    %Original R for comparison
    R;
    
    %Original T for comparison
    T;
