function Hd = LS
%LS Returns a discrete-time filter object.

% MATLAB Code
% Generated by MATLAB(R) 9.10 and Signal Processing Toolbox 8.6.
% Generated on: 06-Nov-2021 01:34:53

% FIR least-squares Lowpass filter designed using the FIRLS function.

% All frequency values are in Hz.
Fs = 48000;  % Sampling Frequency

N     = 405;   % Order
Fpass = 3800;  % Passband Frequency
Fstop = 4200;  % Stopband Frequency
Wpass = 1;     % Passband Weight
Wstop = 90;    % Stopband Weight

% Calculate the coefficients using the FIRLS function.
b  = firls(N, [0 Fpass Fstop Fs/2]/(Fs/2), [1 1 0 0], [Wpass Wstop]);
Hd = dfilt.dffir(b);

% [EOF]
