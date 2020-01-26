function [dataFeatures] = extractFeatures(folder)
    
    dataFeatures = [];
    fileExtension = fullfile(folder, '*.jpg'); 
    files = dir(fileExtension);
    
    for k = 1 : length(files)
        root = files(k).name;
        filename = fullfile(folder, root);
        imrgb = imread(filename);
        
        file = convertCharsToStrings(root);
        result = strsplit(file, '_');
        label = strsplit(result(2), '.');
        
        [roi] = extractROI(imrgb);
        
        redChannel = roi(:,:,1);
        greenChannel = roi(:,:,2);
        blueChannel = roi(:,:,3);
        
        imwrite(redChannel,"redChannel.jpg");
        imwrite(greenChannel,"greenChannel.jpg");
        imwrite(blueChannel,"blueChannel.jpg");
        
        greenChannel = adapthisteq(greenChannel,'clipLimit', 0.02,'NumTiles',[10 10]);
        
        greenChannel = double(greenChannel);
        redChannel = double(redChannel);
        
        greenChannel = myGaussian(greenChannel);
        redChannel = myGaussian(redChannel);
        
        meang = mean(greenChannel, 'all');
        meanr = mean(redChannel, 'all');
        
        stdg = std2(greenChannel);
        stdr = std2(redChannel);
        
        OD = redChannel - meanr - stdr;    
        stdOD = std2(OD);
        Thr = 0.4*stdr - std2(OD);  
        
        for i=1:size(OD,1)
            for j=1:size(OD,2)
                if OD(i,j)>Thr
                    OD(i,j)=255;
                else
                    OD(i,j)=0;
                end
            end
        end
        
        imwrite(OD,"OD.jpg");
        
        OC = greenChannel - meang - stdg;	
        meanOC = mean(OC,'all');                         
        stdOC = std2(OC);                         
        Thg =  2*stdOC + 2*meanOC;      
        
        for i=1:size(OC,1)
            for j=1:size(OC,2)
                if OC(i,j)>Thg
                    OC(i,j)=255;
                else
                    OC(i,j)=0;
                end
            end
        end
        
        cup=imbinarize(OC);
        
        cup = dilation(cup,getnhood(offsetstrel('ball',2,2)));
        cup = erosion(cup, getnhood(offsetstrel('ball',2,2)));
        
        cup = erosion(cup, getnhood(offsetstrel('ball',7,7)));
        cup = dilation(cup,getnhood(offsetstrel('ball',7,7)));
        
        cup = dilation(cup,getnhood(offsetstrel('ball',1,14)));
        cup = erosion(cup, getnhood(offsetstrel('ball',1,14)));
        
        cup = erosion(cup,getnhood(offsetstrel('ball',17,1)));
        cup = dilation(cup,getnhood(offsetstrel('ball',17,1)));
        
        cup = dilation(cup,getnhood(offsetstrel('ball',14,14)));
        % cup = erosion(cup, getnhood(offsetstrel('ball',21,21)));
        
        % cup = erosion(cup,getnhood(offsetstrel('ball',28,28)));
        % cup = dilation(cup,getnhood(offsetstrel('ball',28,28)));
        
        disc=imbinarize(OD);
        
        disc = dilation(disc,getnhood(offsetstrel('ball',2,2)));
        disc = erosion(disc, getnhood(offsetstrel('ball',2,2)));
        
        disc = erosion(disc, getnhood(offsetstrel('ball',7,7)));
        disc = dilation(disc,getnhood(offsetstrel('ball',7,7)));
        
        disc = dilation(disc,getnhood(offsetstrel('ball',1,14)));
        disc = erosion(disc, getnhood(offsetstrel('ball',1,14)));
        
        disc = erosion(disc,getnhood(offsetstrel('ball',17,1)));
        disc = dilation(disc,getnhood(offsetstrel('ball',17,1)));
         
        disc = dilation(disc,getnhood(offsetstrel('ball',21,21)));
        disc = erosion(disc, getnhood(offsetstrel('ball',21,21)));
        
        % disc = erosion(disc,getnhood(offsetstrel('ball',28,28)));
        % disc = dilation(disc,getnhood(offsetstrel('ball',28,28)));
        
        onesoc=0;
        for i=1:size(cup,1)
            for j=1:size(cup,2)
                if cup(i,j)==1
                    onesoc=onesoc+1;
                end
            end
        end
        
        onesod=0;
        for i=1:size(disc,1)
            for j=1:size(disc,2)
                if disc(i,j)==1
                    onesod=onesod+1;
                end
            end
        end
        
        dataFeatures = [dataFeatures; onesoc onesod file label(1)];
        
    end
    
end