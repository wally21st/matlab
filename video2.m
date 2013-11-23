
close all
clear
profile on;tic;
f_imread_path = 'E:\test\pic\';
f_imread_filename = 'Video1_Jpg';


f_output_phase_path = 'E:\test\phase\';
f_output_phase_filename = 'Phase_Video1_';


% f_output_avi_path = 'F:\Maltlabwork\test\avi\';
% f_output_avi_filename = 'Phase_Video1.avi';
% 
% aviobj =  VideoWriter([f_output_avi_path,f_output_avi_filename]);       %定义一个avi文件 
% aviobj.FrameRate = 6;
% open(aviobj);
point = 1;                %为使得位相范围一致，先设置一初始值
N=512;
figure;
%set(gcf,'visible','on');
tukey = tukeywin2D(N,0.2);
for t = [100,70:95]        %先运行一幅空全息图片，220即第220副图的意思，再从连续拍摄的图片中选取从第1副到第3副。
    % ---------------------------------------------------------------------
    % 功能：读入全息图像
    s = strcat(f_imread_filename,num2str(t));
    pname = [f_imread_path,s,'.jpg'];                   %在[]中对每个字符使用单引号括起来，则相当于将其连接起来
    Picture = double( rgb2gray( imread(pname) ) );
    %picture = double( Picture(:,:,1) );
    hCCD = Picture(33:544,106:617);          %从原图中选取512*512的区域。根据图像选取，不同图像成像位置不同，应重新选取。
    %N = length(hCCD);                  % 全息图像的大小，N*N pixels
    hCCD = hCCD.*tukey;     %调取tukeywin函数，消除直边衍射效应
    clear s pname picture Picture;
    
    %----------------------------------------------------------------------
% 全息图滤波处理(FFT)
uh = hCCD;
uhFFT = fftshift(fft2(uh));               % 移频至中心的傅里叶变换信息          
uhAmp = abs(uhFFT);

% 自动生成滤波器
z = log(uhAmp);
width = 10; 


z = (z-min(min(z)))./(max(max(z))-min(min(z)));
z(N/2+1-width:N/2+1+width,N/2+1-width:N/2+1+width) = 0;
[zz,zr]=max(z);%z为矩阵，zz为每列的最大值，为行矢量，zr为每列最大值所对应的行数
[~,zc] = max(zz); %zc为行矢量中的最大值所对应的列数
center = [zr(zc),zc]; 
while (zc < (N/2+1) || zr(zc) > (N/2+1)) 
    z(center(1),center(2)) = 0;
    [zz,zr]=max(z);
    [~,zc] = max(zz);
    center = [zr(zc),zc]; 
end
clear zz zzz zr zc width


% 定义+1级频谱分布范围，被测物体不同，宽度将不同
centerRow = center(1);
centerColumn = center(2);
width_row = 8;
width_column = 10;
LL = zeros(N);
LL(centerRow-width_row:centerRow+width_row,centerColumn-width_column:centerColumn+width_column) = 1;

z = z.*LL;         %仅将给定范围的一级频谱取出来，频谱面的其他部分置为零

z2 = LunKuo(z,0.7);
u = filter2(fspecial('average',7),z2)/255;            %经过平滑使得所选滤波区域内的个别零值点得到平滑，灰度值变大，
                                                                   %有利于通过再次判断轮廓选取+1级频谱
u = u/(max(max(u)));
u2 = LunKuo(u,0.4);

autofilter = u2;                                        %经过以上处理autofilter中1值得地方就是+1级频谱的范围        

clear z z2 u u2;

% 对全息图滤波获得+1级频谱信息
uhFFT_fit = uhFFT.*autofilter;

width = 30;
z = zeros(N);
z(N/2+1-width:N/2+1+width,N/2+1-width:N/2+1+width) = uhFFT_fit(centerRow-width:centerRow+width,centerColumn-width:centerColumn+width);
uhFFT_fit = z;
clear z1 z2 z3 z4 z;


%--------------------------------------------------------------------------
% 利用角谱传播理论进行再现

hd = 8.33e-6;                      % CCD面上的分辨率(m)
wl = 632.8e-9;                     % 单色光波长(m)
ud = 1/(N*hd);                     % 频谱面上的抽样间隔(m)

%d = 0.205;
d=-0.05;
% 传播至像平面上再现像的频谱分布
[nn,mm] = meshgrid(-N/2:1:N/2-1,-N/2:1:N/2-1);  % 离散化meshgrid(n,m),由n确定列数，m确定行数
filter = exp( 1i*2*pi*d/wl * sqrt(1 - wl^2*(nn*ud).^2 - wl^2*(mm*ud).^2) );
uSpectrum = uhFFT_fit.* filter;
clear nn mm;

uFFTangle = ifft2(fftshift(uSpectrum));
%Ampangle = abs(uFFTangle);
%      figure(1);imshow(angle(uFFTangle));
phaseangle = unwrapZW(angle(uFFTangle));
%      figure(2);imshow(phaseangle);
       disp(t);
    if point == 1
        shiftphase = phaseangle;
        point = 0;
    end
    
    if point == 0;
        phaseangle = phaseangle - shiftphase;
    end

    
%     s2 = strcat('Phase_Video1_',num2str(t));
%     pname2 = [f_output_phase_path,s2,'.jpg'];
%     imwrite( mat2gray(phaseangle),pname2,'jpg');
    p = -1*phaseangle;
    surf(p),shading interp,axis off,pause(0.01);
    %surfl(p),colormap(bone),shading interp,view(-120,60),axis off
    clear p
    %saveas(gcf,pname2);       %Save figure or model using specified format,但此处将imwrite( mat2gray(phase),pname2,'jpg');存储的图片覆盖
                              %saveas(h,'filename.ext')或saveas(h,'filename','format')
    
    
%     frame=getframe(gcf); %获得一帧图像 gcf：Get current figure handle
%     writeVideo(aviobj,frame);%并加到电影剪辑文件中
    
    clear s1 s2 s3 pname1 pname2 
    
end

% close(aviobj);%关闭文件，结束数值仿真模拟过程。
toc;profile viewer;
close all
clear

    