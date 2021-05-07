% f(t) 구하기
t = 1:1000;
y = 2*sin(2*pi*t/50) + sin(2*pi*t/15);

% F(w) 구하기
fy = fft(y);

% 좌우를 바꾸기
fy = fftshift(fy);
figure,plot(real(fy))
figure,plot(imag(fy))

% 스펙트럼 구하기
pwy = fy.*conj(fy);
figure,plot(pwy);

dt = 1;
fnyq1 = -1 / (2 * dt);
fnyq2 = 1 / (2 * dt);
f = [fnyq1:1 / 1000:fnyq2];
f = f(1:end-1);
% f(1) = -0.5, f(end) = 0.499
figure, plot(f, pwy)
% 1/50과 1/15에서 나타난다.
