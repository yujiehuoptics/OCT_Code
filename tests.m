%使用子函数编辑的处理程序
clear all;
clc;
linenumber=314;%the selected line to be extracted

for i=1:1:40
name=i
str1='E:\oct\hyj oct 数据\20140104\2\';
str2=num2str(name);
str3='a.bmp';
sc=[str1,str2];
sscc=[sc,str3];%to read the whole folder for 40 images

preim=double(imread(sscc));
preimim=preim(:,:,1); %select only one colour

im(i,:)=preimim(linenumber,:);%to extract only one line in the new image
end
imshow(im,[]);
n=size(im);
Bscan=n(1,1);%to select the 1st number of size(im) to do all 40
for i=1:1:Bscan
img(i,:)=fliplr(im(i,:));%to invert the images
end

imshow(img,[]);




% k1='E:\oct\hyj oct 数据\20151210实验数据\day=1210 time=1634 a.bmp'; %图像地址
% k2='E:\oct\hyj oct 数据\20150527\2\D0527T1638 B.bmp';
% k3='E:\oct\hyj oct 数据\20150527\2\D0527T1638 C.bmp';
% bdd=double(imread('E:\oct\hyj oct 数据\20150611\image2.bmp'));
% bcbd=bdd(124,:,1);
% bcbd=fliplr(bcbd);
% plot(bcbd);

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%预处理%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% fprintf('预处理中\n');
% 
% img=subfunction_preprocessing(k1);
n=size(img);
Bscan=n(1,1);

for i=1:1:Bscan;
fsignal_img(i,:)=abs(ifftshift(fft(img(i,:))));%to do the fourier transform line by line
end
figure()
imshow(fsignal_img/800);