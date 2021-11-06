% Halfband Filters 
r = 0.25   % rolloff factor
M = 2   % number of bands
N = 36  % filter order

h0 = rcosdesign(r,N/M,M,'normal')/sqrt(2);

h1 = h0;
h1(2:M:end)=-h1(2:M:end);

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

figure(2)
plot(w,abs(H0),w,abs(H1),w,abs(H0+H1))
xlim([0,2*pi])
xlabel('\omega [rad]')
ylabel('magnitude frequency response')
legend('lowpass','highpass','sum')

title('magnitude frequency response')

% signal filtering
x=randn(1,1000)
xlp=conv(h0,x);
xhp=conv(h1,x)

y=xlp+xhp

figure(3)
subplot(211)
plot(x)
hold on
plot(y(19:end))
xlim([0 100])
hold off
subplot(212)
plot(xlp)
hold on
plot(xhp)
hold off

