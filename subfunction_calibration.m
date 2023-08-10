function y=subfunction_calibration(pixel_c,wavelength_c,pixellegth)
a1=polyfit(pixel_c,wavelength_c,3); %���ployfit�����ء�������
pixel_ccd=linspace(1,pixellegth,pixellegth); %����CCD��������
wavelength3=polyval(a1,pixel_ccd);   %ȡ��ÿ�����ض�Ӧ�Ĳ���
wavenumber=2*pi./wavelength3; %���Ȳ�����Ӧ�ķǾ��Ȳ���
xk_v=linspace(wavenumber(1),wavenumber(pixellegth),pixellegth);  %���Ȳ���
wavelength_uv=2*pi./xk_v;   %���Ȳ�����Ӧ�ķǾ��Ȳ���
a2=polyfit(wavelength_c,pixel_c,3);  %���ployfit�����������أ�
y=polyval(a2,wavelength_uv);    %ȡ�þ��Ȳ�����Ӧ�����������Ǿ��ȣ�
end