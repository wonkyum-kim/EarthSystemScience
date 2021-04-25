% one tailed T-test 
% xm : 샘플의 평균
% xs : 샘플의 표준편차
% xe : 비교하는 값
% n : 샘플의 개수
% df : 자유도

% 최소를 구하려면 오른쪽에서 구한다.
% 최대를 구하려면 왼쪽에서 구한다.
xm = 21.3;
xs = 5.5;
xe = 17;
n = 10;
df = n - 1;
% 최대는 tc = tinv(0.05, df)로 구해본다.
tc = tinv(1 - 0.05, df);
t = (xm - xe) / (xs / sqrt(n));

if tc < t
    fprintf("Reject!\n")
else
    fprintf("Great\n")
end

% 최대와 최소 모두 구하려면!
% tc1 = tinv(0.05 / 2, df)
% tc2 = tinv(1 - 0.05 / 2, df)



