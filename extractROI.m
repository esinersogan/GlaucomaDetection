function [roi] = extractROI(image)

    r = image(:,:,1);
    g = image(:,:,2);
    b = image(:,:,3);
    
    [L,centers] = imsegkmeans(b,8); %7
    B = labeloverlay(b,L);
    imwrite(B,"segkmeans.jpg");
    
    index = unique(L);
    counts = histc(L(:),index);
    
    vec = zeros(1,size(counts,1));
    for i=1:size(L,1)
        for j=1:size(L,2)
            vec(L(i,j)) = vec(L(i,j)) + 1;
        end
    end
    
    xmin = find(vec==min(vec));
    rows=[];
    columns=[];
    
    tmp = zeros(size(image));
    for i=1:size(L,1)
        for j=1:size(L,2)
            if L(i,j)==xmin
                tmp(i,j,:) = image(i,j,:);
                if ismember(i,rows)==0
                    rows=[rows;i];
                end
                if ismember(j,columns)==0
                    columns=[columns;j];
                end
            end
        end
    end
    
    rowcenter = (min(rows)+max(rows))/2;
    colcenter = (min(columns)+max(columns))/2;
    
    roi = image((rowcenter-500):(rowcenter+500),(colcenter-600):(colcenter+500),:);
        
end