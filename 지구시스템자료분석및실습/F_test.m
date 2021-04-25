% F_test

data = load('organicmatter_two.txt');
x1 = data(:,1);
x2 = data(:,2);
[h,p,ci,stats] = vartest2(x1,x2,0.05)
