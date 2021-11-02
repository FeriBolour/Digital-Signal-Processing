% demonstration of DFT
clear;
close all;

x=[1 2 3 4 5] % sequence in time domain (signal)
n=0:length(x)-1;
X=fft(x,128)  %sequence in frequency domain (spectrum)
k=0:length(X)-1;

figure(1)
subplot(311)
stem(n,x)
xlabel('n')
ylabel('x[n]')

subplot(312)
stem(k,abs(X))
xlabel('k')
ylabel('|X(k)|')

subplot(313)
stem(k,phase(X))
xlabel('k')
ylabel('arg(X(k))')