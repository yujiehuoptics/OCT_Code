%�����궨ǰȷ���궨��Դ���ݵĳ���
clear all;
clc;

k1='E:\oct\hyj oct ����\20160428\day=0428 time=1434 DATA.bmp'; %ͼ���ַ
k2='E:\oct\hyj oct ����\20160428\day=0428 time=1444 DATA.bmp'; %�궨��Դ��ַ

fprintf('Ԥ������\n');
aa=subfunction_preprocessing(k1); 
bb=subfunction_preprocessing(k2); 

figure();
plot(aa(1,:));
hold on
plot(2*bb(177,:));