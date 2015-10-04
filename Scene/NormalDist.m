function [ density_value ] = NormalDist( X, mu, sigma )
%%X can be a 1*P example 
% mu has to be a 1*P vector too
%sigma will be P*P matrix
    d = size(X,2);
    %sigma = diag(diag(sigma));
    %density_value = (1/(((2*pi)^(d/2))*(det(sigma)^(1/2))))*exp((-1/2)*(X-mu)*(sigma\(X'-mu')));
    density_value = mvnpdf(X,mu,sigma);
end

