function y=unwrapWL_random(x)

[row,column] = size(x);
for interaction=1:100
for randPickNum = 1:row*column/2
    rc=ceil(row*rand(1,2));r=rc(1);c=rc(2);
        if r==1 && c==1 %左上角
            if x(r+1,c)-x(r,c)<-3.1416 || x(r,c+1)-x(r,c)<-3.1416 
                x(r,c)=x(r,c)-6.2832;
            end
        end
        if r==1 && c==column %右上角
            if x(r+1,c)-x(r,c)<-3.1416 || x(r,c-1)-x(r,c)<-3.1416 
                x(r,c)=x(r,c)-6.2832;
            end
        end
        if r==row && c==1 %左下角
            if x(r-1,c)-x(r,c)<-3.1416 || x(r,c+1)-x(r,c)<-3.1416 
                x(r,c)=x(r,c)-6.2832;
            end
        end
        if r==row && c==column %右下角
            if x(r-1,c)-x(r,c)<-3.1416 || x(r,c-1)-x(r,c)<-3.1416 
                x(r,c)=x(r,c)-6.2832;
            end
        end
        if r==1 && c~=1 && c~=column %上边界
            if x(r+1,c)-x(r,c)<-3.1416 || x(r,c-1)-x(r,c)<-3.1416 || x(r,c+1)-x(r,c)<-3.1416 
                x(r,c)=x(r,c)-6.2832;
            end
        end
        if r==row && c~=1 && c~=column %下边界
            if x(r-1,c)-x(r,c)<-3.1416 || x(r,c-1)-x(r,c)<-3.1416 || x(r,c+1)-x(r,c)<-3.1416 
                x(r,c)=x(r,c)-6.2832;
            end
        end
        if c==1 && r~=1 && r~=row %左边界
            if x(r-1,c)-x(r,c)<-3.1416 || x(r+1,c)-x(r,c)<-3.1416 || x(r,c+1)-x(r,c)<-3.1416 
                x(r,c)=x(r,c)-6.2832;
            end
        end
        if c==column && r~=1 && r~=row %左边界
            if x(r-1,c)-x(r,c)<-3.1416 || x(r+1,c)-x(r,c)<-3.1416 || x(r,c-1)-x(r,c)<-3.1416 
                x(r,c)=x(r,c)-6.2832;
            end
        end
        if r~=1 && r~=row && c~=1 && c~=column %内部
            if x(r-1,c)-x(r,c)<-3.1416 || x(r+1,c)-x(r,c)<-3.1416 || x(r,c-1)-x(r,c)<-3.1416 || x(r,c+1)-x(r,c)<-3.1416 
                x(r,c)=x(r,c)-6.2832;
            end
        end
    
end
end
y=x;