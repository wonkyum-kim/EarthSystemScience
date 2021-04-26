data = load('agedepth_1.txt');

x = data(:,1);
y = data(:,2);
sx = std(x);
sy = std(y);
C = cov(x,y);
cv = C(1,2);
r = cv / (sx * sy);
% -1 <= r <= 1
% r == 0 이면 상관관계가 없다는 뜻이다.
fprintf("correlation coefficient : %g\n", r);
figure, plot(x,y,'*');
xlabel('depth')
ylabel('age [kyrs]')


% 라이브러리 사용
% r = corrcoef(x,y);
