function phase = unwrapZW_vector( x )
% use the method of ZhaoJin to unwrap the phase first, then use the method of WJW to inspect. 
% x: the wrapped phase

[row,column]=size(x);

R = fix(row/2);     C = fix(column/2);  % the center

%%%%%%%%%%%%%%%%%%%%%%% ZJ
%确定中间横线基准线
for k = 1:C-1
    if x(R,C-k) - x(R,C-k+1) >= 3.1416
        x(R,C-k) = x(R,C-k) - 6.2832;
    end
    if x(R,C-k) - x(R,C-k+1) <= -3.1416
        x(R,C-k) = x(R,C-k) + 6.2832;
    end
end
for k = 1:column-C
    if x(R,C+k) - x(R,C+k-1) >= 3.1416
        x(R,C+k) = x(R,C+k) - 6.2832;
    end
    if x(R,C+k) - x(R,C+k-1) <= -3.1416
        x(R,C+k) = x(R,C+k) + 6.2832;
    end
end

%确定基准线上下两侧的两条横线
for upDown=[-1,1]
    indexNeedDown = x(R+upDown,1:column) - x(R,1:column) >= 3.1416;
    indexNeedUp = x(R+upDown,1:column) - x(R,1:column) <= -3.1416;
    index = indexNeedUp - indexNeedDown;
    x(R+upDown,:) = x(R+upDown,:) + index*6.2832;
end

%确定隔三的纵线
leftStart = mod(C+1,3)+2; rightEnd = column - mod(column-C-1,3)-1;
indexNeedDown = zeros(1,column);  indexNeedUp = zeros(1,column);
for rr = 2:R-1
    indexNeedDown(leftStart:3:rightEnd) = x(R-rr,leftStart:3:rightEnd) - x(R-rr+1,leftStart:3:rightEnd) >= 3.1416;
    indexNeedUp(leftStart:3:rightEnd) = x(R-rr,leftStart:3:rightEnd) - x(R-rr+1,leftStart:3:rightEnd) <= -3.1416;
    index = indexNeedUp - indexNeedDown;
    x(R-rr,:) = x(R-rr,:) + index*6.2832;
end
for rr = 2:row-R
    indexNeedDown(leftStart:3:rightEnd) = x(R+rr,leftStart:3:rightEnd) - x(R+rr-1,leftStart:3:rightEnd) >= 3.1416;
    indexNeedUp(leftStart:3:rightEnd) = x(R+rr,leftStart:3:rightEnd) - x(R+rr-1,leftStart:3:rightEnd) <= -3.1416;
    index = indexNeedUp - indexNeedDown;
    x(R+rr,:) = x(R+rr,:) + index*6.2832;
end

%确定各隔三纵线左右两侧的纵线
indexNeedDown = zeros(row,column);  indexNeedUp = zeros(row,column);
indexNeedDown([1:R-2,R+2:row],leftStart-1:3:rightEnd-1) = x([1:R-2,R+2:row],leftStart-1:3:rightEnd-1) - x([1:R-2,R+2:row],leftStart:3:rightEnd) >= 3.1416;
indexNeedUp([1:R-2,R+2:row],leftStart-1:3:rightEnd-1) = x([1:R-2,R+2:row],leftStart-1:3:rightEnd-1) - x([1:R-2,R+2:row],leftStart:3:rightEnd) <= -3.1416;
index = indexNeedUp - indexNeedDown;
x = x + index*6.2832;

indexNeedDown = zeros(row,column);  indexNeedUp = zeros(row,column);
indexNeedDown([1:R-2,R+2:row],leftStart+1:3:rightEnd+1) = x([1:R-2,R+2:row],leftStart+1:3:rightEnd+1) - x([1:R-2,R+2:row],leftStart:3:rightEnd) >= 3.1416;
indexNeedUp([1:R-2,R+2:row],leftStart+1:3:rightEnd+1) = x([1:R-2,R+2:row],leftStart+1:3:rightEnd+1) - x([1:R-2,R+2:row],leftStart:3:rightEnd) <= -3.1416;
index = indexNeedUp - indexNeedDown;
x = x + index*6.2832;

%%%%%%%%%%%%%%%%%%%%%%WJW
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


% the result
phase = x;
