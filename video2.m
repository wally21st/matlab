
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
% aviobj =  VideoWriter([f_output_avi_path,f_output_avi_filename]);       %����һ��avi�ļ� 
% aviobj.FrameRate = 6;
% open(aviobj);
point = 1;                %Ϊʹ��λ�෶Χһ�£�������һ��ʼֵ
N=512;
figure;
%set(gcf,'visible','on');
tukey = tukeywin2D(N,0.2);
for t = [100,70:95]        %������һ����ȫϢͼƬ��220����220��ͼ����˼���ٴ����������ͼƬ��ѡȡ�ӵ�1������3����
    % ---------------------------------------------------------------------
    % ���ܣ�����ȫϢͼ��
    s = strcat(f_imread_filename,num2str(t));
    pname = [f_imread_path,s,'.jpg'];                   %��[]�ж�ÿ���ַ�ʹ�õ����������������൱�ڽ�����������
    Picture = double( rgb2gray( imread(pname) ) );
    %picture = double( Picture(:,:,1) );
    hCCD = Picture(33:544,106:617);          %��ԭͼ��ѡȡ512*512�����򡣸���ͼ��ѡȡ����ͬͼ�����λ�ò�ͬ��Ӧ����ѡȡ��
    %N = length(hCCD);                  % ȫϢͼ��Ĵ�С��N*N pixels
    hCCD = hCCD.*tukey;     %��ȡtukeywin����������ֱ������ЧӦ
    clear s pname picture Picture;
    
    %----------------------------------------------------------------------
% ȫϢͼ�˲�����(FFT)
uh = hCCD;
uhFFT = fftshift(fft2(uh));               % ��Ƶ�����ĵĸ���Ҷ�任��Ϣ          
uhAmp = abs(uhFFT);

% �Զ������˲���
z = log(uhAmp);
width = 10; 


z = (z-min(min(z)))./(max(max(z))-min(min(z)));
z(N/2+1-width:N/2+1+width,N/2+1-width:N/2+1+width) = 0;
[zz,zr]=max(z);%zΪ����zzΪÿ�е����ֵ��Ϊ��ʸ����zrΪÿ�����ֵ����Ӧ������
[~,zc] = max(zz); %zcΪ��ʸ���е����ֵ����Ӧ������
center = [zr(zc),zc]; 
while (zc < (N/2+1) || zr(zc) > (N/2+1)) 
    z(center(1),center(2)) = 0;
    [zz,zr]=max(z);
    [~,zc] = max(zz);
    center = [zr(zc),zc]; 
end
clear zz zzz zr zc width


% ����+1��Ƶ�׷ֲ���Χ���������岻ͬ����Ƚ���ͬ
centerRow = center(1);
centerColumn = center(2);
width_row = 8;
width_column = 10;
LL = zeros(N);
LL(centerRow-width_row:centerRow+width_row,centerColumn-width_column:centerColumn+width_column) = 1;

z = z.*LL;         %����������Χ��һ��Ƶ��ȡ������Ƶ���������������Ϊ��

z2 = LunKuo(z,0.7);
u = filter2(fspecial('average',7),z2)/255;            %����ƽ��ʹ����ѡ�˲������ڵĸ�����ֵ��õ�ƽ�����Ҷ�ֵ���
                                                                   %������ͨ���ٴ��ж�����ѡȡ+1��Ƶ��
u = u/(max(max(u)));
u2 = LunKuo(u,0.4);

autofilter = u2;                                        %�������ϴ���autofilter��1ֵ�õط�����+1��Ƶ�׵ķ�Χ        

clear z z2 u u2;

% ��ȫϢͼ�˲����+1��Ƶ����Ϣ
uhFFT_fit = uhFFT.*autofilter;

width = 30;
z = zeros(N);
z(N/2+1-width:N/2+1+width,N/2+1-width:N/2+1+width) = uhFFT_fit(centerRow-width:centerRow+width,centerColumn-width:centerColumn+width);
uhFFT_fit = z;
clear z1 z2 z3 z4 z;


%--------------------------------------------------------------------------
% ���ý��״������۽�������

hd = 8.33e-6;                      % CCD���ϵķֱ���(m)
wl = 632.8e-9;                     % ��ɫ�Ⲩ��(m)
ud = 1/(N*hd);                     % Ƶ�����ϵĳ������(m)

%d = 0.205;
d=-0.05;
% ��������ƽ�����������Ƶ�׷ֲ�
[nn,mm] = meshgrid(-N/2:1:N/2-1,-N/2:1:N/2-1);  % ��ɢ��meshgrid(n,m),��nȷ��������mȷ������
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
    %saveas(gcf,pname2);       %Save figure or model using specified format,���˴���imwrite( mat2gray(phase),pname2,'jpg');�洢��ͼƬ����
                              %saveas(h,'filename.ext')��saveas(h,'filename','format')
    
    
%     frame=getframe(gcf); %���һ֡ͼ�� gcf��Get current figure handle
%     writeVideo(aviobj,frame);%���ӵ���Ӱ�����ļ���
    
    clear s1 s2 s3 pname1 pname2 
    
end

% close(aviobj);%�ر��ļ���������ֵ����ģ����̡�
toc;profile viewer;
close all
clear

    