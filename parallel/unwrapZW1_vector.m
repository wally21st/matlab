function phase = unwrapZW1_vector( x )
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

% the result
phase = x;