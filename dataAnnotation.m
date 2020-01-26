function [annotationLabels] = dataAnnotation(folderName)

    labels = [];
    fileExtension = fullfile(folderName, '*.jpg'); 
    files = dir(fileExtension);
    
    for k = 1 : length(files)
        root = files(k).name;
        filename = convertCharsToStrings(root);
        
        result = strsplit(filename, '_');
        result = strsplit(result(2), '.');
        
        labels = [labels; filename result(1)];
        
        %labels = [labels; result(1)];
        
    end 
    
    annotationLabels = labels;
end