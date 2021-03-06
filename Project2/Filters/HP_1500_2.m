function Hd = HP_1500_2
%HP_1500_2 Returns a discrete-time filter object.

% MATLAB Code
% Generated by MATLAB(R) 9.8 and Signal Processing Toolbox 8.4.
% Generated on: 26-Nov-2021 21:02:59

% FIR Window Highpass filter designed using the FIR1 function.

% All frequency values are in Hz.
Fs = 6000;  % Sampling Frequency

Fstop = 1450;              % Stopband Frequency
Fpass = 1550;              % Passband Frequency
Dstop = 0.00031622776602;  % Stopband Attenuation
Dpass = 0.057501127785;    % Passband Ripple
flag  = 'scale';           % Sampling Flag

% Calculate the order from the parameters using KAISERORD.
[N,Wn,BETA,TYPE] = kaiserord([Fstop Fpass]/(Fs/2), [0 1], [Dpass Dstop]);

% Calculate the coefficients using the FIR1 function.
b  = fir1(N, Wn, TYPE, kaiser(N+1, BETA), flag);
Hd = dfilt.dffir(b);

% [EOF]
