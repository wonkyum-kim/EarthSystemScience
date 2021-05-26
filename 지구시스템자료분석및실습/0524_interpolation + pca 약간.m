data = load('icecore_gripd18o.txt');
y = data(:,2);
t = data(:,3);
jk = t >= 6000 & t <= 8000;
t = t(jk);
y = y(jk);

% 등간격인지 확인해본다.
figure, plot(diff(t));

% 평균 간격을 확인해본다.
% mean(diff(t)) -> 4.xx

% 최소와 최대를 확인해본다.
% min(t) -> 6003.7
% max(t) -> 7999.8

% 이를 토대로 새로운 등간격 시간을 만들어 준다.
tt = [6000:5:8000]';

y_itp_pchip = interp1(t,y,tt,'pchip');
% figure, plot(tt,y_itp_pchip)

% 주기성을 보려면 평균을 빼준다.
my = mean(y_itp_pchip);

N = length(y_itp_pchip);
nf = 2^(nextpow2(N) + 1);
dt = 5;
f = ([0:nf-1]'/nf - 0.5) / dt;
fy = fftshift(fft(y_itp_pchip - my, nf));
% figure, plot(f,abs(fy));

% 주기성이 잘 안보인다면 dt를 더 줄여보자.
