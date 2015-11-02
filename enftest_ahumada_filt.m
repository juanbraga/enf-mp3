clear all, close all

addpath ./mp3readwrite/mp3readwrite/
addpath ./functions/

Nfft=2000;
num_periodos=10;
deltaf=0.8;

files_ahumada=dir('./dataset/ahumada_filt/');
for i=3:length(files_ahumada)
    archivo=strcat('./dataset/ahumada_filt/',files_ahumada(i).name);
    [detected_ahumada(i-2) format_ahumada(i-2,:)]=ENFTest(archivo);
    [F1_ahumada(i-2), F2_ahumada(i-2)] = grafico_fase_50Hz(archivo,deltaf,num_periodos,Nfft);
end

%% wav

matriz_csv = [F1_ahumada(2:2:end); F2_ahumada(2:2:end)]';

for j=4:2:length(files_ahumada)
    if find(files_ahumada(j).name=='e')
        matriz_csv(j/2-1,3)=1;
    else
        matriz_csv(j/2-1,3)=0;
    end
end
csvwrite('./csv/ahumada_wav_filt_entrenamiento.csv', matriz_csv);

%% mp3

matriz_csv = [F1_ahumada(2:2:end); F2_ahumada(2:2:end)]';

for j=3:2:length(files_ahumada)
    if find(files_ahumada(j).name=='e')
        matriz_csv((j-1)/2,3)=1;
    else
        matriz_csv((j-1)/2,3)=0;
    end
end
csvwrite('./csv/ahumada_mp3_filt_test.csv', matriz_csv);
