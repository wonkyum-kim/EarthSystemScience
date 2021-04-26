data = load('agedepth_1.txt');

x = data(:,1);
y = data(:,2);
sx = std(x);
sy = std(y);
C = cov(x,y);
cv = C(1,2);
% Pearson
r = cv / (sx * sy);
% -1 <= r <= 1
% r == 0 이면 상관관계가 없다는 뜻이다.
fprintf("correlation coefficient : %g\n", r);
% figure, plot(x,y,'*');
% xlabel('depth')
% ylabel('age [kyrs]')


% 라이브러리 사용
% r = corrcoef(x,y);

% Spearman or Kendall
% p가 0에 가까울 수록 좋다.
[r1, p1] = corr(x,y,'type','Spearman');
[r2, p2] = corr(x,y,'type', 'Kendall');

clear all;

% outlier를 고려해보자
x = randn(100,1);
y = randn(100,1);
% A outlier point
x = [x; 100];
y = [y; 101];

[r,p] = corr(x,y);
fprintf("Pearson : %g\n", r);

[r,p] = corr(x,y, 'type', 'Spearman');
fprintf("Spearman : %g\n", r);

[r,p] = corr(x,y, 'type', 'Kendall');
fprintf("Kendall : %g\n", r);

% 여러번 돌려서 outliers를 구해보는 방법도 있다.
r = bootstrp(1000, 'corr', x, y);
% histogram(r, 25)
% 1은 outlier가 포함된 것이다.
