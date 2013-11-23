function II=tukeywin2D(N,r)

%   II=tukeywin2D(N,r) returns an N*N-point Tukey window. 

n = linspace(0,1,N);
m = linspace(0,1,N);
[nn,mm] = meshgrid(n,m);

per = r/2; 
tl = floor(per*(N-1))+1;
th = N-tl+1;

I1 = ones(N,N);
I21 = (1+cos(pi/per*(nn - per)))/2;
I22 = (1+cos(pi/per*(nn - 1 + per)))/2;
I31 = (1+cos(pi/per*(mm - per)))/2;
I32 = (1+cos(pi/per*(mm - 1 + per)))/2;
I41 = ((1+cos(pi/per*(nn - per)))/2) .* ((1+cos(pi/per*(mm - per)))/2);
I42 = ((1+cos(pi/per*(nn - 1 + per)))/2) .* ((1+cos(pi/per*(mm - per)))/2);
I43 = ((1+cos(pi/per*(nn - per)))/2) .* ((1+cos(pi/per*(mm - 1 + per)))/2);
I44 = ((1+cos(pi/per*(nn - 1 + per)))/2) .* ((1+cos(pi/per*(mm - 1 + per)))/2);

II = zeros(N,N);
II(tl+1:th-1,tl+1:th-1) = I1(tl+1:th-1,tl+1:th-1);
II(tl+1:th-1,1:tl) = I21(tl+1:th-1,1:tl);  
II(tl+1:th-1,th:N) = I22(tl+1:th-1,th:N);
II(1:tl,tl+1:th-1) = I31(1:tl,tl+1:th-1);  
II(th:N,tl+1:th-1) = I32(th:N,tl+1:th-1);
II(1:tl,1:tl) = I41(1:tl,1:tl);
II(1:tl,th:N) = I42(1:tl,th:N);
II(th:N,1:tl) = I43(th:N,1:tl);
II(th:N,th:N) = I44(th:N,th:N);

return;