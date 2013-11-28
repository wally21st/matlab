function phase = unwrapZW( x )
% use the method of ZhaoJin to unwrap the phase first, then use the method of WJW to inspect. 
% x: the wrapped phase

[row,column]=size(x);

R = fix(row/2);     C = fix(column/2);  % the center

% ZJ
if  x(R,C-1) - x(R,C) >= 3.1416 
    x(R,C-1) = x(R,C-1) - 6.2832;
end
if  x(R,C-1) - x(R,C) <= -3.1416 
    x(R,C-1) = x(R,C-1) + 6.2832;
end
if  x(R,C+1) - x(R,C) >= 3.1416 
    x(R,C+1) = x(R,C+1) - 6.2832;
end 
if  x(R,C+1) - x(R,C) <= -3.1416 
    x(R,C+1) = x(R,C+1) + 6.2832;
end
if  x(R-1,C) - x(R,C) >= 3.1416 
    x(R-1,C) = x(R-1,C) - 6.2832;
end
if  x(R-1,C) - x(R,C) <= -3.1416 
    x(R-1,C) = x(R-1,C) + 6.2832;
end
if  x(R+1,C) - x(R,C) >= 3.1416 
    x(R+1,C) = x(R+1,C) - 6.2832;
end
if  x(R+1,C) - x(R,C) <= -3.1416 
    x(R+1,C) = x(R+1,C) + 6.2832;
end

for k = 1:C-1
    if  x(R-1,C-k) - x(R,C-k) >= 3.1416
        x(R-1,C-k) = x(R-1,C-k) - 6.2832;
    end
    if  x(R-1,C-k) - x(R,C-k) <= -3.1416
        x(R-1,C-k) = x(R-1,C-k) + 6.2832;
    end    
    if  x(R+1,C-k) - x(R,C-k) >= 3.1416
        x(R+1,C-k) = x(R+1,C-k) - 6.2832;
    end
    if  x(R+1,C-k) - x(R,C-k) <= -3.1416
        x(R+1,C-k) = x(R+1,C-k) + 6.2832;
    end    
    if k~=C-1
        if  x(R,C-k-1) - x(R,C-k) >= 3.1416
            x(R,C-k-1) = x(R,C-k-1) - 6.2832;
        end
        if  x(R,C-k-1) - x(R,C-k) <= -3.1416
            x(R,C-k-1) = x(R,C-k-1) + 6.2832;
        end
    end    
end

for k = 1:column-C    
    if  x(R-1,C+k) - x(R,C+k) >= 3.1416
        x(R-1,C+k) = x(R-1,C+k) - 6.2832;
    end
    if  x(R-1,C+k) - x(R,C+k) <= -3.1416
        x(R-1,C+k) = x(R-1,C+k) + 6.2832;
    end    
    if  x(R+1,C+k) - x(R,C+k) >= 3.1416
        x(R+1,C+k) = x(R+1,C+k) - 6.2832;
    end
    if  x(R+1,C+k) - x(R,C+k) <= -3.1416
        x(R+1,C+k) = x(R+1,C+k) + 6.2832;
    end    
    if k~=column-C
        if  x(R,C+k+1) - x(R,C+k) >= 3.1416
            x(R,C+k+1) = x(R,C+k+1) - 6.2832;
        end
        if  x(R,C+k+1) - x(R,C+k) <= -3.1416
            x(R,C+k+1) = x(R,C+k+1) + 6.2832;
        end
    end    
end

for k = 0:3:C-1-1
    if x(R-2,C-k) - x(R-1,C-k) >= 3.1416
        x(R-2,C-k) = x(R-2,C-k) - 6.2832;
    end
    if x(R-2,C-k) - x(R-1,C-k) <= -3.1416
        x(R-2,C-k) = x(R-2,C-k) + 6.2832;
    end    
    for l = 2:R-1
        if x(R-l,C-k-1) - x(R-l,C-k) >= 3.1416
            x(R-l,C-k-1) = x(R-l,C-k-1) - 6.2832;
        end
        if x(R-l,C-k-1) - x(R-l,C-k) <= -3.1416
            x(R-l,C-k-1) = x(R-l,C-k-1) + 6.2832;
        end        
        if x(R-l,C-k+1) - x(R-l,C-k) >= 3.1416
            x(R-l,C-k+1) = x(R-l,C-k+1) - 6.2832;
        end
        if x(R-l,C-k+1) - x(R-l,C-k) <= -3.1416
            x(R-l,C-k+1) = x(R-l,C-k+1) + 6.2832;
        end        
        if l~=R-1
            if x(R-l-1,C-k) - x(R-l,C-k) >= 3.1416
                x(R-l-1,C-k) = x(R-l-1,C-k) - 6.2832;
            end
            if x(R-l-1,C-k) - x(R-l,C-k) <= -3.1416
                x(R-l-1,C-k) = x(R-l-1,C-k) + 6.2832;
            end
        end
    end
    
    if x(R+2,C-k) - x(R+1,C-k) >= 3.1416
        x(R+2,C-k) = x(R+2,C-k) - 6.2832;
    end
    if x(R+2,C-k) - x(R+1,C-k) <= -3.1416
        x(R+2,C-k) = x(R+2,C-k) + 6.2832;
    end
    for l = 2:row-R
        if x(R+l,C-k-1) - x(R+l,C-k) >= 3.1416
            x(R+l,C-k-1) = x(R+l,C-k-1) - 6.2832;
        end
        if x(R+l,C-k-1) - x(R+l,C-k) <= -3.1416
            x(R+l,C-k-1) = x(R+l,C-k-1) + 6.2832;
        end        
        if x(R+l,C-k+1) - x(R+l,C-k) >= 3.1416
            x(R+l,C-k+1) = x(R+l,C-k+1) - 6.2832;
        end
        if x(R+l,C-k+1) - x(R+l,C-k) <= -3.1416
            x(R+l,C-k+1) = x(R+l,C-k+1) + 6.2832;
        end        
        if l~=row-R
            if x(R+l+1,C-k) - x(R+l,C-k) >= 3.1416
                x(R+l+1,C-k) = x(R+l+1,C-k) - 6.2832;
            end
            if x(R+l+1,C-k) - x(R+l,C-k) <= -3.1416
                x(R+l+1,C-k) = x(R+l+1,C-k) + 6.2832;
            end
        end
    end
end

for k = 3:3:column-C-1    
    if x(R-2,C+k) - x(R-1,C+k) >= 3.1416
        x(R-2,C+k) = x(R-2,C+k) - 6.2832;
    end
    if x(R-2,C+k) - x(R-1,C+k) <= -3.1416
        x(R-2,C+k) = x(R-2,C+k) + 6.2832;
    end 
    for l = 2:R-1
        if x(R-l,C+k-1) - x(R-l,C+k) >= 3.1416
            x(R-l,C+k-1) = x(R-l,C+k-1) - 6.2832;
        end
        if x(R-l,C+k-1) - x(R-l,C+k) <= -3.1416
            x(R-l,C+k-1) = x(R-l,C+k-1) + 6.2832;
        end
        if x(R-l,C+k+1) - x(R-l,C+k) >= 3.1416
            x(R-l,C+k+1) = x(R-l,C+k+1) - 6.2832;
        end
        if x(R-l,C+k+1) - x(R-l,C+k) <= -3.1416
            x(R-l,C+k+1) = x(R-l,C+k+1) + 6.2832;
        end
        if l~=R-1
            if x(R-l-1,C+k) - x(R-l,C+k) >= 3.1416
                x(R-l-1,C+k) = x(R-l-1,C+k) - 6.2832;
            end
            if x(R-l-1,C+k) - x(R-l,C+k) <= -3.1416
                x(R-l-1,C+k) = x(R-l-1,C+k) + 6.2832;
            end
        end
    end
    
    if x(R+2,C+k) - x(R+1,C+k) >= 3.1416    %改x(R-1,C+k)为x(R+1,C+k)
        x(R+2,C+k) = x(R+2,C+k) - 6.2832;
    end
    if x(R+2,C+k) - x(R+1,C+k) <= -3.1416   %改x(R-1,C+k)为x(R+1,C+k)
        x(R+2,C+k) = x(R+2,C+k) + 6.2832;
    end 
    for l = 2:row-R
        if x(R+l,C+k-1) - x(R+l,C+k) >= 3.1416
            x(R+l,C+k-1) = x(R+l,C+k-1) - 6.2832;
        end
        if x(R+l,C+k-1) - x(R+l,C+k) <= -3.1416
            x(R+l,C+k-1) = x(R+l,C+k-1) + 6.2832;
        end
        if x(R+l,C+k+1) - x(R+l,C+k) >= 3.1416
            x(R+l,C+k+1) = x(R+l,C+k+1) - 6.2832;
        end
        if x(R+l,C+k+1) - x(R+l,C+k) <= -3.1416
            x(R+l,C+k+1) = x(R+l,C+k+1) + 6.2832;
        end
        if l~=row-R
            if x(R+l+1,C+k) - x(R+l,C+k) >= 3.1416
                x(R+l+1,C+k) = x(R+l+1,C+k) - 6.2832;
            end
            if x(R+l+1,C+k) - x(R+l,C+k) <= -3.1416
                x(R+l+1,C+k) = x(R+l+1,C+k) + 6.2832;
            end
        end
    end
end

% WJW
if x(R,R+1)-x(R,R)>=3.1416
    x(R,R+1)=x(R,R+1)-6.2832;
end
if x(R,R+1)-x(R,R)<=-3.1416
    x(R,R+1)=x(R,R+1)+6.2832;
end
if x(R+1,R)-x(R,R)>=3.1416
    x(R+1,R)=x(R+1,R)-6.2832;
end
if x(R+1,R)-x(R,R)<=-3.1416
    x(R+1,R)=x(R+1,R)+6.2832;
end
if x(R+1,R+1)-x(R,R)>=3.1416
    x(R+1,R+1)=x(R+1,R+1)-6.2832;
end
if x(R+1,R+1)-x(R,R)<=-3.1416
    x(R+1,R+1)=x(R+1,R+1)+6.2832;
end


for n=1:R-1
    %上边界
    for m=1:(2*n)
        if x(R-n,R-n+m)-x(R-n+1,R-n+m)>=3.1416
              x(R-n,R-n+m)=x(R-n,R-n+m)-6.2832;
        end
        if x(R-n,R-n+m)-x(R-n+1,R-n+m)<=-3.1416
              x(R-n,R-n+m)=x(R-n,R-n+m)+6.2832;
        end
    end
    %下边界
    for m=1:(2*n)
        if x(R+1+n,R-n+m)-x(R+1+n-1,R-n+m)>=3.1416
              x(R+1+n,R-n+m)=x(R+1+n,R-n+m)-6.2832;
        end
        if x(R+1+n,R-n+m)-x(R+1+n-1,R-n+m)<=-3.1416
              x(R+1+n,R-n+m)=x(R+1+n,R-n+m)+6.2832;
        end
    end
    %左边界
    for m=1:(2*n)
        if x(R-n+m,R-n)-x(R-n+m,R-n+1)>=3.1416
              x(R-n+m,R-n)=x(R-n+m,R-n)-6.2832;
        end 
        if x(R-n+m,R-n)-x(R-n+m,R-n+1)<=-3.1416
              x(R-n+m,R-n)=x(R-n+m,R-n)+6.2832;
        end
    end
    %右边界
    for m=1:(2*n)
        if x(R-n+m,R+1+n)-x(R-n+m,R+1+n-1)>=3.1416
              x(R-n+m,R+1+n)=x(R-n+m,R+1+n)-6.2832;
        end
        if x(R-n+m,R+1+n)-x(R-n+m,R+1+n-1)<=-3.1416
              x(R-n+m,R+1+n)=x(R-n+m,R+1+n)+6.2832;
        end
    end
    %左上角
    if x(R-n,R-n)-x(R-n+1,R-n+1)>=3.1416
          x(R-n,R-n)=x(R-n,R-n)-6.2832;
    end 
    if x(R-n,R-n)-x(R-n+1,R-n+1)<=-3.1416
          x(R-n,R-n)=x(R-n,R-n)+6.2832;
    end
    %右上角
    if x(R-n,R+1+n)-x(R-n+1,R+1+n-1)>=3.1416
          x(R-n,R+1+n)=x(R-n,R+1+n)-6.2832;
    end
    if x(R-n,R+1+n)-x(R-n+1,R+1+n-1)<=-3.1416
          x(R-n,R+1+n)=x(R-n,R+1+n)+6.2832;
    end
    %左下角
    if x(R+1+n,R-n)-x(R+1+n-1,R-n+1)>=3.1416
          x(R+1+n,R-n)=x(R+1+n,R-n)-6.2832;
    end
    if x(R+1+n,R-n)-x(R+1+n-1,R-n+1)<=-3.1416
          x(R+1+n,R-n)=x(R+1+n,R-n)+6.2832;
    end
    %右下角
    if x(R+1+n,R+1+n)-x(R+1+n-1,R+1+n-1)>=3.1416
          x(R+1+n,R+1+n)=x(R+1+n,R+1+n)-6.2832;
    end
    if x(R+1+n,R+1+n)-x(R+1+n-1,R+1+n-1)<=-3.1416
          x(R+1+n,R+1+n)=x(R+1+n,R+1+n)+6.2832;
    end
end

% the result
phase = x;