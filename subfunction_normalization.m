%归一化子函数
function y=subfunction_normalization(x)
n=size(x);
Bscan=n(1,1);
parfor i=1:1:Bscan
      x_avage(i,:)=x(i,:)./max(x(i,:));
end
y=x_avage;
end
