y=[502 513 620 722 747 771 1066 1444];
x=[810.4364 811.2899 819.0054 826.3240 828.1050 829.8107 850.8870 877.6748];
a=polyfit(x,y,3);
x1 = linspace(min(x(:)), max(x(:)));
y1 = polyval(a, x1);
figure; hold on;
plot(x, y, 'r^', x1, y1, 'k:');
tit = char( vpa(poly2sym(a), 5) );
title(tit);
y0 = polyval(a, x);
err = abs(y - y0);
stem(x, err);


% x=1:1:1600;
% x2=x.*x;
% x3=x.*x2;
% wavelength3=a(4)+a(1)*x3+a(2)*x2+a(3)*x;
% figure();
% plot(wavelength3);

x=linspace(774.4508,888.97118,1600);
x2=x.*x;
x3=x.*x2;
pxiel=a(4)+a(1)*x3+a(2)*x2+a(3)*x;
% figure();
% plot(x,pxiel);

