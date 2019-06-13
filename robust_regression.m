% Robust linear regression 
% (for 1-dimension)

load('p2q2data.mat');

rho = 1;

robust_delta = 1;
l2_delta = 10000; % simulating infinity
l2_color = [0.9290, 0.6940, 0.1250];

[robust_w, robust_b, ~] = huber(x, y, rho, robust_delta);
[l2_w, l2_b, ~] = huber(x, y, rho, l2_delta);

% plot visualization
figure;
scatter(x,y,'filled'); grid on; hold on;
plot(x,robust_w.*x + robust_b,'b','LineWidth',2);
hold on;
plot(x,l2_w.*x + l2_b,'Color', l2_color,'LineWidth',2);
legend('Data points','Huber loss','L_2 loss','Location','Best');