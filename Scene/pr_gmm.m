function [ mus, sigmas, pis ] = pr_gmm( X, init_means, init_covs, init_coeffs )
% X is a matrix of the training examples (N*P matrix) for a class
%   init_means is a cell containing k means each of (1*P matrix),
%   init_covs is a cell of k covs each of (P*P matrix),
%   init_coeff is a cell of k pi constants each a double.
    [N,P] = size(X);
    K = size(init_means,1); %num of cluster components
    mus = init_means;
    sigmas = init_covs;
    pis = init_coeffs;
    i=0;
    iterations = 25;
    prev_log_likelihood = -1;
    while i < iterations
        %E-STEP : Calculate the responsiblity term
        responsibility = zeros(N,K);
        log_likelihood = 0;
        for n=1:N
            denom = 0;
            for k=1:K
                denom = denom + pis{k}*NormalDist(X(n,:),mus{k},sigmas{k});  
            end
            for k=1:K
                responsibility(n,k) = (pis{k}*NormalDist(X(n,:),mus{k},sigmas{k}))/denom;
            end
            log_likelihood = log_likelihood + log(denom);
        end
        
        %EXIT CONDITION
        if(prev_log_likelihood ~= -1 && abs(log_likelihood-prev_log_likelihood) < 0.001*prev_log_likelihood)
            break;
        end
        prev_log_likelihood = log_likelihood;    
        
        %M-STEP : Reestimate using the responsibilty
        for k=1:K
            eff_num_examples_in_cluster = sum(responsibility(:,k));
            mus{k} = (responsibility(:,k)'*X)/eff_num_examples_in_cluster ;
            sigmas{k} = zeros(P,P);
            for n=1:N
                sigmas{k} = sigmas{k} + responsibility(n,k)*(X(n,:)'-mus{k}')*(X(n,:)-mus{k});
            end
            sigmas{k} = sigmas{k}/eff_num_examples_in_cluster;
            pis{k} = eff_num_examples_in_cluster/N;
        end
        i = i + 1;
    end
end

