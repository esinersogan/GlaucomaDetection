function [predictedClass] = nearestNeighbor(opticCup, opticDisc)

    trainingDataList = getGlobaltrainingData;
    
    absoluteDiff = [];
    
    for i=1:size(trainingDataList)
        absoluteDiff = [absoluteDiff; (abs(opticCup-trainingDataList(i,1)) + abs(opticDisc-trainingDataList(i,2)))];
    end
    
    minDiffIndex = find(absoluteDiff == min(absoluteDiff));
    
    predictedClass = trainingDataList(minDiffIndex,4);
end

