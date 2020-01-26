function y = erosion(gI,se)
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
    for i=1:m-k+1 %until the end horizontally
        for j=1:n-l+1 %until the end vertically
            In=gI(i:i+k-1,j:j+l-1);
            if(In(se)==1)
                out(i+s-1,j+r-1)=1;
            end
        end
    end
    y=out;
end