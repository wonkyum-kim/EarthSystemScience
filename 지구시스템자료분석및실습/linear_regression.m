data = load('agedepth_1.txt');
x = data(:,1);
y = data(:,2);

% 1차식으로 regression
% y = a1x + a0

% 높은 order가 먼저 나오도록 만들어 준다.
N = length(x);
temp = [x,ones(N,1)];
% p = polyfit(x,y,1); 
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

% RMSE를 구하기
% 0에 가까울 수록 좋다.
RMSE  = @(yhat,y) sqrt(sum((yhat - y).^2) / length(y));

% 1차식의 RMSE
RMSE_1 = RMSE(yhat,y);

% R-square을 구하기
% 1에 가까울 수록 좋다.
ym = mean(y);
ytot = y - ym;
R_square = 1 - sum(residual.^2) / sum(ytot.^2);

% 2차식으로 regression
p = polyfit(x,y,2);
yhat_2 = p(1) * x.^2 + p(2) * x + p(3);
% yy2 = polyval(p,x);
hold on, plot(x, yhat_2, '--k');

% 2차식의 RMSE
RMSE_2 = RMSE(yhat_2,y);
