function y=unwrapWL_regular(x)

[row,column] = size(x);
for interaction=1:100
for r=1:row
    for c=1:column
        if r==1 && c==1 %���Ͻ�
            if x(r+1,c)-x(r,c)<-3.1416 || x(r,c+1)-x(r,c)<-3.1416 
                x(r,c)=x(r,c)-6.2832;
            end
        end
        if r==1 && c==column %���Ͻ�
            if x(r+1,c)-x(r,c)<-3.1416 || x(r,c-1)-x(r,c)<-3.1416 
                x(r,c)=x(r,c)-6.2832;
            end
        end
        if r==row && c==1 %���½�
            if x(r-1,c)-x(r,c)<-3.1416 || x(r,c+1)-x(r,c)<-3.1416 
                x(r,c)=x(r,c)-6.2832;
            end
        end
        if r==row && c==column %���½�
            if x(r-1,c)-x(r,c)<-3.1416 || x(r,c-1)-x(r,c)<-3.1416 
                x(r,c)=x(r,c)-6.2832;
            end
        end
        if r==1 && c~=1 && c~=column %�ϱ߽�
            if x(r+1,c)-x(r,c)<-3.1416 || x(r,c-1)-x(r,c)<-3.1416 || x(r,c+1)-x(r,c)<-3.1416 
                x(r,c)=x(r,c)-6.2832;
            end
        end
        if r==row && c~=1 && c~=column %�±߽�
            if x(r-1,c)-x(r,c)<-3.1416 || x(r,c-1)-x(r,c)<-3.1416 || x(r,c+1)-x(r,c)<-3.1416 
                x(r,c)=x(r,c)-6.2832;
            end
        end
        if c==1 && r~=1 && r~=row %��߽�
            if x(r-1,c)-x(r,c)<-3.1416 || x(r+1,c)-x(r,c)<-3.1416 || x(r,c+1)-x(r,c)<-3.1416 
                x(r,c)=x(r,c)-6.2832;
            end
        end
        if c==column && r~=1 && r~=row %��߽�
            if x(r-1,c)-x(r,c)<-3.1416 || x(r+1,c)-x(r,c)<-3.1416 || x(r,c-1)-x(r,c)<-3.1416 
                x(r,c)=x(r,c)-6.2832;
            end
        end
        if r~=1 && r~=row && c~=1 && c~=column %�ڲ�
            if x(r-1,c)-x(r,c)<-3.1416 || x(r+1,c)-x(r,c)<-3.1416 || x(r,c-1)-x(r,c)<-3.1416 || x(r,c+1)-x(r,c)<-3.1416 
                x(r,c)=x(r,c)-6.2832;
            end
        end
    end
end
end
y=x;