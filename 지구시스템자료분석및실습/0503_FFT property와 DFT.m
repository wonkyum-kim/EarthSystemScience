% FFT property

% linear : a * x(t) + b * y(t) <-> a * X(w) + b * Y(W)

% time shifting 
% shifting에서 주의할 점
% 오른쪽으로 옮기고 싶으면 sft > 0 왼쪽이면 sft < 0으로 생각한다.
% 즉 왼쪽으로 8옮기고 싶으면 -8을 대입한다. (나머지는 건들지 않기)
% x(t - t0) <-> exp(-jwt0) * X(jw)
% w = 2 * pi * f

t = [0:127];
dt = 1;
y = cos(2 * pi / 16 * t);
fy = fftshift(fft(y));
nf = length(fy);
f = [0:nf-1]/nf - 0.5;  % t가 1행이기 때문에 ' 처리 안했다!

sft = 8;
arg = exp(-j * 2 * pi * f * sft);
fy = fy.*arg;
ry = ifft(ifftshift(fy));
% figure, plot(t,real(ry));
% hold on, plot(t, real(y));

% frequency shifting
% exp(+j*2*pi*t*w0) * x(t) <-> X(w - w0)

t = [0:127];
y = cos(2 * pi / 16 * t);
fy = fftshift(fft(y));
sft = 0.25;
arg = exp(+j * 2 * pi * t * sft);
y = y.*arg;
rfy = fftshift(fft(y));
% figure ,plot(f,real(fy));
% hold on, plot(f, real(rfy));

% 주의할 점
% nyqf = (-0.5 ~ +0.5) / dt를 넘어서 shifting 하는 경우
% aliasing이 발생한다.
% ex) sft = 0.75인 경우


% scaling : x(at) <-> 1/a * X(iw/a)

t = [0:127];
y = cos(2 * pi / 16 * (t/4));
% 시간축에서 늘렸다.
% figure, plot(t,y);
fy = fftshift(fft(y));
% 주파수 영역에서 줄어들었다.
% figure, plot(f, real(fy));

% time differentiation
% dx(t) / dt <-> jwX(jw)
% n번 미분한다면 (jw)^n을 곱해주면 된다!

t = [0:127];
y = cos(2 * pi / 16 * t);
dy = diff(y);   % cos 미분해서 sin이 된다
% figure, plot(dy);
% hold on, plot(y);
fy = fftshift(fft(y));
nf = length(fy);
arg = j * 2 * pi * f;
fy = fy.*arg;
rfy = ifft(ifftshift(fy));
figure, plot(t,y);
hold on, plot(t, real(rfy));

% zeros padding

% time 영역에서 zeros padding은 뒤에 덧 붙여주면 된다.
% ex) y = [y, zeros(1,256 - 100)]
% 2배 늘어나면 nyqf는 그대로지만 df가 1/2줄어든다.

% frequency 영역에서 zeros padding은 앞 뒤로 덧 붙여야 한다.
% ex) fy = [zeros(1,64), fy, zeros(1,64)]
% 2배 늘어나면 time 영역에서 dt가 1/2배가 된다.
