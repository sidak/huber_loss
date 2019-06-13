load('p2q3data.mat');

rho = 0.0001; %regularization parameter
delta = 1; %Huber loss parameter
sigma = 0.5; %Gaussian kernel bandwidth

% kernel function
kernel = @(x1, x2) exp(-((x1 - x2)^2)/(2*sigma^2));

% precompute the kernel matrix
for i=1:length(y)
    for j=1:length(y)
        K(i,j) = kernel(x(i),x(j));
    end
end
    
z = dual_huber(x, y, K, rho, delta);

% computing the optimal value of b
flag=0;
idx = 1;
while flag==0
    if z(idx) < delta && z(idx) > -delta
        b_star = - (z(idx) - y(idx) + (1/rho)*K(idx,:)*z);
        flag = 1;
    end
    if idx == length(y) && flag == 0
        print('No optimal b found');
        return;
    end
    idx = idx + 1;
end

% plot the kernelized curve on at some discretization
dx = (max(x) - min(x))/100;
ct = 1;
for inp=min(x):dx:max(x)
    input(ct)= inp;
    for i=1:length(y)
        % computes the value of w when used together in the form of w'x
        w_tmp(i) = z(i)*kernel(x(i),inp);
    end
    out(ct) = (1/rho)*(sum(w_tmp)) + b_star;
    ct = ct + 1;
end

orange = [0.9290, 0.6940, 0.1250];

scatter(x,y,'filled'); grid on; hold on;
plot(input, out,'Color', orange, 'LineWidth',2); hold on;

[w_huber, b_huber, ~] = huber(x, y, rho, delta);

plot(x,w_huber'*x + b_huber,'b','LineWidth',2);
legend('Data points','Kernelized (dual) Huber','Vanilla Huber','Location','Best');
