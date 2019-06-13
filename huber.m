
function [w, b, opt] = huber(x, y, rho, delta)

    m = length(x); %number of data points
    % rho: regularization parameter
    % delta : Huber loss parameter

    % Generate data
    n = 2*m+2; % number of variables corresponding to [t, p, w, b]
    P = zeros(n, n);
    P(1:m, 1:m) = eye(m)/2;
    P(2*m+1, 2*m+1) = rho/2;

    q = zeros(n, 1);
    q(m+1:2*m) = delta;

    r = 0;

    % Formulate as QP and solve
    fprintf(1,'Computing the optimal solution ...');
    cvx_begin
        variable z(n)
        minimize ( (1/2)*quad_form(z,P) + q'*z + r)
        [eye(m) eye(m) -x -1*ones(m, 1)] * z  >= -y;
        [-eye(m) eye(m) x 1*ones(m, 1)] * z  >= y;
    cvx_end
    fprintf(1,'Done! \n');
    
    opt = cvx_optval;
    w = z(2*m+1);
    b = z(2*m+2);

    % Display results
    % disp('------------------------------------------------------------------------');
    % disp('The computed optimal solution is: ');
    % disp(z);
    
end
