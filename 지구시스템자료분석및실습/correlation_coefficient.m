data = load('agedepth_1.txt');
x = data(:,1);
y = data(:,2);
sx = std(x);
sy = std(y);
C = cov(x,y);
cv = C(1,2);
r = cv / (sx * sy);
% 1에 가까울 수록 잘 맞는다는 의미다.
fprintf("correlation coefficient : %g\n", r);
figure, plot(x,y,'*');
xlabel('depth')
ylabel('age [kyrs]')


% 라이브러리 사용
% r = corrcoef(x,y);
