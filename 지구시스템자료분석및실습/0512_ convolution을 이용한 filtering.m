data1 = load('drillCore_1.txt');
data2 = load('drillCore_2.txt');

x1 = data1(:,1);
y1 = data1(:,2);

x2 = data2(:,1);
y2 = data2(:,2);

% 2행 1열로 나누고 n번째에 plot
figure, subplot(2,1,1), plot(x1,y1)
hold on, subplot(2,1,2), plot(x2,y2,'r')

% DC component
% sum(y1) == fy1(nf1 / 2 + 1)이다!
% dft를 살펴보면 원래는 0번째 자료가 sum(y1)인데
% fftshift를 하고나면 nf1 / 2 + 1번째 자료가 sum(y1)이 된다.
% 따라서 sum(y1) = fy1(nf1 / 2 + 1) = mean(y1) * N1이다.

% 스펙트럼 분석을 할 때에는 평균값을 빼준다.
N1 = length(y1);
nf1 = 2^(nextpow2(N1) + 1); % 보통은 1개 더 많도록 구한다.
% y1 = y1 - mean(y1);
fy1 = fftshift(fft(y1, nf1));

% normalize해서 살펴본다.
f = ([0:nf1-1]' / nf1 - 0.5);
figure, plot(f, abs(fy1));  

% low pass filter
% 주기성을 알기 위해서 signal을 smooth하게 만들어준다.
% 즉 fy1에서 저주판만 남기고 고주파를 제거해보자.
% f_fy1 : filtered fy1
f_fy1 = zeros(nf1,1);
jk = abs(f) < 0.2;
f_fy1(jk) = fy1(jk);
figure,plot(f, abs(f_fy1));

% zeros padding을 없애고 출력해본다.
% ry1 : reverse 해서 구한 y1
ry1 = ifft(ifftshift(f_fy1));
ry1 = ry1(1:N1);
figure,plot(x1,y1);
hold on, plot(x1,ry1);

% 위와 같은 방식으로 하게되면 zeros padding때문에 끝이 이상해진다.(...)
% hamming 또는 hanning을 사용해서 filtering을 한다.
% 아까처럼 구하기 보다는 곱하기로 구해본다.
% 주파수 영역에서의 곱하기의 ifft는 시간 영역에서 convolution과 같음을 이용해본다.

h = hamming(nf1);
% or h = hanning(nf1);
f_fy1 = fy1.*h; % 주파수 영역에서 곱한 것
figure,plot(f, abs(f_fy1));
ry1 = ifft(ifftshift(f_fy1));
ry1 = ry1(1:N1);
figure, plot (x1,real(ry1));
hold on, plot(x1, y1);      % smooth 하게 만든 것을 알 수 있다.

% 시간 영역에서 구해보기
rh = ifft(ifftshift(real(h)));
temp = conv(rh, y1);
figure, plot(real(temp));


% 이번에는 시간영역에서 곱해보자.
h = hamming(N1);
my1 = y1.*h;
mfy1 = fftshift(fft(my1, nf1));
figure, plot(abs(mfy1));    % 이거랑
fy1 = fftshift(fft(y1, nf1)); % 이거 비교해보면 smooth 해진것을 볼 수 있다.
hold on, plot(abs(fy1));


% filtering 하는 또 다른 방법
% 시간 영역에서 5개씩 평균내서 
h1 = ones(5,1);
h1 = h1 / sum(h1);
yy = conv(y1, h1, 'same');
figure, plot(yy);
