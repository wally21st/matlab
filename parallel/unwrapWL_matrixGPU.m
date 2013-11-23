function y=unwrapWL_matrixGPU(x)
tic;
[row,column]=size(x);
x=gpuArray(x);%
x=single(x);%
prev = x;
zeroLogicalMatrix = logical(gpuArray.zeros(row,column));
indexLeft = zeroLogicalMatrix;
indexRight = zeroLogicalMatrix;
indexTop = zeroLogicalMatrix;
indexBottom = zeroLogicalMatrix;
for iteration=1:3000
  indexLeft(:,2:column)   = x(:,1:column-1) - x(:,2:column)   > 6; %左邻
  
  indexRight(:,1:column-1)  = x(:,2:column)   - x(:,1:column-1) > 6; %右邻
  
  indexTop(2:row,:)    = x(1:row-1,:)      - x(2:row,:)    > 6; %上邻
  
  indexBottom(1:row-1,:) = x(2:row,:)    - x(1:row-1,:)      > 6; %下邻
  
  index = indexLeft | indexRight | indexTop | indexBottom ;
  
  x = x + index*6.2832;
  
  if isequal(index,zeroLogicalMatrix)
      disp(['迭代次数为： ',num2str(iteration)]);
      break;
  end
  prev = x;
end
toc;

y=gather(x);
