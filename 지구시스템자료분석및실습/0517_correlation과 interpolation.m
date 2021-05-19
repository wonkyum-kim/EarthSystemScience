% correlation
% x(t) ⓧ y(t) <-> X(w) * Y(W)^*
% 교환법칙 성립 안한다.


% Linear Chirp 
% -> w(t)가 선형으로 증가하거나 감소
% y(t) = A * exp(±i*pi*K*t^2)
% K는 w(t)의 기울기를 의미한다.
% amplitude를 무시한다고 가정하고
% y(t) = exp(±i*pi*K*t^2) 이를 fft를 하게 되면
% Y(w) = exp(-+i * pi * f^2 / K) 가 된다.

% *monochromatic
% -> 시간에 따라 w가 상수이므로 일정하다.

% sampling frequency
SF = 3000;

t = [-512:512]'/SF;
dt = 1 / SF;

K = 5000;
y = exp(-j * pi * K * t.^2);
figure, plot(t, real(y));

% φ(t) = -pi*K*t.^2
% dφ(t)/dt = -2*pi*K*t  -> 주파수

N = length(y);
nf = 2^nextpow2(N);
fy = fftshift(fft(y,nf));
f = ([0:nf-1]'/nf - 0.5) * SF;	% (* 1/dt)와 같다.
figure, plot(f,abs(fy));

% fft(y)로 예상되는 값
fr = exp(+j * pi * f.^2 / K);

% 자신의 conj와 곱해보자.
ff = fy.*conj(fr);
res = ifft(ifftshift(ff));
res = res(1:N);

% 이와 같은 과정을 pulse compression이라고 한다.
figure, plot(real(res));
hold on, plot(real(y),'r');

% Bandwidth = K * T
% B가 넓어지면 시간영역에서 signal이 더 커진다.
% 단 B는 SF보다 커지면 안된다.
% nyqf = +- 1/(2*dt) = +- SF/2

% --------------------------------------------------------

% interpolation
% dft를 하려면 데이터 간격이 같아야 한다.
% linear / nearest / cubic, pchip / spline

data = load('co2-mm-mlo.txt');
x1 = data(:,2);
y1 = data(:,3);
temp = y1 >= 0;
y1 = y1(temp);
x1 = x1(temp);
x1 = x1 - 1958;

% 등간격인지 확인해본다.
figure, plot(diff(x1));

% x1(end) = 60.2xx 이므로
xn = [0:1/12:60]';

% linear로 interpolation
yn = interp1(x1,y1,xn);

% pchip로 interpolation
ync = interp1(x1,y1,xn,'pchip');


% y1값에 noise를 추가해보자
N = length(y1);
y2 = y1 + rand(N,1);

yn2 = interp1(x1,y2,xn);

figure, plot(x1,y2);
hold on, plot (xn, yn2,'g');
