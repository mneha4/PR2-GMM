K=4;
type='Spiral';
d=2;

C1=dlmread('../Class1.txt');
C2=dlmread('../Class2.txt');

sizeC1=size(C1);
sizeC2=size(C2);

C1_75=C1(1:int16(0.75*(sizeC1(1,1))),:);
sizeC1_75=size(C1_75);
C1_25=C1(int16(0.75*(sizeC1(1,1)))+1:sizeC1(1,1),:);
sizeC1_25=size(C1_25);

C2_75=C2(1:int16(0.75*(sizeC2(1,1))),:);
sizeC2_75=size(C2_75);
C2_25=C2(int16(0.75*(sizeC2(1,1)))+1:sizeC2(1,1),:);
sizeC2_25=size(C2_25);

MeansC1_75=zeros(K,2);
MeansC2_75=zeros(K,2);

for i=1:K
    MeansC1_75(i,:)=C1_75(int16(sizeC1_75(1,1)*rand(1)),:);
    MeansC2_75(i,:)=C2_75(int16(sizeC2_75(1,1)*rand(1)),:);    
end

MeansC1_75=KMEANS(type,K,1,C1_75,MeansC1_75);
MeansC2_75=KMEANS(type,K,2,C2_75,MeansC2_75);

[PiC1_75, CovC1_75]=INIT_PARAMS(type,K,d,1,sizeC1_75);
[PiC2_75, CovC2_75]=INIT_PARAMS(type,K,d,2,sizeC2_75);


logLikeC1_75=LOGLIKECLUSTER(d,K,C1_75,PiC1_75,MeansC1_75,CovC1_75);
logLikeC2_75=LOGLIKECLUSTER(d,K,C2_75,PiC2_75,MeansC2_75,CovC2_75);


[PiC1_75,MeansC1_75,CovC1_75]=EM(d,K,C1_75,PiC1_75,MeansC1_75,CovC1_75,logLikeC1_75);
[PiC2_75,MeansC2_75,CovC2_75]=EM(d,K,C2_75,PiC2_75,MeansC2_75,CovC2_75,logLikeC2_75);


minX=min([min(C1(:,1)),min(C2(:,1))]);
minY=min([min(C1(:,2)),min(C2(:,2))]);
maxX=max([max(C1(:,1)),max(C2(:,1))]);
maxY=max([max(C1(:,2)),max(C2(:,2))]);

P1=sizeC1(1,1)/(sizeC1(1,1)+sizeC2(1,1));
P2=sizeC2(1,1)/(sizeC1(1,1)+sizeC2(1,1));

for x=minX:0.1:maxX
    for y=minY:0.1:maxY;
        t=[x y];
        g1=log(GMM_LIKELIHOOD(d,t,K,PiC1_75,MeansC1_75,CovC1_75))+log(P1);
        g2=log(GMM_LIKELIHOOD(d,t,K,PiC2_75,MeansC2_75,CovC2_75))+log(P2);
        if(g1>g2)
            plot(x,y,'r');
        elseif(g2>g1)
            plot(x,y,'y');
        else
            plot(x,y,'k');
        end
        hold on;
    end
end

confMat=[0 0;0 0];
same1_2=0;
same2_1=0;

for i=1:sizeC1_25(1:1)
    g1=log(GMM_LIKELIHOOD(d,C1_25(i,:),K,PiC1_75,MeansC1_75,CovC1_75))+log(P1);
    g2=log(GMM_LIKELIHOOD(d,C1_25(i,:),K,PiC2_75,MeansC2_75,CovC2_75))+log(P2);
    if(g1>g2)
          confMat(1,1)=confMat(1,1)+1;
    elseif(g2>g1)
        confMat(1,2)=confMat(1,2)+1;
    else
        same1_2=same1_2+1;
    end
end
 
for i=1:sizeC2_25(1:1)
    g1=log(GMM_LIKELIHOOD(d,C2_25(i,:),K,PiC1_75,MeansC1_75,CovC1_75))+log(P1);
    g2=log(GMM_LIKELIHOOD(d,C2_25(i,:),K,PiC2_75,MeansC2_75,CovC2_75))+log(P2);
    if(g1>g2)
          confMat(2,1)=confMat(2,1)+1;
    elseif(g2>g1)
        confMat(2,2)=confMat(2,2)+1;
    else
        same2_1=same2_1+1;
    end
end

typeK=strcat(type,int2str(K));
CM=strcat(typeK,'ConfusionMatrix.txt');
CM_FD=fopen(CM,'w+');
fprintf(CM_FD,'%f\t%f\n%f\t%f\n(1-2)\t%f\t\t(2-1)\t%f\n\n\n',confMat(1,1),confMat(1,2),confMat(2,1),confMat(2,2),same1_2,same2_1);
plot(C1_75(:,1),C1_75(:,2),'.',C2_75(:,1),C2_75(:,2),'*');
name=strcat(typeK,'_Class_1(.)_and_2(*)');
title(name);
print(name,'-dpng');
hold off;

