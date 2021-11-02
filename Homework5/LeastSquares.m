function Hd = LeastSquares
%LEASTSQUARES Returns a discrete-time filter object.

% MATLAB Code
% Generated by MATLAB(R) 9.10 and Signal Processing Toolbox 8.6.
% Generated on: 22-Oct-2021 19:35:45

% FIR least-squares Lowpass filter designed using the FIRLS function.

% All frequency values are in Hz.
Fs = 16000;  % Sampling Frequency

N     = 15;    % Order
Fpass = 4000;  % Passband Frequency
Fstop = 6000;  % Stopband Frequency
Wpass = 1;     % Passband Weight
Wstop = 20;    % Stopband Weight

% Calculate the coefficients using the FIRLS function.
b  = firls(N, [0 Fpass Fstop Fs/2]/(Fs/2), [1 1 0 0], [Wpass Wstop]);
Hd = dfilt.dffir(b);

% [EOF]
