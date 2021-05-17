data = load('co2-mm-mlo.txt');
x = data(:,2);
y = data(:,3);

jk = x >= 1990;
x = x(jk) - 1990;
y = y(jk);

% 큰 order가 앞으로 나오도록 설정한다.
temp = [x.^2, x, ones(length(x), 1)];
p = (temp'*temp)\(temp'*y);
y_model = p(1) * x.^2 + p(2) * x + p(3);

% figure, plot(x,y);
% hold on, plot(x,y_model, '--r');

% 이제 residual의 주기성을 알아보도록 하자.
y_residual = y - y_model;
n = length(y_residual);
nf = 2^nextpow2(n);
fyr = fftshift(fft(y_residual, nf));

% spectrum 구하기
pw = fyr.*conj(fyr);
% normalize해서 구해볼 수 도 있지만 정확히하려면 미분을 해서 dt를 구해보자.
% x는 1달에 1번 구한 자료이기 때문에 1 / 12가 나온다.
% f는 normalized f에 dt를 나눠주면 된다. 
dt = mean(diff(x));
f = [0:nf-1]'/nf - 0.5;
f = f / dt;
% peak를 살펴보면 1년 주기와 6개월 주기가 있음을 알 수 있다.
figure,plot(f,pw);
xlabel('freq(1/yr)');
ylabel('power spectrum');

% nf = 1024로 하면 어떻게 될까?
% dt는 자료값이기 때문에 변하지 않는다.
% f는 nf가 변했으므로 변한다.
% peak는 같고 더 정확하게 나온다.

% 주파수 영역에서 구한 스펙트럼 에너지 = sum(pw)
% 시간 영역에서 구한 스펙트럼 에너지 = sum(pyr)
% sum(pw) / sum(pyr) = 512(=nf)
% sum(pw) / nf = sum(pyr)
% 에너지가 보존된다.
% Parseval's equation
% sum(x(t)의 스펙트럼) = sum(X(w)의 스펙트럼) / nf
pyr = y_residual.*conj(y_residual);

