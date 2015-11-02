clear all, close all;
addpath ./mp3readwrite/mp3readwrite/
addpath ./functions/

%% Files reading

[senal_20dB, fs]=wavread('./dataset/sin/senal_20dB.wav');
senal_25dB=wavread('./dataset/sin/senal_25dB.wav');
senal_30dB=wavread('./dataset/sin/senal_30dB.wav');
senal_35dB=wavread('./dataset/sin/senal_35dB.wav');
senal_40dB=wavread('./dataset/sin/senal_40dB.wav');

senal_20dB_mp3=mp3read('./dataset/sin/senal_20dB.mp3');
senal_25dB_mp3=mp3read('./dataset/sin/senal_25dB.mp3');
senal_30dB_mp3=mp3read('./dataset/sin/senal_30dB.mp3');
senal_35dB_mp3=mp3read('./dataset/sin/senal_35dB.mp3');
senal_40dB_mp3=mp3read('./dataset/sin/senal_40dB.mp3');


%% FFT
L=length(senal_20dB);
NFFT = 2^nextpow2(L); % Next power of 2 from length of y

SENAL_20dB = fft(hanning(L).*senal_20dB,NFFT)/L;
SENAL_30dB = fft(hanning(L).*senal_25dB,NFFT)/L;
SENAL_40dB = fft(hanning(L).*senal_30dB,NFFT)/L;
SENAL_50dB = fft(hanning(L).*senal_35dB,NFFT)/L;
SENAL_60dB = fft(hanning(L).*senal_40dB,NFFT)/L;

% L_mp3=length(senal_50dB_mp3);
% NFFT_mp3 = 2^nextpow2(L_mp3);

SENAL_20dB_mp3 = fft(hanning(L).*senal_20dB_mp3,NFFT)/L;
SENAL_30dB_mp3 = fft(hanning(L).*senal_25dB_mp3,NFFT)/L;
SENAL_40dB_mp3 = fft(hanning(L).*senal_30dB_mp3,NFFT)/L;
SENAL_50dB_mp3 = fft(hanning(L).*senal_35dB_mp3,NFFT)/L;
SENAL_60dB_mp3 = fft(hanning(L).*senal_40dB_mp3,NFFT)/L;
f = fs/2*linspace(0,1,NFFT/2+1);

% Plot single-sided amplitude spectrum.
figure, subplot(2,1,1), plot(f,10*log10(abs(SENAL_20dB(1:NFFT/2+1)))) 
title('Senal 20dB .wav'), xlabel('Frequency (Hz)'), ylabel('|X(f)|'),
axis([0 150 -200 0])
subplot(2,1,2), plot(f,10*log10(abs(SENAL_20dB_mp3(1:NFFT/2+1)))) 
title('Senal 20dB .mp3'), xlabel('Frequency (Hz)'), ylabel('|X(f)|')
axis([0 150 -200 0])

figure, subplot(2,1,1), plot(f,10*log10(abs(SENAL_30dB(1:NFFT/2+1)))) 
title('Senal 25dB .wav'), xlabel('Frequency (Hz)'), ylabel('|X(f)|'),
axis([0 150 -200 0])
subplot(2,1,2), plot(f,10*log10(abs(SENAL_30dB_mp3(1:NFFT/2+1)))) 
title('Senal 25dB .mp3'), xlabel('Frequency (Hz)'), ylabel('|X(f)|')
axis([0 150 -200 0])

figure, subplot(2,1,1), plot(f,10*log10(abs(SENAL_40dB(1:NFFT/2+1)))) 
title('Senal 30dB .wav'), xlabel('Frequency (Hz)'), ylabel('|X(f)|'),
axis([0 150 -200 0])
subplot(2,1,2), plot(f,10*log10(abs(SENAL_40dB_mp3(1:NFFT/2+1)))) 
title('Senal 30dB .mp3'), xlabel('Frequency (Hz)'), ylabel('|X(f)|')
axis([0 150 -200 0])

figure, subplot(2,1,1), plot(f,10*log10(abs(SENAL_50dB(1:NFFT/2+1)))) 
title('Senal 40dB .wav'), xlabel('Frequency (Hz)'), ylabel('|X(f)|'),
axis([0 150 -200 0])
subplot(2,1,2), plot(f,10*log10(abs(SENAL_50dB_mp3(1:NFFT/2+1)))) 
title('Senal 40dB .mp3'), xlabel('Frequency (Hz)'), ylabel('|X(f)|')
axis([0 150 -200 0])

figure, subplot(2,1,1), plot(f,10*log10(abs(SENAL_60dB(1:NFFT/2+1)))) 
title('Senal 45dB .wav'), xlabel('Frequency (Hz)'), ylabel('|X(f)|'),
axis([0 150 -200 0])
subplot(2,1,2), plot(f,10*log10(abs(SENAL_60dB_mp3(1:NFFT/2+1)))) 
title('Senal 45dB .mp3'), xlabel('Frequency (Hz)'), ylabel('|X(f)|')
axis([0 150 -200 0])



%% ENF-Energy analysis
% deltaf=0.6;
% fenf=50;
% var50_20dB = enf_energy_analysis(deltaf, fenf, senal_20dB, fs)
% var50_30dB = enf_energy_analysis(deltaf, fenf, senal_30dB, fs)
% var50_40dB = enf_energy_analysis(deltaf, fenf, senal_40dB, fs)
% var50_50dB = enf_energy_analysis(deltaf, fenf, senal_50dB, fs)
% var50_60dB = enf_energy_analysis(deltaf, fenf, senal_60dB, fs)

