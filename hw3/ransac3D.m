function [ bestfit ] = ransac3D(data, n, k, t, d)
%RANSAC - algorithm to fit model to data with many outliers
%   INPUTS
%   data - a set of observed data points
%   model - a model that can be fitted to data points
%   n - the minimum number of data values required to fit the model
%   k - the maximum number of iterations allowed in the algorithm
%   t - a threshold value for determining when a data point fits a model
%   d - the number of close data values required to assert that a model fits well to data
%   OUTPUTS
%   bestfit - model parameters which best fit the data (or nil if no good model is found)

bestfit = [];
besterr = 99999999;

for i = 1:k
    sampleIndx = randperm(size(data,1));
    possibleInliers = data(sampleIndx(1:n),:);
    
    %compute SVD (least squares solution)
    modelParams = possibleInliers\ones(size(possibleInliers,1),1);
    alsoInliers = [];
    
    
    
    %for every point in data not in possibleInliers
    %check distances that all data lies from our current model
    %|a*x1+b*x2+c*x3-1|/sqrt(a^2+b^2+c^2)
    distances = abs(data*modelParams-1)/sqrt(sum(modelParams.^2));
    
    %find number of points close to line (under err threshold)
    numUndrThresh = sum(distances<t);
    
    %continue on any model that has appropriate number of close data values
    if (numUndrThresh >= d)
        %hone in on the GOOD possible inliers (less than threshold)
        possibleInliers = data(distances < t,:);
        
        %redo model
        modelParams = possibleInliers\ones(size(possibleInliers,1),1);
        
        %compute error
        distances = abs(possibleInliers*modelParams-1)/sqrt(sum(modelParams.^2));
        err = sqrt(distances'*distances) / size(possibleInliers,1);
        
        %save the best error and best model
        if (err < besterr)
           besterr = err;
           bestfit = modelParams;
        end
        
        
    end
    
    
end
 




end

