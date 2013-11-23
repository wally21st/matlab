function z2 = LunKuo(deform,thresh);
% use the threshord to find the shape.

% deform: the deformed grating pattern 
% z1: the shape of the defromed grating pattern, the matrix using (NaN,1)
% z2: the shape of the defromed grating pattern, the matrix using (0,1)
% z3: the edge of the deform grating pattern.

% [Row,Column] = size(deform);
% z1 = ones(Row,Column);
% z2 = ones(Row,Column);
% for n = 1:Row
%     for m = 1:Column
%         if deform(n,m) < thresh
%             %z1(n,m) = NaN;
%             z2(n,m) = 0;
%         end
%     end
% end

z2 = double(deform > thresh);

%z3 = bwperim(z2);
%z1 À∆∫ı√ª”–”√