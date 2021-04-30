data = load('asmax.txt');

x = data(:,1);
phi = data(:,2);
y = 2.^(-phi);

% 1차식 구하기
[p,S] = polyfit(x,y,1);
[z1, delta] = polyval(p,x,S);

% 2차식 구하기
[p,S] = polyfit(x,y,2);
[z2, delta] = polyval(p,x,S);

% nonlinear regression

modelfunc = @(a,x) a(1) * exp(-a(2) * x) + a(3);
p0 = [1000,1,0]; % a(1) + a(3)이 p(1)가 나오도록 설정해주면 된다.
p = nlinfit(x,y,modelfunc,p0);
figure, plot(x,y,'o');
ze = modelfunc(p,x);
hold on, plot(x,ze,'--r');
