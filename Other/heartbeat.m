clear; close all;
%% Data explaination
%% 
% * x-axis: time [sec]
% * y-axis: amplitude [mV]
% * Maximum amplitude range: -100 [mV ] ~ 100 [mV]
% * Resolution: 24 bits
% * Sampling rate: 128 [samples/sec]
% * 
% * - The amplitude can be different depending on the thickness or pigmentation 
% of the skin.
% * - Hence, the device has a wide range of dynamic range.
% * - Amplitude is relative blood flow.
% * - It does not have any further physiological meaning.
fs=128;

file_path_A = 'test_A.txt';
file_path_B = 'test_B.txt';

T_A = readtable(file_path_A);
T_B = readtable(file_path_B);

x_A = T_A.Amplitude; x_A(end)=[];
x_B = T_B.Amplitude;
t_A = (1:length(x_A))/fs;
t_B = (1:length(x_B))/fs;

%% Plotting Data 

figure(1)
subplot(211)
plot(t_A,x_A)
title('Blood Volume Pulse signal (Student A)')
xlim([0,100])
ylim([-100,100])
xlabel('t [sec]')
ylabel('Amplitude [mV]')

subplot(212)
plot(t_B, x_B)
title('Blood Volume Pulse signal (Student B)')
xlim([0,100])
ylim([-100,100])
xlabel('t [sec]')
ylabel('Amplitude [mV]')


%% Plotting Spectra 

X_A=abs(fft(x_A));
X_B=abs(fft(x_B));

f_A=(0:length(x_A)-1)/length(x_A)*fs;
f_B=(0:length(x_B)-1)/length(x_B)*fs;


figure(2)
subplot(211)
plot(f_A, X_A)
title('Blood Volume Pulse spectrum (Student A)')
xlabel('f [Hz]')
ylabel('magnitude')
xlim([0,fs])

subplot(212)
plot(f_B, X_B)
title('Blood Volume Pulse spectrum (Student B)')
xlabel('f [Hz]')
ylabel('magnitude')
xlim([0,fs])
