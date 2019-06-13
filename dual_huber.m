function [z, opt] = dual_huber(x, y, K, rho, delta);

    m = length(x); %number of data points

    P = - (eye(m) + K/rho) ;
    q = y;

    r = 0;

    % Formulate as QP and solve
    fprintf(1,'Computing the optimal solution ...');
    cvx_begin
        variable z(m)
        maximize ( (1/2)*quad_form(z,P) + q'*z + r)
        ones(m, 1)' * z == 0;
        z >= - delta;
        z <= delta;

    cvx_end
    fprintf(1,'Done! \n');

    opt = cvx_optval;

end
