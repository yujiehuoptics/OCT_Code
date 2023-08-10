function y=subfunction_calibration(pixel_c,wavelength_c,pixellegth)
a1=polyfit(pixel_c,wavelength_c,3); %拟合ployfit（像素—波长）
pixel_ccd=linspace(1,pixellegth,pixellegth); %生成CCD像素数据
wavelength3=polyval(a1,pixel_ccd);   %取得每个像素对应的波长
wavenumber=2*pi./wavelength3; %均匀波长对应的非均匀波数
xk_v=linspace(wavenumber(1),wavenumber(pixellegth),pixellegth);  %均匀波数
wavelength_uv=2*pi./xk_v;   %均匀波数对应的非均匀波长
a2=polyfit(wavelength_c,pixel_c,3);  %拟合ployfit（波长—像素）
y=polyval(a2,wavelength_uv);    %取得均匀波数对应的像素数（非均匀）
end