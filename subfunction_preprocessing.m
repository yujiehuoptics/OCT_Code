%ͼ��Ԥ����
function y=subfunction_preprocessing(x)
aad=double(imread(x));
add=aad(:,:,1); 

add(1,:)=[];%ɾ����һ����������

n=size(add);
Bscan=n(1,1);
for i=1:1:Bscan
aa(i,:)=fliplr(add(i,:));
end
y=aa;
end