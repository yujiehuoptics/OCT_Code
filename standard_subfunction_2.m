%ʹ���Ӻ����༭�Ĵ������
clear all;
clc;

% k1='E:\oct\hyj oct ����\20160428\day=0428 time=1434 DATA.bmp'; %ͼ���ַ
k1='C:\Yujie Hu\BaiduSyncdisk\OCT\OCT_bjut\��׼�������20160428\��׼�������\D0527T1638 A.bmp';
k2='C:\Yujie Hu\BaiduSyncdisk\OCT\OCT_bjut\��׼�������20160428\��׼�������\D0527T1638 B.bmp';
k3='C:\Yujie Hu\BaiduSyncdisk\OCT\OCT_bjut\��׼�������20160428\��׼�������\D0527T1638 C.bmp';
% bdd=double(imread('E:\oct\hyj oct ����\20150611\image2.bmp'));
% bcbd=bdd(124,:,1);
% bcbd=fliplr(bcbd);
% plot(bcbd);

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Ԥ����preprocessing%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('Ԥ������\n');
aa=subfunction_preprocessing(k1); %Ԥ����
bb=subfunction_preprocessing(k2);
cc=subfunction_preprocessing(k3);

n=size(aa);
Bscan=n(1,1);
pixellegth=n(1,2);

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%��һ��normalization%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('��һ����\n');
aa_normalization=subfunction_normalization(aa); %��һ��
bb_normalization=subfunction_normalization(bb);
cc_normalization=subfunction_normalization(cc);

%%
%%%%%%%%%%%%%%%%%%%%%%%%���ֵ��zero padding��%%%%%%%%%%%%%%%%%%%%%%%
% fprintf('���ֵ��\n');
% aa2=subfunction_zeropadding(aa,1); %���ֵ
% bb2=subfunction_zeropadding(bb,1);
% cc2=subfunction_zeropadding(cc,1);
% bcbd2=subfunction_zeropadding(bcbd,2);
% plot(bcbd2);

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%�����궨 wavelength calibration%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('�����궨��\n');
pixellegth=1600; %1600ԭ���궨����1600
pixel=linspace(1,pixellegth,pixellegth);
% pixel_o=[438 502 513 620 722 747 771 1066 1444]; %�ɵĲ����궨
pixel_o=[461 478 691 898 922 1062]; %AR�����궨20160428
wavelength=[810.3693 811.5311 826.4522 840.8210 842.4648 852.1442]; %AR�����궨20160428
% pixel_o=[495 557 569 677 779 804 828 1122 1502]; %2015.12.10�궨
% pixel_padding1=[1313 1503 1539 1859 2164 2239 2312 3197 4331]; %4800
% %pixel_padding2=[1313 1503 1539 1859 2164 2239 2312 3197 4331]; %
% wavelength=[805.9503 810.4364 811.2899 819.0054 826.3240 828.1050 829.8107 850.8870 877.6748]; 
pixel_v=subfunction_calibration(pixel_o,wavelength,pixellegth);

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%k�ռ��ز��� k-sapce resample%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('k�ռ��ز�����\n');
parfor i=1:1:Bscan
ad_v(i,:)=interp1(pixel,aa(i,:),pixel_v,'spline'); 
bd_v(i,:)=interp1(pixel,bb(i,:),pixel_v,'spline'); 
cd_v(i,:)=interp1(pixel,cc(i,:),pixel_v,'spline');
end

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%��ƽ������  avage the spectrum %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('��ƽ��������\n');
aa_avage=subfunction_avagespectra(ad_v); %��ƽ������
bb_avage=subfunction_avagespectra(bb_normalization);
cc_avage=subfunction_avagespectra(cc_normalization);
total_avage=(aa_avage+bb_avage+cc_avage)/3; %��ƽ������

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%������ Hanning window%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% left=400;
% right=1600;
% Hann2=(hann(right-left))';
% aa_avage2(1:1200)=aa_avage(401:1600);
% ad_v2(:,1:1200)=ad_v(:,401:1600);

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%��λɫ����� Dispersion compenstation%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%��
disVal_o=-2000;
dispValThird_o=-30;
dispVal=disVal_o*(10^-8);
dispValThird=dispValThird_o*(10^-9);

Bscan=n(1,1);
pixellegth=n(1,2);
kLinear = -pixellegth/2+1:-pixellegth/2+pixellegth;   %-639:640

kAr = repmat(kLinear,Bscan,1); %��klinear����1*400��

kaxis = kAr-1;    %����kArԪ�ؼ�1
a = kaxis.*kaxis;   %����kaxis��� ��ƽ��
DispPhase = dispVal.* a;       % -1000**(10^-8)

a3 = kaxis.*a;     %���η�
DispPhaseThird = dispValThird.*a3;   %����Ϊ0���� 

 raa_avage=repmat(aa_avage,Bscan,1);
 img=ad_v-raa_avage; %ad_v-raa_avage
 img = hilbert(img);                              %1280*400 ���� ϣ�����ر任
    
 ph = angle(img) + DispPhase + DispPhaseThird;
 img = abs(img).*exp(1i.*ph);        
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%��ֵ�任 phase shifting%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tic
fprintf('��ֵ�任��\n');
parfor i=1:1:Bscan
fa(i,:)=aa(i,:)-2*bb(i,:)+cc(i,:)+(aa(i,:)-cc(i,:))*1i;
fsignal(i,:)=abs(ifftshift(ifft2(fa(i,:))));     %ֱ�Ӹ���Ҷ�任
 %�ز�������Ҷ�任

% fa_v(i,:)=ad_v(i,:)-2*bd_v(i,:)+cd_v(i,:)+(ad_v(i,:)-cd_v(i,:))*1i;
fsignal_v(i,:)=abs(ifftshift(ifft2(img(i,:))));
 
% ad_v(i,:)= hilbert(ad_v(i,:));                              %1280*400 ���� ϣ�����ر任
% bd_vph(i,:)= angle(ad_v(i,:)) + DispPhase + DispPhaseThird;
% ad_vimg(i,:) = abs(ad_v(i,:)).*exp(1i.*bd_v(i,:));  

% bd_v = hilbert(bd_v);                              %1280*400 ���� ϣ�����ر任
% ad_vph = angle(bd_v) + DispPhase + DispPhaseThird;
% ad_vimg = abs(bd_v).*exp(1i.*bd_v);  
% 
% cd_v = hilbert(cd_v);                              %1280*400 ���� ϣ�����ر任
% cd_vph = angle(cd_v) + DispPhase + DispPhaseThird;
% cd_vimg = abs(cd_v).*exp(1i.*cd_v);  
% ad1(i,:)=ad_v(i,:)-aa_avage;
% ad2(i,:)=(ad_v(i,:)-aa_avage).*Hann2;
% fsignal_dc1(i,:)=abs(ifftshift(ifft2((ad_v2(i,:)-aa_avage2))));

% % fsignal_dc(i,:)=abs(ifftshift(ifft2((ad_v(i,:)-aa_avage))));
% fsignal_img(i,:)=abs(ifftshift(fft(img(i,:))));
% fsignal_img_nosub(i,:)=ifftshift(abs(fft(ad_v(i,:))));
% fsignal_img_nok_nosub(i,:)=ifftshift(abs(fft(aa_normalization(i,:))));

% fa_v(i,:)=ad_vimg(i,:)-2*bd_vimg(i,:)+cd_vimg(i,:)+(ad_vimg(i,:)-cd_vimg(i,:))*1i;
% fsignal_v(i,:)=abs(ifftshift(ifft2(fa_v(i,:))));
end
toc
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%���ֵ255����%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% fprintf('���ֵ255������\n');
% imagemax1=max(max(fsignal_v));
% imagemin1=min(min(fsignal_v));
% factor=imagemax1;
% fsignal_v2=fsignal_v/factor*4;
% imagemax2=max(max(fsignal_v));
% imagemin2=min(min(fsignal_v));

%%
% imwrite(255*fsignal_dc1,'E:\oct\hyj oct ����\20150528\D0528T1042NoHann.bmp');
% imwrite(255*fsignal_dc,'E:\oct\hyj oct ����\20150528\test.bmp');

str1='C:\Yujie Hu\BaiduSyncdisk\OCT\OCT_bjut\��׼�������20160428\��׼�������\';
str2=num2str(disVal_o);
str2_5='  ';
str3=num2str(dispValThird_o);
sc=[str1,str2];
sscc=[sc,str2_5];
ssc=[sscc,str3]
scc=[ssc,'.bmp'];
% fsignal_img = imfilter(fsignal_img,fspecial('gaussian',[2 2],3));
imwrite(fsignal,scc);

% 
% line=250;
% figure();
% plot(Hann2);
% figure();
% plot(fsignal_dc1(line,:));
% figure();
% plot(ad2(line,:),'r');

imshow(fsignal);
fprintf('�������\n');