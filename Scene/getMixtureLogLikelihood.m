function [ log_likelihood ] = getMixtureLogLikelihood(X, params)
%X is a sample example(test) with 
%   Detailed explanation goes here
    log_likelihood = 0;
    N = size(X,1);
    mus = params{1};
    sigmas = params{2};
    pis = params{3};
    K = size(mus,1);
    for n=1:N
        total = 0;
        for k=1:K
            total = total + pis{k}*NormalDist(X(n,:),mus{k},sigmas{k});  
        end
        log_likelihood = log_likelihood + log(total);
    end
end

