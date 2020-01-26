
[healthyAnnotations] = dataAnnotation("healthy");
[glaucomaAnnotations] = dataAnnotation("glaucoma");

dataAnnotations = [healthyAnnotations; glaucomaAnnotations];

global healthyDataFeatures;
[healthyDataFeatures] = extractFeatures("healthy");

global glaucomaDataFeatures;
[glaucomaDataFeatures] = extractFeatures("glaucoma");

global trainingData;
trainingData = [healthyDataFeatures(1:8,:); glaucomaDataFeatures(1:8,:)];

global testData;
testData = [healthyDataFeatures(9:12,:); glaucomaDataFeatures(9:12,:)];

[predictedLabels] = testClassifier();

