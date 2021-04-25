% two_tailed_T_test
% x1 : 1번째 샘플
% x2 : 2번째 샘플

data = load('organicmatter_two.txt');
x1 = data(:,1);
x2 = data(:,2);
xm1 = mean(x1);
xm2 = mean(x2);
xs1 = std(x1);
xs2 = std(x2);
n1 = length(x1);
n2 = length(x2);
df1 = n1 - 1;
df2 = n2 - 1;

tc = tinv(1 - 0.05/2,df1 + df2);
t = abs(xm1-xm2)/sqrt((n1+n2)/(n1*n2) * ((n1 - 1)*(xs1^2) + (n2 - 1) * (xs2^2)) / (n1+n2-2));

if t <= tc
    fprintf("Great!\n");
else
    fprintf("Reject!");
end

% 라이브러리 사용
% [h,p,ci,stats] = ttest2(x1,x2)
