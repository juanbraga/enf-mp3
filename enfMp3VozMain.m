clear all, close all;
addpath ./mp3readwrite/mp3readwrite/
addpath ./functions/

%% Files reading

[senal_20dB, fs]=wavread('./dataset/voz/senal_20dB.wav');
senal_25dB=wavread('./dataset/voz/senal_25dB.wav');
senal_30dB=wavread('./dataset/voz/senal_30dB.wav');
senal_35dB=wavread('./dataset/voz/senal_35dB.wav');
senal_40dB=wavread('./dataset/voz/senal_40dB.wav');

senal_20dB_mp3=mp3read('./dataset/voz/senal_20dB.mp3');
senal_25dB_mp3=mp3read('./dataset/voz/senal_25dB.mp3');
senal_30dB_mp3=mp3read('./dataset/voz/senal_30dB.mp3');
senal_35dB_mp3=mp3read('./dataset/voz/senal_35dB.mp3');
senal_40dB_mp3=mp3read('./dataset/voz/senal_40dB.mp3');

%% Espectrogramas
window_length = 4*8*2048;
n_step = 4*256;
nfft = 2*window_length;
n_overlap = window_length/2; 

% Espectrogramas senales .wav
[S_20dB,F,T,P_20dB] = spectrogram(senal_20dB,hanning(nfft),n_overlap,nfft,fs,'yaxis');
[S_30dB,F,T,P_30dB] = spectrogram(senal_25dB,hanning(nfft),n_overlap,nfft,fs,'yaxis');
[S_40dB,F,T,P_40dB] = spectrogram(senal_30dB,hanning(nfft),n_overlap,nfft,fs,'yaxis');
[S_50dB,F,T,P_50dB] = spectrogram(senal_35dB,hanning(nfft),n_overlap,nfft,fs,'yaxis');
[S_60dB,F,T,P_60dB] = spectrogram(senal_40dB,hanning(nfft),n_overlap,nfft,fs,'yaxis');

% figure('Name','Espectrograma .wav (dB)'),
% subplot(2,2,1), imagesc(T,F,10*log10(P_20dB)), axis xy,
% title('Espectrograma 20dB'), xlabel('Tiempo(s)'), ylabel('Frecuencia(Hz)'),
% axis([0 max(T) 40 70]);
% subplot(2,2,2), imagesc(T,F,10*log10(P_30dB)), axis xy,
% title('Espectrograma 30dB'), xlabel('Tiempo(s)'), ylabel('Frecuencia(Hz)'),
% axis([0 max(T) 40 70]);
% subplot(2,2,3), imagesc(T,F,10*log10(P_40dB)), axis xy,
% title('Espectrograma 40dB'), xlabel('Tiempo(s)'), ylabel('Frecuencia(Hz)'),
% axis([0 max(T) 40 70]);
% subplot(2,2,4), imagesc(T,F,10*log10(P_50dB)), axis xy,
% title('Espectrograma 50dB'), xlabel('Tiempo(s)'), ylabel('Frecuencia(Hz)'),
% axis([0 max(T) 40 70]);

% Espectrogramas senales .mp3
[S_20dB_mp3,F,T,P_20dB_mp3] = spectrogram(senal_20dB_mp3,hanning(nfft),n_overlap,nfft,fs,'yaxis');
[S_30dB_mp3,F,T,P_30dB_mp3] = spectrogram(senal_25dB_mp3,hanning(nfft),n_overlap,nfft,fs,'yaxis');
[S_40dB_mp3,F,T,P_40dB_mp3] = spectrogram(senal_30dB_mp3,hanning(nfft),n_overlap,nfft,fs,'yaxis');
[S_50dB_mp3,F,T,P_50dB_mp3] = spectrogram(senal_35dB_mp3,hanning(nfft),n_overlap,nfft,fs,'yaxis');
[S_60dB_mp3,F,T,P_60dB_mp3] = spectrogram(senal_40dB_mp3,hanning(nfft),n_overlap,nfft,fs,'yaxis');

% figure('Name','Espectrograma .mp3 (dB)'),
% subplot(2,2,1), imagesc(T,F,10*log10(P_20dB_mp3)), axis xy,
% title('Espectrograma 20dB'), xlabel('Tiempo(s)'), ylabel('Frecuencia(Hz)'),
% axis([0 max(T) 40 70]);
% subplot(2,2,2), imagesc(T,F,10*log10(P_30dB_mp3)), axis xy,
% title('Espectrograma 30dB'), xlabel('Tiempo(s)'), ylabel('Frecuencia(Hz)'),
% axis([0 max(T) 40 70]);
% subplot(2,2,3), imagesc(T,F,10*log10(P_40dB_mp3)), axis xy,
% title('Espectrograma 40dB'), xlabel('Tiempo(s)'), ylabel('Frecuencia(Hz)'),
% axis([0 max(T) 40 70]);
% subplot(2,2,4), imagesc(T,F,10*log10(P_50dB_mp3)), axis xy,
% title('Espectrograma 50dB'), xlabel('Tiempo(s)'), ylabel('Frecuencia(Hz)'),
% axis([0 max(T) 40 70]);


%%
figure('Name','Espectrograma (dB)'),
subplot(2,1,1), imagesc(T,F,10*log10(P_20dB)), axis xy,
title('Espectrograma .wav 20dB'), xlabel('Tiempo(s)'), ylabel('Frecuencia(Hz)'),
axis([0 max(T) 40 70]);
subplot(2,1,2), imagesc(T,F,10*log10(P_20dB_mp3)), axis xy,
title('Espectrograma .mp3 20dB'), xlabel('Tiempo(s)'), ylabel('Frecuencia(Hz)'),
axis([0 max(T) 40 70]);

figure('Name','Espectrograma (dB)'),
subplot(2,1,1), imagesc(T,F,10*log10(P_30dB)), axis xy,
title('Espectrograma .wav 25dB'), xlabel('Tiempo(s)'), ylabel('Frecuencia(Hz)'),
axis([0 max(T) 40 70]);
subplot(2,1,2), imagesc(T,F,10*log10(P_30dB_mp3)), axis xy,
title('Espectrograma .mp3 25dB'), xlabel('Tiempo(s)'), ylabel('Frecuencia(Hz)'),
axis([0 max(T) 40 70]);

figure('Name','Espectrograma (dB)'),
subplot(2,1,1), imagesc(T,F,10*log10(P_40dB)), axis xy,
title('Espectrograma .wav 30dB'), xlabel('Tiempo(s)'), ylabel('Frecuencia(Hz)'),
axis([0 max(T) 40 70]);
subplot(2,1,2), imagesc(T,F,10*log10(P_40dB_mp3)), axis xy,
title('Espectrograma .mp3 30dB'), xlabel('Tiempo(s)'), ylabel('Frecuencia(Hz)'),
axis([0 max(T) 40 70]);

figure('Name','Espectrograma (dB)'),
subplot(2,1,1), imagesc(T,F,10*log10(P_50dB)), axis xy,
title('Espectrograma .wav 35dB'), xlabel('Tiempo(s)'), ylabel('Frecuencia(Hz)'),
axis([0 max(T) 40 70]);
subplot(2,1,2), imagesc(T,F,10*log10(P_50dB_mp3)), axis xy,
title('Espectrograma .mp3 35dB'), xlabel('Tiempo(s)'), ylabel('Frecuencia(Hz)'),
axis([0 max(T) 40 70]);

figure('Name','Espectrograma (dB)'),
subplot(2,1,1), imagesc(T,F,10*log10(P_60dB)), axis xy,
title('Espectrograma .wav 40dB'), xlabel('Tiempo(s)'), ylabel('Frecuencia(Hz)'),
axis([0 max(T) 40 70]);
subplot(2,1,2), imagesc(T,F,10*log10(P_60dB_mp3)), axis xy,
title('Espectrograma .mp3 40dB'), xlabel('Tiempo(s)'), ylabel('Frecuencia(Hz)'),
axis([0 max(T) 40 70]);