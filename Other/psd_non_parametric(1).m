
% estimating power spectral density using non-parametric methods
% Tanja Karp
clear; close all;

%% Initialize Variables
N=1000;             % length of sequence

%% Pick one of the following sequences
% real valued noise sequences
x11=randn(N,1);             % Gaussian, zero mean, variance of 1
x12=(-1).^randi([0,1],N);   % -1, 1 each of probability 0.5
x13=4*rand(N,1)-2;          % uniformly distributed [-2 2)

%real valued sinusoidal sequences
A=rand(1); w0=2*pi*rand(1); phi=2*pi*rand(1);
x21=A*cos(w0*(0:N-1)+phi).'; % cosine of random amplitude, frequency and phase shift
x22=cos(pi/16*(0:N-1)+phi).'; % cosine of random phase shift w0=pi/16
x23=cos(1.1*pi/16*(0:N-1)+phi).'; % cosine of random phase shift w0=2*pi/16

%complex valued sinusoidal sequences
x31=exp(1i*pi/16*(0:N-1)+1i*phi).'; %complex exponential of frequency w0=pi/16
x32=exp(1i*1.3*pi/16*(0:N-1)+1i*phi).'; %complex exponential of frequency w0=1.3*pi/16

x=x11+x22/2;    %choose which of the above random sequences you want to use

%graph sequence in time domain
figure
plot(x)
xlabel('n')
ylabel('x[n]')
title('random process X[n]')

%% Periodogram method

% calculate N points in frequency domain
SpN=(1/N)*abs(fft(x)).^2;
w=((0:N-1)/N*2*pi);  % frequency range for periodogram(row vector)

figure
plot(w,SpN)
xlim([0,2*pi])
xlabel('normalized frequency')
ylabel('S_x')
title('PSD estimate, Periodogram')

%% Correlogram method: Calculate autocorrelation function and then FFT of it

rx_biased=xcorr(x,x,[],'biased');
rx_unbiased=xcorr(x,x,[],'unbiased');

figure
stem(-(N-1):(N-1),rx_unbiased)
hold on
stem(-(N-1):(N-1),rx_biased)
hold off
xlabel('\lambda')
ylabel('r_x(\lambda)')
title('autocorrelation sequence, shifted')
legend('unbiased estimate','biased estimate')

% create autocorrelation vector of length 2*N-1 with lambda=0 in first value
rx_biased=ifftshift(rx_biased);
rx_unbiased=ifftshift(rx_unbiased);

figure
stem(0:2*(N-1),rx_unbiased)
hold on
stem(0:2*(N-1),rx_biased)
hold off
xlabel('\lambda')
ylabel('r_x(\lambda)')
title('autocorrelation sequence, shifted')
legend('unbiased estimate','biased estimate')


%calculate PSD
Sx_unbiased=fft(rx_unbiased);
Sx_biased=fft(rx_biased);


w=((0:length(Sx_unbiased)-1)/length(Sx_unbiased)*2*pi);  % frequency range

figure
plot(w,Sx_unbiased)
hold on
plot(w,Sx_biased)
hold off
xlim([0,2*pi])
grid
xlabel('normalized frequency')
ylabel('S_x')
title('PSD estimate, Correlogram')
legend('unbiased','biased')

%% Blackman-Tukey Method: calculate autocorrelation up to index lambda_max, 
% apply window of size 2*lambda_max+1, then zero-pad and FFT

lambda_max=10;
Nfft=1024;
my_window=bartlett(2*lambda_max+1);
my_window=rectwin(2*lambda_max+1);

rx_biased=xcorr(x,x,lambda_max,'biased');

figure
stem(-lambda_max:lambda_max,rx_biased)

xlabel('\lambda')
ylabel('r_x(\lambda)')
title('autocorrelation sequence')
legend('unbiased estimate up to lag \lambda_{max}')

% apply window to autocorrelation function
rx_win=my_window.*rx_biased;

%create autocorrelation function of length Nfft with lambda=0 first

rBT_Nfft(1:lambda_max+1)=rx_win(lambda_max+1:2*lambda_max+1);
rBT_Nfft(Nfft-lambda_max+1:Nfft)=rx_win(1:lambda_max);

%PSD calculation via fft
Sx_BT=fft(rBT_Nfft,Nfft);

w=((0:length(Sx_BT)-1)/length(Sx_BT)*2*pi);  % frequency range

figure
plot(w,Sx_BT)
xlim([0,2*pi])
grid
xlabel('normalized frequency')
ylabel('S_x')
title('PSD estimate, Blackman-Tukey Method')

%% Bartlett method (no window, no overlap)
Nblock=100;     % block length

xblock=zeros(Nblock,ceil(N/Nblock));
xblock(1:N)=x;
Sx_B=1/ceil(N/Nblock)*sum((1/Nblock)*abs(fft(xblock)).^2,2);

w=((0:length(Sx_B)-1)/length(Sx_B)*2*pi);  % frequency range

figure
plot(w,Sx_B)
xlim([0,2*pi])
grid
xlabel('normalized frequency')
ylabel('S_x')
title('PSD estimate, Bartlett Method')

%% Welch method (window and overlapping blocks)
Nblock=100;     % block length (samples)
Nstep=70;       % overlap (samples)

my_window=rectwin(Nblock).';

ii=0;
Sx_W(1:Nblock)=0;

while ii*Nstep+Nblock<=N
    xblock=x(ii*Nstep+1:ii*Nstep+Nblock).*my_window;
    Sxblock=1/Nblock*abs(fft(xblock)).^2;
    Sx_W=Sx_W+Sxblock;
    ii=ii+1;
end
Sx_W=Sx_W/ii/mean(my_window.^2);
    
figure
plot(w,Sx_W)
xlim([0,2*pi])
grid
xlabel('normalized frequency')
ylabel('S_x')
title('PSD estimate, Welch Method')    

