0526_PCA

% principal component

data = load('sediments.txt');
data = data * 100;	% 퍼센트로 만든다.

% 다음 수업시간에 할 것이므로 일단 넘어간다.
[idx,C] = kmeans(data,3,'Distance','cosine','MaxIter',1000);

[coeff, score, latent] = pca(data);
pct = latent / sum(latent) * 100;

% 암석이 9개 이므로 PCA도 9개가 만들어 지는데
% 따라서 coeff도 9개의 열이 나온다.
% 예를 들어 coeff 1행 1열은 1번 자료의 PCA1의 방향을 나타낸다.

% pct의 결과 PCA1과 PCA2를 위주로 봐도 문제가 없다.
% 다음 출력 의미는 새로운 축을 기준으로 표현해본 것이다.
% 자료의 개수가 10개 이므로 10개의 점이 찍힌다.
figure, plot(score(:,1), score(:.2), 'ro');
axis([-50,50,-30,30]);
xlabel('pca1');
ylabel('pca2');

% 1번째 그룹을 출력해보자.
sample_idx = [1:length(data)];	% 1,2,...,10
n = sample_idx(idx == 1);
figure, plot(score(n,1), score(n.2), 'ro');
axis([-50,50,-30,30]);

% 2번째 그룹을 출력해보자
n = sample_idx(idx == 2);
hold on, plot(score(n,1), score(n.2), 'g*');

% 3번째 그룹을 출력해보자
n = sample_idx(idx == 3);
hold on, plot(score(n,1), score(n.2), 'k+');

%-------------------------------------------------

% 9개 암석은 많으니까 3개로만 해보자.
% data2 = data(:,1:3);
[coeff, score, latent] = pca(data2);
pct = latent / sum(latent) * 100;

cc = cov(data2);

% [V,D] = eig(cc);
% V : eigen vector
% D : eigen value(latent에 해당)
% D에서 오른쪽 아래에 있는 값이 가장 크므로 PCA1에 해당
% eig는 value값이 같은경우 작동하지 못하므로 사용x

% eig 대신에 svd를 사용한다.
[U,D,V] = svd(cc)

% U,V : eigen vector(coeff에 해당)
% 순서대로 PCA1, PCA2 ,...

% D : eigen value(latent에 해당)
% S에서 왼쪽 위가 가장 크므로 PCA1

% dpct가 pca로 구한 pct랑 같게 나온다.
dpct = diag(D);
dpct = dpct / sum(dpct) * 100;

% V의 각 열에서 절댓값이 가장 큰 값이 +가 되도록 바꿔준다.
% coeff랑 비교해보기
[~,sindx] = max(abs(V));
[row, col] = size(V);
sindx = sindx + (0:row:(col - 1) * row);
csign = sign(V(sindx));
csign = repmat(csign,row,1);
V = V.*csign;

% 1시간 18분 23초
