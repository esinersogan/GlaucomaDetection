function [predictedLabels] = testClassifier()

    testData = getGlobaltestData;
    labels = [];
    
    for k=1:size(testData,1)
        
        prediction = nearestNeighbor(testData(k,1), testData(k,2));
        labels = [labels; prediction];
        
    end 
    
    predictedLabels = labels;
    
end