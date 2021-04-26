data = load('agedepth_1.txt');
depth = data(:,1);
age = data(:,2);
% 1차식으로 regression
% y = a1x + a0
p = polyfit(depth,age,1);

% regression 나타내기
xx = [0:0.5:20]; % min(x)와 max(x)로 범위를 판단한다.
yy = polyval(p, xx);
figure, plot(depth, age,'*');
hold on, plot(xx,yy,'-r');

% 95% 이내의 값들을 알아보자
[p, S] = polyfit(depth, age, 1);
[yy, delta] = polyval(p,xx,S);
hold on, plot(xx,yy+delta,'--k'), plot(xx,yy-delta,'--k');

% 04/12 12분부터...
