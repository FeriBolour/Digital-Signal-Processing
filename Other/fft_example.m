% Evaluation of DFT properties
% Tanja Karp, 11-15-2013

clear; close all

N=64;
w0=3*pi/60

n=0:N-1;
x=cos(w0*n);

figure(1)
subplot(211)
stem(n,x);
xlabel('n')
ylabel('x[n]')

% subplot(212)
% stem(0:2*N-1,[x, x]);
% xlabel('n')
% ylabel('periodic x[n]')

X=fft(x,32);
k=0:length(X)-1;

figure(2)
subplot(211)
stem(k,abs(X))
ylabel('|X[k]|')
xlabel('k')

% subplot(212)
% stem(k,phase(X))
% ylabel('phase(X[k])')
% xlabel('k')

figure(3)
subplot(211)
stem(k-N/2,fftshift(abs(X)))
ylabel('|X[k]|')
xlabel('k')