close all; clear all;
addpath ./mp3readwrite/mp3readwrite/
addpath ./functions/

files_ahumada=dir('./corpus_ahumada/');
for i=3:length(files_ahumada)
nombre=files_ahumada(i).name;
[nom,ext]=strtok(nombre,'.');
[audio_original, fs] = wavread(strcat('./corpus_ahumada/',nombre));
audio_filt=stop_banda(audio_original,42,58,10,0.1,fs);
wavwrite(audio_filt,fs,strcat('./dataset/ahumada_filt/',nom,'_filt',ext));
mp3write(audio_filt,fs,16,strcat('./dataset/ahumada_filt/',nom,'_filt','.mp3'));
i
end
