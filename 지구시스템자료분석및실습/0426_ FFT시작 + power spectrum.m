% sampling theorem
% 1주기당 최소 2개 샘플 이상
% △t = sampling interval
% 분석가능한 최대 주파수 = nyquist frequency
% ±1/2△t 이내로만 측정이 가능하다.
% 넘어간다면 aliasing이 일어나고 △t를 줄여야 한다.

% FFT
t = 1:1000;
y = 2*sin(2*pi*t/50) + sin(2*pi*t/15);
fy = fftshift(fft(y));

% 스펙트럼 구하기
% 절댓값의 제곱 -> 자신과 자신의 conj를 곱해준다.
pwy = fy.*conj(fy);
dt = 1;
f = [-1/(2*dt):1/1000:1/(2*dt)];
f = f(1:end-1);
