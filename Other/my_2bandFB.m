clear;

% Halfband Filters 
r = 0.25
M = 2
N = 36

h0 = rcosdesign(r,N/M,M,'sqrt')/sqrt(M);

h1 = h0;
h1(2:M:end)=-h1(2:M:end);

g0=2*h0;
g1=2*h1;

%signal processing
x=randn(1,1000)

%filter and downsample
xLP=conv(x,h0);
xLPdown=xLP(1:2:end);

xHP = conv(x,h1);
xHPdown=xHP(1:2:end);

% upsample
xLPup=zeros(size(xLP));
xLPup(1:2:end)=xLPdown;

xHPup=zeros(size(xHP));
xHPup(1:2:end)=xHPdown;

%filtering
yLP=conv(xLPup,g0);
yHP=conv(xHPup,g1);

y=(yLP+yHP);

figure(3)
plot(x)
hold on
plot(y(N+1:end))
hold off



figure(1)
stem(0:N,h0)
hold on
stem(0:N,h1)
hold off
xlabel('n')
title('impulse response')
legend('lowpass','highpass')

[H0,w]=freqz(h0,1,'whole');
[H1,w]=freqz(h1,1,'whole');
[G0,w]=freqz(g0,1,'whole');
[G1,w]=freqz(g1,1,'whole');

figure(2)
plot(w,abs(H0),w,abs(H1),w,abs(H0.*G0+H1.*G1),w,abs(fftshift(H0).*G0+fftshift(H1).*G1))
%plot(w,abs(H0),w,abs(H1),w,abs(H0.*G0+H1.*G1),w,abs(H1.*G0+H0.*G1))
xlim([0,2*pi])
xlabel('\omega [rad]')
ylabel('magnitude frequency response')
legend('lowpass','highpass','abs(H0.*G0+H1.*G1)')

title('magnitude frequency response')