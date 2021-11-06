% this program shows how to use the impulse response of an LTI system and
% how to perform convolution if the impulse response is of finite length
% ECE 3304, Tanja Karp - 1-27-2014

clear; %close all
% create noisy sinusoid
n=0:100;
x=cos(pi/16*n);
noise=0.15*randn(size(n));
x_noisy=x+noise;

figure(1)
plot(n,x_noisy,'b',n,x,'c')
grid
xlabel('n')
legend('noisy signal','original sinusoid')


%% design moving average filter
% h[n]=1/N(delta(n)+delta(n-1)+ ... + delta(n-N+1))
N=16;
h=1/N*ones(1,N);
%h=[0.25 0.5 0.25]

% perform convolution
y=conv(h,x_noisy);

figure(2)
plot(n,x_noisy,'b',n,x,'c',n,y(1:length(n)),'r')
grid
xlabel('n')
legend('noisy signal','original sinusoid','filtered sequence')


%% filter analysis

figure(3)
stem(0:N-1,h)
xlabel('n')
ylabel('h[n]')

figure(4)
[H,w]=freqz(h,1,'whole')
subplot(211)
plot(w,abs(H))
subplot(212)
plot(w,phase(H))
