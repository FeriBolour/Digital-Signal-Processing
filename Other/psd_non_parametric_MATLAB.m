% estimating power spectral density using MATLAB functions for
% non-parametric methods
% Tanja Karp
clear; close all;

%% Initialize Variables
N=10000;             % length of sequence
Nfft=10000;          % size of fft, needs to be larger than lambda_max!
Nblock=512;         % blocksize for Bartlett/Welch method, needs to be less than Nfft!
Noverlap=Nblock/2;  % overlap of blocks for Welch method

%% Pick one of the following sequences
% real valued noise sequences
x11=randn(N,1);             % Gaussian, zero mean, variance of 1
x12=(-1).^randi([0,1],N);   % -1, 1 each of probability 0.5
x13=4*rand(N,1)-2;          % uniformly distributed [-2 2)

%real valued sinusoidal sequences
A=rand(1); w0=2*pi*rand(1); phi=2*pi*rand(1);
x21=A*cos(w0*(0:N-1)+phi).'; % cosine of random amplitude, frequency and phase shift
x22=cos(pi/16*(0:N-1)+phi).'; % cosine of random phase shift w0=pi/16
x23=cos(1.3*pi/16*(0:N-1)+phi).'; % cosine of random phase shift w0=1.3*pi/16

%complex valued sinusoidal sequences
x31=exp(1i*pi/16*(0:N-1)+1i*phi).'; %complex exponential of frequency w0=pi/16
x32=exp(1i*1.3*pi/16*(0:N-1)+1i*phi).'; %complex exponential of frequency w0=1.3*pi/16

x=x11+x22;    %choose which of the above random sequences you want to use
%graph sequence in time domain
figure
plot(x)
xlabel('n')
ylabel('x[n]')
title('random process X[n]')


%% Periodogram method (basically same results as biased correlogram)
[Sp,w]=periodogram(x,[],Nfft,'twosided','psd');

%% Bartlett method
[Sb,w]=pwelch(x,rectwin(Nblock),0,Nfft,'twosided','psd');

%% Welch method
[Sw_rectwin,w]=pwelch(x,rectwin(Nblock),Noverlap,Nfft,'twosided','psd');
[Sw_triang,w]=pwelch(x,triang(Nblock),Noverlap,Nfft,'twosided','psd');
[Sw_hamming,w]=pwelch(x,hamming(Nblock),Noverlap,Nfft,'twosided','psd');
[Sw_cheb60,w]=pwelch(x,chebwin(Nblock,60),Noverlap,Nfft,'twosided','psd');
[Sw_kaiser05,w]=pwelch(x,kaiser(Nblock,0.5),Noverlap,Nfft,'twosided','psd');


%% Graph psd estimates (linear and dB)

figure
subplot(211)
plot(w,[Sp,Sb])
axis([0 2*pi,-inf,inf])
title('PSD, linear')
legend('periodogram','Bartlett', 'location','North')
subplot(212)
plot(w,[Sw_rectwin,Sw_triang,Sw_hamming,Sw_cheb60,Sw_kaiser05])
axis([0 2*pi,-inf,inf])
title('Welch method, 50% overlap')
legend('rectangular','triangular','hamming','chepwin','kaiser', 'location','North')

figure
subplot(211)
plot(w,10*log10([Sp,Sb]))
axis([0 2*pi,-inf,inf])
title('PSD, dB')
legend('periodogram','Bartlett','location','North')
subplot(212)
plot(w,10*log10([Sw_rectwin,Sw_triang,Sw_hamming,Sw_cheb60,Sw_kaiser05]))
axis([0 2*pi,-inf,inf])
title('Welch method, 50% overlap')
legend('rectangular','triangular','hamming','chepwin','kaiser','location','North')