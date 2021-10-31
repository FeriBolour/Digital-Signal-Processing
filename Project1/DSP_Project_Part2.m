%DSP Project 1 - Part 2
%Filter a Noisy Quail Call signal using a band stop filter
%and retrieve the time domain,spectrogram, and fft graphs of the original signal and
%the filtered signal
%Noisy Signal - Filtered Signal = Resulting Signal
%Farshad Bolouri
%Brennae Stinson
%Anindita Das


% clear 
% close all
[sig, fs] = audioread('bsf_subtract_noisy.wav'); %read in band stop filter to be subtracted
load('DSP_Project_2.mat')
new_sig = time_Domain-sig;%new_sig is qual call with noise subtracted
Fs= 24000;
F = 1000:10:3200;
window = Fs*0.04;
noverlap = round(0.8*window);
%audiowrite('newsig_1850_2150.wav',new_sig,Fs);

%% Time Domain Signal
figure('Name','Signals in the Time Domain');
subplot(3,1,1);
plot(time_Domain)
xlabel('n')
ylabel('x[n]')
title('Noisy Signal in the Time Domain')

subplot(3,1,2);
plot(sig)
xlabel('n')
ylabel('x[n]')
title('Filtered Signal in the Time Domain')

subplot(3,1,3);
plot(new_sig)
xlabel('n')
ylabel('x[n]')
title('Resulting Signal in the Time Domain')
% 
% % To play the sound
% pause(2)
% hold on
% Bar = xline(0,'Color','yellow','LineWidth',1.5);
% play(player);
% for i = 1:length(time_Domain)/2400
%      set(Bar,'Value',Bar.Value+2400);
%      pause(.1);
% end

%% FFT

% Log Scale Shifted
figure('Name','FFT of Signals');
fourier = log(1 + abs (fftshift(fft(time_Domain))));
subplot(3,1,1);
plot(fourier)
title('FFT of Noisy Quail Call');
ylabel('log(1 + |X(k)|)')
xlabel('k');

fourier = log(1 + abs (fftshift(fft(sig))));
subplot(3,1,2);
plot(fourier)
title('FFT of Filtered Quail Call');
ylabel('log(1 + |X(k)|)')
xlabel('k');

fourier = log(1 + abs (fftshift(fft(new_sig))));
subplot(3,1,3);
plot(fourier)
title('FFT of Resulting Quail Call');
ylabel('log(1 + |X(k)|)')
xlabel('k');

%% Spectrogram
figure('Name','Spectrogram of Signals');
image=spectrogram(time_Domain,window,noverlap,F,Fs);
subplot(3,1,1);
imagesc(abs(image))
title('Spectrogram of Noisy Signal');
ylabel('frequency (Hz)')
xlabel('time (s)')
set(gca,'YDir','normal')
yticks([0 50 100 150 200])
yticklabels({'1000', '1440', '1880', '2320', '2760', '3200'});
xticks([0 100 220 340 460 580 700 820 940 1060])
xticklabels({'0', '1','2','3','4','5','6','7','8','9','10'});

image=spectrogram(sig,window,noverlap,F,Fs);
subplot(3,1,2);
imagesc(abs(image))
title('Spectrogram of Filtered Signal');
ylabel('frequency (Hz)')
xlabel('time (s)')
set(gca,'YDir','normal')
yticks([0 50 100 150 200])
yticklabels({'1000', '1440', '1880', '2320', '2760', '3200'});
xticks([0 100 220 340 460 580 700 820 940 1060])
xticklabels({'0', '1','2','3','4','5','6','7','8','9','10'});

image=spectrogram(new_sig,window,noverlap,F,Fs);
subplot(3,1,3);
imagesc(abs(image))
title('Spectrogram of Resulting Signal');
ylabel('frequency (Hz)')
xlabel('time (s)')
set(gca,'YDir','normal')
yticks([0 50 100 150 200])
yticklabels({'1000', '1440', '1880', '2320', '2760', '3200'});
xticks([0 100 220 340 460 580 700 820 940 1060])
xticklabels({'0', '1','2','3','4','5','6','7','8','9','10'});


%% Filtering
% band_stop = filter(band_stop_1850_2150,time_Domain);
% audiowrite('bsf_subtract_noisy.wav',band_stop,Fs);
% Filter Designer file: 'subtraction_bandstop_1850_2150.fda'

%% Play Each Sound
%Noisy Signal
% player = audioplayer(time_Domain,Fs);
% pause(2)
% hold on
% Bar = xline(0,'Color','yellow','LineWidth',1.5);
% play(player);
% for i = 1:1250
%      set(Bar,'Value',Bar.Value+12);
%      pause(.1);
% end

% %Filtered Signal
% player = audioplayer(sig,Fs);
% pause(2)
% hold on
% Bar = xline(0,'Color','yellow','LineWidth',1.5);
% play(player);
% for i = 1:1250
%      set(Bar,'Value',Bar.Value+12);
%      pause(.1);
% end

%Resulting Signal
% player = audioplayer(new_sig,Fs);
% pause(2)
% hold on
% Bar = xline(0,'Color','yellow','LineWidth',1.5);
% play(player);
% for i = 1:1250
%      set(Bar,'Value',Bar.Value+12);
%      pause(.1);
% end





