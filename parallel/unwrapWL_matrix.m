function y=unwrapWL_matrix(x)
tic;
[row,column]=size(x);
prev = x;
indexLeft = zeros(row,column);
indexRight = zeros(row,column);
indexTop = zeros(row,column);
indexBottom = zeros(row,column);
for iteration=1:500
  indexLeft(:,2:column)   = x(:,1:column-1) - x(:,2:column)   > 3.1416; %����
  
  indexRight(:,1:column-1)  = x(:,2:column)   - x(:,1:column-1) > 3.1416; %����
  
  indexTop(2:row,:)    = x(1:row-1,:)      - x(2:row,:)    > 3.1416; %����
  
  indexBottom(1:row-1,:) = x(2:row,:)    - x(1:row-1,:)      > 3.1416; %����
  
  index = indexLeft | indexRight | indexTop | indexBottom ;
  
  x = x + index*6.2832;
  imshow(x,[]);pause();
  if prev == x
      disp(['��������Ϊ�� ',num2str(iteration)]);
      break;
  end
  prev = x;
end
toc;
y=x;
