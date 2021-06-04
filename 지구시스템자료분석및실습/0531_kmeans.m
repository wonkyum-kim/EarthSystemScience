data = load('sediments.txt');

data = data * 100;

[coeff, score, latent] = pca(data);

cc = cov(data);
[U,D,V] = svd(cc);

% latent
dpct = diag(D);
dpct = dpct / sum(dpct) * 100;

% coeff
[~,idx] = max(abs(V));
for ii = 1:9                    % 열
    if V(idx(ii),ii) < 0
        for jj = 1:9            % 행
            V(jj,ii) = V(jj,ii) * (-1);
        end
    end
end

% score
m = mean(data);
xp = data - repmat(m,length(data),1);
xp = xp * V;

% 전체 그룹 출력
figure, plot(xp(:,1), xp(:,2),'ro');
axis([-50,50,-50,50]);
xlabel('pc1');
ylabel('pc2');

% 각 샘플과의 거리(유클리디안 거리)
% 9 + 8 + ... + 1 = 45개
Y = pdist(data);
figure, imagesc(squareform(Y)), colormap(hot), colorbar
Z = linkage(Y);
dendrogram(Z)
xlabel('sample no.');
ylabel('distance');
cophenet(Z,Y); % 상관관계?            
            
% k means
% 3그룹으로 나누고 500번 돌린다.
% C는 중심값을 알려준다.
% 돌릴 때 마다 다른 값이 나오므로 여러번 돌려본다.
% dendrogram이랑 비교해보면서 결정해도 좋다

[idx,C] = kmeans(data,3,'MaxIter',500);

p1 = score(idx == 1,:);
p2 = score(idx == 2,:);
p3 = score(idx == 3,:);
figure, plot(p1(:,1), p1(:,2),'b*');
hold on, plot(p2(:,1), p2(:,2), '+k');
hold on, plot(p3(:,1), p3(:,2), '+g');
axis([-50,50,-50,50]);

