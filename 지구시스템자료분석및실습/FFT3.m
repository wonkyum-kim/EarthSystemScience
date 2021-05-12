% Time shifiting
% 1. fft(y)를 구한다.
% 2. exp(-i * 2 * pi * f *sft)를 구해서 fy에 곱한다.
% 3. ifft를 구한다.

% 원래 함수
t = [0:127];
dt = 1;
y = cos(2 * pi / 16 * t);
figure, plot(t,y);

% 1. fft를 구한다.
fy = fftshift(fft(y));
nf = length(fy);
f = [0:nf-1]/nf - 0.5;

% 2. exp(-i*w*sft)를 구해서 곱해준다.
sft = 8;    % shift right 8
fs = exp(-j * 2 * pi * f * sft);
ff = fy.*fs;

% 3. ifft를 구한다.
y_sft = ifft(ifftshift(ff));
figure(1), hold on, plot(t,real(y_sft), 'r');


% Frequency shifting
% 1. y를 구한다.
% 2. exp(j * 2 * pi * t *sft)를 구해서 y에 곱한다.
% 3. fft(y)를 구한다.

t = [0:127];
dt = 1;

% 1. y를 구한다. (주어졌다.)
y = cos(2 * pi / 16 * t);
fy = fftshift(fft(y));
figure,plot(f,real(fy));

% 2. exp(j * 2 * pi * t *sft)를 구해서 y에 곱한다.
sft = 0.25;
ts = exp(j * 2 * pi * t * sft);
y_sft = y.*ts;
fy_sft = fftshift(fft(y_sft));
figure(2), hold on, plot(f,real(fy_sft));
