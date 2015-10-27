for i=1:8
    ggt=strcat('Interlock8Class1_75Cluster',int2str(i),'.txt');
    M=dlmread(ggt);
    if(i==1)
        plot(M(:,1),M(:,2),'*r');
    elseif(i==2)
        plot(M(:,1),M(:,2),'*c');
    elseif(i==3)
        plot(M(:,1),M(:,2),'*k');
    elseif(i==4)
        plot(M(:,1),M(:,2),'*y');
    elseif(i==5)
        plot(M(:,1),M(:,2),'*g');
    elseif(i==6)
        plot(M(:,1),M(:,2),'*b');
    elseif(i==7)
        plot(M(:,1),M(:,2),'*w');
    elseif(i==8)
        plot(M(:,1),M(:,2),'*m');
    end
    hold on;
end



for i=1:8
    ggt=strcat('Interlock8Class2_75Cluster',int2str(i),'.txt');
    M=dlmread(ggt);
    if(i==1)
        plot(M(:,1),M(:,2),'*r');
    elseif(i==2)
        plot(M(:,1),M(:,2),'*c');
    elseif(i==3)
        plot(M(:,1),M(:,2),'*k');
    elseif(i==4)
        plot(M(:,1),M(:,2),'*y');
    elseif(i==5)
        plot(M(:,1),M(:,2),'*g');
    elseif(i==6)
        plot(M(:,1),M(:,2),'*b');
    elseif(i==7)
        plot(M(:,1),M(:,2),'*w');
    elseif(i==8)
        plot(M(:,1),M(:,2),'*m');
    end
    hold on;
end