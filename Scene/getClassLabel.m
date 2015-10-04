function [ predicted_label ] = getClassLabel(testSample, classes, num_classes )
    max_likelihood = 0;
    predicted_label = 0;  
    for c=1:num_classes
       likelihood = getMixtureLogLikelihood(testSample,classes{c});
       if(likelihood > max_likelihood)
            max_likelihood = likelihood;
            predicted_label = c;
       end
    end
end

