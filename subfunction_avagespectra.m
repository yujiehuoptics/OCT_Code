%平均光谱计算
function y=subfunction_avagespectra(x)
n=size(x);
CCD=n(1,2);
Bscan=n(1,1);
totol_ad=zeros(1,CCD);
parfor i=1:1:Bscan
ad=x(i,:);
totol_ad=ad+totol_ad;
end
y=totol_ad/Bscan;
end