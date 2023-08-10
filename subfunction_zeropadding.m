%zero_padding
function y=subfunction_zeropadding(x,M)
n=size(x);
Bscan=n(1,1);
pixellegth=n(1,2);
paddinglength=M*pixellegth;
aa_zero=zeros(1,paddinglength);
for i=1:1:Bscan
aa2(i,:)=fftshift(fft2(x(i,:))); 
aa3(i,:)=[aa_zero(1,:),aa2(i,:),aa_zero(1,:)];
aa4(i,:)=abs((ifft2(aa3(i,:)))); 
end
y=aa4;
end