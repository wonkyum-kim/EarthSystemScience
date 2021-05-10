% discrete한 값이라서 stem으로 표시해본다.
y = zeros(64,1);
y(1) = 1;
% figure, stem(y,'r');

% delta function
fy = fft(y);
% figure,stem(real(fy));
% figure,stem(imag(fy));

% inverse fourier transform for delta function
clear fy;
clear y;
fy = ones(64,1);
y = ifft(fy);
% figure,stem(y,'r');

clear all;

% rectangle function (box car)
y = zeros(64,1);
y(33-16:33+16) = 1;
% figure,plot(y);
fy = fft(y);
fy = fftshift(fy);
% figure,plot(real(fy));

% normalize
dt = 1;
n = length(fy);
f = [0:n-1]'/n - 0.5;
% figure,plot(f, real(fy))

% inverse Fourier transform for sinc function
clear y;
y = ifft(ifftshift(fy));
% figure,plot(real(y));

% before time shift
y = zeros(64,1);
y(1) = 1;
figure, stem(y)
fy = fftshift(fft(y));  % FFT(y)
figure, stem(real(fy));

% after time shift
y(1) = 0;
y(10) = 1;
fy = fftshift(fft(y));  % FFT(y), but time shifted
figure, stem(real(fy));

% To recover from shifting, calculate exp(-iwt0)
N = length(fy);
f = [0:N-1]'/N - 0.5;   % normalize
t0 = 9;
fs = exp(-j * 2 * pi * f * t0);
ff = fy.*conj(fs);  % multiply conjugate complex
z = ifft(ifftshift(ff));
figure, stem(real(z));
