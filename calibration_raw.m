%波长标定前确定标定光源数据的程序
clear all;
clc;

k1='E:\oct\hyj oct 数据\20160428\day=0428 time=1434 DATA.bmp'; %图像地址
k2='E:\oct\hyj oct 数据\20160428\day=0428 time=1444 DATA.bmp'; %标定光源地址

fprintf('预处理中\n');
aa=subfunction_preprocessing(k1); 
bb=subfunction_preprocessing(k2); 

figure();
plot(aa(1,:));
hold on
plot(2*bb(177,:));