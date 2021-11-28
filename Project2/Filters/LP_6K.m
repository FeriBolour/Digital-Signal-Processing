function Hd = LP_6K
%LP_6K Returns a discrete-time filter object.

% MATLAB Code
% Generated by MATLAB(R) 9.11 and Signal Processing Toolbox 8.7.
% Generated on: 13-Nov-2021 13:24:42

% FIR Window Lowpass filter designed using the FIR1 function.

% All frequency values are in Hz.
Fs = 24000;  % Sampling Frequency

Fpass = 5800;              % Passband Frequency
Fstop = 6200;              % Stopband Frequency
Dpass = 0.057501127785;    % Passband Ripple
Dstop = 0.00031622776602;  % Stopband Attenuation
flag  = 'scale';           % Sampling Flag

% Calculate the order from the parameters using KAISERORD.
[N,Wn,BETA,TYPE] = kaiserord([Fpass Fstop]/(Fs/2), [1 0], [Dstop Dpass]);

% Calculate the coefficients using the FIR1 function.
b  = fir1(N, Wn, TYPE, kaiser(N+1, BETA), flag);
Hd = dfilt.dffir(b);

% [EOF]
