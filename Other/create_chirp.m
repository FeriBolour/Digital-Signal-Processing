fs=48000;

t=0:1/fs:3;
f0=100;
f1=10000;
x=0.9*chirp(t,f0,3,f1);
sound(x,fs)

%% sampling rate reduction (down sampling)

M=4;            % down sampling rate
x2=x(1:M:end);
fs2=fs/M;
sound(x2,fs2)

%% sampling rate reduction with different phases

M=4;            % down sampling rate
x0=x(1:M:end);  % phase of 0
x1=x(2:M:end);  % phase of 1
x2=x(3:M:end);  % phase of 2
x4=x(4:M:end);  % phase of 3

x0=downsample(x,M,0);


%% decimation of signal (lowpass filter and then remove values)

M=4; 
y0=decimate(x,M)
fs2=fs/M;
sound(y0,fs2)


%% upsampling (introduce zeros)
L=4;

yup(1:L:L*length(y0))=y0;
yup=upsample(y0,L);
yup=interp(y0,L);
plot(yup(1000:1100))



