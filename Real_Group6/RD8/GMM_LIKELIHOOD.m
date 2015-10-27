function postProb=GMM_LIKELIHOOD(d,DataPoint,K,PI,Means,Cov)

format long;
postProb=0;

for i=1:K
    postProb=postProb+PI(1,i)*N(d,DataPoint,Means(i,:),Cov(:,:,i));
end