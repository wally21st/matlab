function phase = unwrapZW2_matrix(x)
[row,column]=size(x);
if(row ~= column || mod(row,2)==1)
    error('输入矩阵规格有误，此算法须偶数行的方阵！！！');
end
R = fix(row/2);   C=fix(column/2);  % the ceCter

%确定中心四点
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

%确定对角线
mat4 = zeros(R,C,4);
mat4(:,:,1) = x(R:-1:1,R:-1:1); %左上块旋转180度
mat4(:,:,2) = x(R:-1:1,C+1:column); %右上块上下翻转
mat4(:,:,3) = x(R+1:row,C:-1:1); %左下块左右翻转
mat4(:,:,4) = x(R+1:row,C+1:column); %右下块原样
for k=1:R-1
    tempUp = mat4(k+1,k+1,:) - mat4(k,k,:) <= -3.1416;
    tempDown = mat4(k+1,k+1,:) - mat4(k,k,:) >= 3.1416;
    temp = tempUp - tempDown;
    mat4(k+1,k+1,:) = mat4(k+1,k+1,:) + temp*6.2832;
end
x(1:R,1:C) = rot90(mat4(:,:,1),2);
x(1:R,C+1:column) = flipud(mat4(:,:,2));
x(R+1:row,1:C) = fliplr(mat4(:,:,3));
x(R+1:row,C+1:column) = mat4(:,:,4);

%确定上、右、下、左大三角
mat4 = zeros(row,column,4);
mat4(:,:,1) = rot90( tril( rot90( triu(x),1 ) ),3 ); %上
mat4(:,:,2) = triu( rot90( triu(x),1 ) ); %右 
mat4(:,:,3) = rot90( triu( rot90( tril(x),1 ) ),1 ); %下
mat4(:,:,4) = rot90( tril( rot90( tril(x),1 ) ),2 ); % 左
for k=0:R-2
    stepUp = mat4(R-k-1,C-k:C+k+1,:) - mat4(R-k,C-k:C+k+1,:) <= -3.1416;
    stepDown = mat4(R-k-1,C-k:C+k+1,:) - mat4(R-k,C-k:C+k+1,:) >= 3.1416;
    step = stepUp - stepDown;
    mat4(R-k-1,C-k:C+k+1,:) = mat4(R-k-1,C-k:C+k+1,:) + step*6.2832;
end
x = triu(mat4(:,:,1),1)+rot90(triu(mat4(:,:,2),1),3)+rot90(triu(mat4(:,:,3),1),2)+rot90(triu(mat4(:,:,4),1),1);

phase = x;