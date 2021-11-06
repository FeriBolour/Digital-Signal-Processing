% Two stage decimation filter design
% Audio signal originally sampled at fs1 to be converted to fs2
%
clear; close all

fs1 = 48000;    % original high sampling frequency
fs2 = 8000;     % reduced low sampling frequency
M = fs1/fs2;    % sampling rate reduction by M

x = randn(1,100000); % input signal

% Kaiser FIR Filter
Fs = 48000;  % Sampling Frequency

Fpass = 3800;            % Passband Frequency
Fstop = 4200;            % Stopband Frequency
Dpass = 0.057501127785;  % Passband Ripple
Dstop = 0.001;           % Stopband Attenuation
flag  = 'scale';         % Sampling Flag

% Calculate the order from the parameters using KAISERORD.
[N,Wn,BETA,TYPE] = kaiserord([Fpass Fstop]/(Fs/2), [1 0], [Dstop Dpass]);

% Calculate the coefficients using the FIR1 function.
h  = fir1(N, Wn, TYPE, kaiser(N+1, BETA), flag);

% graph filter impulse response
figure(1)
stem(0:length(h)-1,h)
xlabel('n')
ylabel('h[n]')
title('filter impulse response')

% graph filter frequency response
figure(2)
freqz(h,1,[],fs1)


%% inefficient decimator implementation
y = conv(x,h);
ydown1 = y(1:M:end);


% draw output spectrum

Y=fft(y);
f=(0:length(Y)-1)/length(Y)*Fs;

Ydown1=fft(ydown1);
f1=(0:length(Ydown1)-1)/length(Ydown1)*Fs/6;

figure
subplot(211)
plot(f,abs(Y))
xlim([0,48000])

subplot(212)
plot(f1,abs(Ydown1))
xlim([0,8000])

%% efficient decimator implementation

ydown2 = conv(h(1:M:end),x(1:M:end));

for ii = 2:M
    ypoly = conv(h(ii:M:end),[0 x(M+2-ii:M:end)]);
    
    if length(ypoly)>length(ydown2)
        ydown2(end+1:length(ypoly)) = 0;
    elseif length(ypoly)<length(ydown2)
        ypoly(end+1:length(ydown2)) = 0;
    end
    ydown2 = ydown2 + ypoly;
   
end

figure(3)
plot(ydown1,'r')
hold on
plot(ydown2,'b')
hold off


%% two-step decimation

% All frequency values are in Hz.
% step 1: decimation by 2
M1=2;

Fs = 48000;  % Sampling Frequency

Fpass = 3800;            % Passband Frequency
Fstop = 20000;           % Stopband Frequency
Dpass = 0.057501127785;  % Passband Ripple
Dstop = 0.001;           % Stopband Attenuation
flag  = 'scale';         % Sampling Flag

% Calculate the order from the parameters using KAISERORD.
[N,Wn,BETA,TYPE] = kaiserord([Fpass Fstop]/(Fs/2), [1 0], [Dstop Dpass]);

% Calculate the coefficients using the FIR1 function.
h1  = fir1(N, Wn, TYPE, kaiser(N+1, BETA), flag);

% inefficient decimator implementation
y1 = conv(x,h1);
ydown12 = y1(1:M1:end);


% step 2: decimation by 3
M2=3;

% All frequency values are in Hz.
Fs = 24000;  % Sampling Frequency

Fpass = 3800;            % Passband Frequency
Fstop = 4200;            % Stopband Frequency
Dpass = 0.057501127785;  % Passband Ripple
Dstop = 0.001;           % Stopband Attenuation
flag  = 'scale';         % Sampling Flag

% Calculate the order from the parameters using KAISERORD.
[N,Wn,BETA,TYPE] = kaiserord([Fpass Fstop]/(Fs/2), [1 0], [Dstop Dpass]);

% Calculate the coefficients using the FIR1 function.
h2  = fir1(N, Wn, TYPE, kaiser(N+1, BETA), flag);

% inefficient decimator implementation
y1 = conv(ydown12,h2);
ydown22 = ydown12(1:M2:end);

%% equivalent filter

h2up(1:M1:M1*length(h2))=h2;

hequiv=conv(h1,h2up);

figure
freqz(hequiv,1,[],fs1)