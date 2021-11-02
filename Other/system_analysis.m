% FIR impulse response (finite length sequence)
N=4
n=0:N-1;
h=ones(1,N)/N
figure(1)
stem(n,h)
xlabel('n')
ylabel('h[n]')
title('impulse response')
xlim([-2 5])
ylim([-0.5 1.5])


roots(h)
% zplane
figure(2)
zplane(h,1)

% frequency response
figure(3)
freqz(h,1,'whole')


%% IIR impulse response
N=100
n=0:N-1;
a=0.9
h=a.^n
figure(1)
stem(n,h)
xlabel('n')
ylabel('h[n]')
title('impulse response (truncated)')
xlim([-2 N+2])
ylim([-0.5 1.5])

B=1;
A=[1 -a];
% zplane
figure(2)
zplane(B,A)

% frequency response
figure(3)
freqz(B,A,'whole')