h=0:0.1:4;
hh=sin(3*h-pi)./(3*h-pi) +1;
figure;
plot(h,hh);
title('Original Function')
xlabel('x')
ylabel('f(x)') 
