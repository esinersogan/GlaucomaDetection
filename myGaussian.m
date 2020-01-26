function [output] = myGaussian(im)
    sigma = 1.4;
    dim = 2;
    [x,y]=meshgrid(-dim:dim,-dim:dim);
    ex = -(x.^2+y.^2)/(2*sigma*sigma);
    kernel= exp(ex)/(2*pi*sigma*sigma);
    
    grad=zeros(size(im));
    
    for i=3:size(im,1)-2
        for j=3:size(im,2)-2
            sum = 0;
            for k=1:5
                for l=1:5
                    sum = sum + kernel(k,l)*im(i-3+k,j-3+l);
                end
            end
            grad(i,j)=sum;
        end
    end
    
    output = uint8(grad);
end