% This example performs the calculation of the DTFT for several finite length sequences
%
% Tanja Karp, 10-07-2018
clear, close all;

n=-20:1:20;		% discrete time index
omega=-4*pi:pi/10000:4*pi;

%%
% unit sample sequence x1[n]=delta(n)
x1=zeros(1,41);
x1(21)=1;

X1=0;
for kk=1:length(n)
    X1=X1+x1(kk)*exp(-1i*n(kk)*omega);
end

figure
subplot(311)
stem(n,x1)
xlabel('n')
ylabel('x_1[n]')
title('unit sample sequence')

subplot(312)
plot(omega,abs(X1))
xlabel('\omega')
ylabel('|X_1(e^{j\omega})|')
axis([-2*pi 2*pi, 0 1.1])

subplot(313)
plot(omega,angle(X1))
xlabel('\omega')
ylabel('\angle X_1(e^{j\omega})')
axis([-2*pi 2*pi, -pi pi])

%%
% rectangular pulse x2[n]=u[n+10]-u[n-11]

x2=zeros(1,41);
x2(11:31)=1;

X2=0;
for kk=1:length(n)
    X2=X2+x2(kk)*exp(-1i*n(kk)*omega);
end

figure
subplot(311)
stem(n,x2)
xlabel('n')
ylabel('x_2[n]')
title('rectangular sequence')

subplot(312)
plot(omega,abs(X2))
xlabel('\omega')
ylabel('|X_2(e^{j\omega})|')
axis([-2*pi 2*pi, 0 inf])

subplot(313)
plot(omega,angle(X2))
xlabel('\omega')
ylabel('\angle X_2(e^{j\omega})')
axis([-2*pi 2*pi, -inf inf])

%%
% rectangular pulse x3[n]=u[n+5]-u[n-6]

x3=zeros(1,41);
x3(16:26)=1;

X3=0;
for kk=1:length(n)
    X3=X3+x3(kk)*exp(-1i*n(kk)*omega);
end

figure
subplot(311)
stem(n,x3)
xlabel('n')
ylabel('x_3[n]')
title('rectangular sequence')

subplot(312)
plot(omega,abs(X3))
xlabel('\omega')
ylabel('|X_3(e^{j\omega})|')
%axis([-2*pi 2*pi, 0 inf])

subplot(313)
plot(omega,angle(X3))
xlabel('\omega')
ylabel('\angle X_3(e^{j\omega})')
axis([-2*pi 2*pi, -inf inf])

%%
% finite length ramp x4[n]=n(u[n]-u[n-11]

x4=zeros(1,41);
x4(21:31)=0:10;

X4=0;
for kk=1:length(n)
    X4=X4+x4(kk)*exp(-1i*n(kk)*omega);
end

figure
subplot(311)
stem(n,x4)
xlabel('n')
ylabel('x_4[n]')
title('finite length ramp sequence')

subplot(312)
plot(omega,abs(X4))
xlabel('\omega')
ylabel('|X_4(e^{j\omega})|')
axis([-2*pi 2*pi, 0 inf])

subplot(313)
plot(omega,angle(X4))
xlabel('\omega')
ylabel('\angle X_4(e^{j\omega})')
axis([-2*pi 2*pi, -inf inf])

%%
% finite length cosine sequence
Omega_0=0.25*pi;  
phi=0;
x5=cos(Omega_0*n+phi);

X5=0;
for kk=1:length(n)
    X5=X5+x5(kk)*exp(-1i*n(kk)*omega);
end

figure
subplot(311)
stem(n,x5)
xlabel('n')
ylabel('x_5[n]')
title('finite length ramp sequence')

subplot(312)
plot(omega,abs(X5))
xlabel('\omega')
ylabel('|X_5(e^{j\omega})|')
axis([-2*pi 2*pi, 0 inf])

subplot(313)
plot(omega,angle(X5))
xlabel('\omega')
ylabel('\angle X_4(e^{j\omega})')
axis([-2*pi 2*pi, -inf inf])

