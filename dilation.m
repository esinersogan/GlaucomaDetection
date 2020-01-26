function y = dilation(gI,se)
    [m,n] = size(gI);
    [k,l] = size(se);
    %find center of se
    if(rem(k,2)==1)
        s = (k+1)/2;
    else
        s = k/2;
    end
    if(rem(l,2)==1)
        r = (l+1)/2;
    else
        r = l/2;
    end
    out= zeros(m,n);
    for i=1:m %until the end horizontally
        for j=1:n %until the end vertically
            %if there is any 1 in the image we need to fill its around
            %according to structuring element
            if (gI(i,j)==1)
                x1=i-s+1; %left bound of structuring element
                x2=i+s-1; %right bound of structuring element
                y1=j-r+1; %upper bound of structuring element
                y2=j+r-1; %lower bound of structuring element
                %if bounds exceeds the edges of the image
                if (x1<1)
                    x1=1;
                end
                if(x2>m)
                    x2=m;
                end
                if(y1<1)
                    y1=1;
                end
                if(y2>n)
                    y2=n;
                end
                
                p=0;
                q=0;
                %With these 2 for loops I am scanning the se. 
                for x=x1:x2
                    if(p<k)
                        p=p+1;
                    end
                    for y=y1:y2
                        if(q<l)
                            q = q+1;
                        end
                        %if se has any "1" pixel in it, I fill output images'
                        %that pixel as one
                        if(se(p,q)==1)
                            out(x,y)=1;
                        end
                    end
                end
            end
        end
    end
    y=out;
end