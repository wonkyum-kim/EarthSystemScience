data = load('agedepth_1.txt');
x = data(:,1);
y = data(:,2);

% 1차식으로 regression
% y = a1x + a0

N = length(x);
temp = [x,ones(N,1)];
% p = polyfit(depth,age,1); 
p = (temp'*temp)\(temp'*y);

% regression 나타내기
xx = [0:0.5:20]; % min(x)와 max(x)로 범위를 판단한다.
% yy = polyval(p, xx); 
yy = p(2) + p(1) * xx;
figure, plot(x, y,'*');
hold on, plot(xx,yy,'-r');

% 95% 이내의 값들을 알아보자
[p, S] = polyfit(x, y, 1);
[yy, delta] = polyval(p,xx,S);
hold on, plot(xx,yy+delta,'--k'), plot(xx,yy-delta,'--k');

% residual을 구하기
xhat = x;
yhat = p(1) * xhat + p(2);
residual = y - yhat;
RMSE = sqrt(sum((residual).^2) / N);
