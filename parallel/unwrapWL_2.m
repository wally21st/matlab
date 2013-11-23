function y=unwrapWL_2(x)

[row,column] = size(x);
x=single(x);
x=gpuArray(x);
for interaction=1:10
    count=0;
    arrayRC=gpuArray(zeros(row*column,2,'single'));%%%
    for r=gpuArray(1:row)
        for c=gpuArray(1:column)
            if r==1 && c==1 %���Ͻ�
                if x(r+1,c)-x(r,c)>3.1416 || x(r,c+1)-x(r,c)>3.1416 
                    count=count+1; arrayRC(count,1)=r; arrayRC(count,2)=c; 
                end
            end
            if r==1 && c==column %���Ͻ�
                if x(r+1,c)-x(r,c)>3.1416 || x(r,c-1)-x(r,c)>3.1416 
                    count=count+1; arrayRC(count,1)=r; arrayRC(count,2)=c;
                end
            end
            if r==row && c==1 %���½�
                if x(r-1,c)-x(r,c)>3.1416 || x(r,c+1)-x(r,c)>3.1416 
                    count=count+1; arrayRC(count,1)=r; arrayRC(count,2)=c;
                end
            end
            if r==row && c==column %���½�
                if x(r-1,c)-x(r,c)>3.1416 || x(r,c-1)-x(r,c)>3.1416 
                    count=count+1; arrayRC(count,1)=r; arrayRC(count,2)=c;
                end
            end
            if r==1 && c~=1 && c~=column %�ϱ߽�
                if x(r+1,c)-x(r,c)>3.1416 || x(r,c-1)-x(r,c)>3.1416 || x(r,c+1)-x(r,c)>3.1416 
                    count=count+1; arrayRC(count,1)=r; arrayRC(count,2)=c;
                end
            end
            if r==row && c~=1 && c~=column %�±߽�
                if x(r-1,c)-x(r,c)>3.1416 || x(r,c-1)-x(r,c)>3.1416 || x(r,c+1)-x(r,c)>3.1416 
                    count=count+1; arrayRC(count,1)=r; arrayRC(count,2)=c;
                end
            end
            if c==1 && r~=1 && r~=row %��߽�
                if x(r-1,c)-x(r,c)>3.1416 || x(r+1,c)-x(r,c)>3.1416 || x(r,c+1)-x(r,c)>3.1416 
                    count=count+1; arrayRC(count,1)=r; arrayRC(count,2)=c;
                end
            end
            if c==column && r~=1 && r~=row %�ұ߽�
                if x(r-1,c)-x(r,c)>3.1416 || x(r+1,c)-x(r,c)>3.1416 || x(r,c-1)-x(r,c)>3.1416 
                    count=count+1; arrayRC(count,1)=r; arrayRC(count,2)=c;
                end
            end
            if r~=1 && r~=row && c~=1 && c~=column %�ڲ�
                if x(r-1,c)-x(r,c)>3.1416 || x(r+1,c)-x(r,c)>3.1416 || x(r,c-1)-x(r,c)>3.1416 || x(r,c+1)-x(r,c)>3.1416 
                    count=count+1; arrayRC(count,1)=r; arrayRC(count,2)=c;
                end
            end
        end
    end
    %disp(count);
    for cc=gpuArray(1:count)
        x(arrayRC(cc,1),arrayRC(cc,2)) = x(arrayRC(cc,1),arrayRC(cc,2)) + 6.2832;
    end
end
y=double(gather(x));