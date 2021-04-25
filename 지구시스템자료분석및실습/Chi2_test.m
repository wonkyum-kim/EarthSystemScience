% Chi2_test

data = load('organicmatter_two.txt');
x1 = data(:,1);
m1 = mean(x1);
s1 = std(x1);

% O와 E 구해서 chi2d를 구하기 
[O, d] = hist(x1,10);
E = normpdf(d,m1,s1);
E = E / sum(E) * sum(O);
chi2d = sum((O - E).^2./E)

% 자유도 구하기
k = length(O);
z = 2 + 1;
df = k - z;
    
% 임계값 chi2c 구하기
chi2c = chi2inv(1 - 0.05, df);

if chi2d <= chi2c
    fprintf("normal distribution\n");
else
    fprintf("reject\n");
end

% 라이브러리 사용
% [h,p,stats] = chi2gof(x1)
