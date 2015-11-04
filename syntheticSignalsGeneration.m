% Script para generacion de senales sinteticas 
clear all, close all;
addpath ./mp3readwrite/mp3readwrite/
addpath ./functions/

%% SIN + ENF
fs=44100; %hz
t_final=20;
t=0:1/fs:t_final; %s
f_enf=50; %hz

% CHIRP
a_sin=0.9;
f_sin=100;
sin=a_sin*sin(2*pi()*f_sin*t);

a_enf_20dB=a_sin/100;
enf_20dB=a_enf_20dB*cos(2*pi()*f_enf*t);
senal_20dB=enf_20dB+sin;

a_enf_25dB=a_sin/316;
enf_25dB=a_enf_25dB*cos(2*pi()*f_enf*t);
senal_25dB=enf_25dB+sin;

a_enf_30dB=a_sin/1000;
enf_30dB=a_enf_30dB*cos(2*pi()*f_enf*t);
senal_30dB=enf_30dB+sin;

a_enf_35dB=a_sin/3162;
enf_35dB=a_enf_35dB*cos(2*pi()*f_enf*t);
senal_35dB=enf_35dB+sin;

a_enf_40dB=a_sin/10000;
enf_40dB=a_enf_40dB*cos(2*pi()*f_enf*t);
senal_40dB=enf_40dB+sin;

% Conversion a .wav
wavwrite(senal_20dB,fs,16,'./dataset/sin/senal_20dB.wav');
wavwrite(senal_25dB,fs,16,'./dataset/sin/senal_25dB.wav');
wavwrite(senal_30dB,fs,16,'./dataset/sin/senal_30dB.wav');
wavwrite(senal_35dB,fs,16,'./dataset/sin/senal_35dB.wav');
wavwrite(senal_40dB,fs,16,'./dataset/sin/senal_40dB.wav');

% Conversion a .mp3
mp3write(senal_20dB,fs,16,'./dataset/sin/senal_20dB.mp3');
mp3write(senal_25dB,fs,16,'./dataset/sin/senal_25dB.mp3');
mp3write(senal_30dB,fs,16,'./dataset/sin/senal_30dB.mp3');
mp3write(senal_35dB,fs,16,'./dataset/sin/senal_35dB.mp3');
mp3write(senal_40dB,fs,16,'./dataset/sin/senal_40dB.mp3');

%% CHIRP + ENF
fs=44100; %hz
t_final=50;
t=0:1/fs:t_final; %s
f_enf=50; %hz

% CHIRP
a_ch=0.9;
f_final=1000;
ch=a_ch*chirp(t,20,t_final,f_final);

a_enf_20dB=a_ch/100;
enf_20dB=a_enf_20dB*cos(2*pi()*f_enf*t);
senal_20dB=enf_20dB+ch;

a_enf_25dB=a_ch/316;
enf_25dB=a_enf_25dB*cos(2*pi()*f_enf*t);
senal_25dB=enf_25dB+ch;

a_enf_30dB=a_ch/1000;
enf_30dB=a_enf_30dB*cos(2*pi()*f_enf*t);
senal_30dB=enf_30dB+ch;

a_enf_35dB=a_ch/3162;
enf_35dB=a_enf_35dB*cos(2*pi()*f_enf*t);
senal_35dB=enf_35dB+ch;

a_enf_40dB=a_ch/10000;
enf_40dB=a_enf_40dB*cos(2*pi()*f_enf*t);
senal_40dB=enf_40dB+ch;

% Conversion a .wav
wavwrite(senal_20dB,fs,16,'./dataset/chirp/senal_20dB.wav');
wavwrite(senal_25dB,fs,16,'./dataset/chirp/senal_25dB.wav');
wavwrite(senal_30dB,fs,16,'./dataset/chirp/senal_30dB.wav');
wavwrite(senal_35dB,fs,16,'./dataset/chirp/senal_35dB.wav');
wavwrite(senal_40dB,fs,16,'./dataset/chirp/senal_40dB.wav');

% Conversion a .mp3
mp3write(senal_20dB,fs,16,'./dataset/chirp/senal_20dB.mp3');
mp3write(senal_35dB,fs,16,'./dataset/chirp/senal_25dB.mp3');
mp3write(senal_30dB,fs,16,'./dataset/chirp/senal_30dB.mp3');
mp3write(senal_35dB,fs,16,'./dataset/chirp/senal_35dB.mp3');
mp3write(senal_40dB,fs,16,'./dataset/chirp/senal_40dB.mp3');

%% Voz + ENF
[voz_original, fs] = wavread('./dataset/voz/voz_pablo_original_2.wav');
voz_original=voz_original';
a_voz=max(voz_original);
l=length(voz_original);

t=0:1/fs:(l-1)/fs; %s
f_enf=50; %hz

a_enf_20dB=a_voz/100;
enf_20dB=a_enf_20dB*cos(2*pi()*f_enf*t);
senal_20dB=enf_20dB+voz_original;

a_enf_25dB=a_voz/316;
enf_25dB=a_enf_25dB*cos(2*pi()*f_enf*t);
senal_25dB=enf_25dB+voz_original;

a_enf_30dB=a_voz/1000;
enf_30dB=a_enf_30dB*cos(2*pi()*f_enf*t);
senal_30dB=enf_30dB+voz_original;

a_enf_35dB=a_voz/3162;
enf_35dB=a_enf_35dB*cos(2*pi()*f_enf*t);
senal_35dB=enf_35dB+voz_original;

a_enf_40dB=a_voz/10000;
enf_40dB=a_enf_40dB*cos(2*pi()*f_enf*t);
senal_40dB=enf_40dB+voz_original;

% Conversion a .wav
wavwrite(senal_20dB,fs,16,'./dataset/voz/senal_20dB.wav');
wavwrite(senal_25dB,fs,16,'./dataset/voz/senal_25dB.wav');
wavwrite(senal_30dB,fs,16,'./dataset/voz/senal_30dB.wav');
wavwrite(senal_35dB,fs,16,'./dataset/voz/senal_35dB.wav');
wavwrite(senal_40dB,fs,16,'./dataset/voz/senal_40dB.wav');

% Conversion a .mp3
mp3write(senal_20dB,fs,16,'./dataset/voz/senal_20dB.mp3');
mp3write(senal_35dB,fs,16,'./dataset/voz/senal_25dB.mp3');
mp3write(senal_30dB,fs,16,'./dataset/voz/senal_30dB.mp3');
mp3write(senal_35dB,fs,16,'./dataset/voz/senal_35dB.mp3');
mp3write(senal_40dB,fs,16,'./dataset/voz/senal_40dB.mp3');


