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
figure,plot(y);
fy = fft(y);
fy = fftshift(fy);
% figure,plot(real(fy));

% normalize
dt = 1;
n = length(fy);
f = [0:n-1]'/n - 0.5;
figure,plot(f, real(fy))

% inverse Fourier transform for sinc function
clear y;
y = ifft(ifftshift(fy));
figure,plot(real(y));

% 27min....
