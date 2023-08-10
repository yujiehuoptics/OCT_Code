%图像预处理
function y=subfunction_preprocessing(x)
aad=double(imread(x));
add=aad(:,:,1); 

add(1,:)=[];%删除第一行无用数据

n=size(add);
Bscan=n(1,1);
for i=1:1:Bscan
aa(i,:)=fliplr(add(i,:));
end
y=aa;
end