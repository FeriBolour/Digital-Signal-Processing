% examples for graphing ECE4364/5364
% Tanja Karp, 9-9-2019

% let's define some variables first
tmin=0;     % start time [s]
tmax=3;    % stop time [s]

f0=1;     % frequency of sinusoid

fs=5;     % sampling frequency
%% first, let's draw the continuous time signal. There are two ways to do
% it: 

% using MATLAB's symbolic math capabilities one can actually draw the
% function (see below) 
syms t
fplot(@(t) cos(2*pi*f0*t),[tmin,tmax],'r')

% alternatively, one can approximate continuous time by using a very small
% step size and when MATLAB connects the points the graph appears as if it
% was continuous (feel free to try)
%
% tc=tmin:0.001:tmax;
% xc=cos(2*pi*f0*tc);
% plot(tc,xc)

%% now let's create the discrete-time sequence
td=tmin:1/fs:tmax;
xd=cos(2*pi*td);
hold on
stem(td,xd)


%%






% falias = f0-2*fs;
% %%  let's also draw the aliased signal
% fplot(@(t) cos(2*pi*falias*t),[tmin,tmax],'b')
% hold off
% 
% % finally, let's not forget to label axis and provide a legend
% xlabel('time [s]')
% ylabel('amplitude')
% legend('continuous signal xc(t)', 'discrete sequence xd(n/fs)', 'aliased signal xa(t)')
% title('continuous signal, sequence, and aliased signal')