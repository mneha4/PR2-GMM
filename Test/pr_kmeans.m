function [ cluster_means, cluster_covs, cluster_mix_coeffs, J ] = pr_kmeans( X , K )
%Implementation of kmeans clustering algo
%   Given a matrix X of dim N*P where N is data points and P are the variable(attribute)
%   values, and K is number of expected of clusters, pr_kmeans returns K*P
%   centroids for the cluster. KMeans uses the Expectation maximization to 
%   estimate the centroids.
  

    N = size(X,1);
    P = size(X,2);  
   
    if N < K
        error('Cannot make more cluster than data points');
    else
        cluster_means = X(N-K+1:end,:);
       
        sq_euc_dist = @(x,y) sum((x-y).^2);

        iterations = 50;
        i = 0;

        prevJ = inf;
        while i < iterations
            %E-step For each point in x calculate distance and assign 1 to the 
            %minimum
            R = zeros(N,K); %Indicator that nth point lies in kth cluster
            clusters = cell(1,K);
            J = 0;
            for n = 1:N
               min_dist = inf;
               min_dist_ind = 1;
               for k = 1:K
                  distance = sq_euc_dist(X(n,:),cluster_means(k,:));
                  if(distance < min_dist) 
                    min_dist = distance;
                    min_dist_ind = k;
                  end
               end
               R(n,min_dist_ind) = 1;
               J = J + min_dist;
            end
            J;
            if (abs(prevJ - J)) < 0.0001
                break;
            end
            prevJ = J;
            %M-step Make the cluster center as the mean of the points
            %assigned to the center k
            
           
            for k = 1:K
                for n = 1:N
                    if(R(n,k) == 1)
                        clusters{k} = [clusters{k} ; X(n,:)]; 
                    end
                end
                cluster_means(k,:) = mean(clusters{k});
                cluster_covs{k} = cov(clusters{k});
                cluster_mix_coeffs(k,:) = size(clusters{k},1)/N;
            end
           
            i = i + 1;
        end
        
    end
end

