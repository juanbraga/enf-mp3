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
header_aux = ['F1      ' ;'F2      '; 'etiqueta'];
header = cellstr(header_aux);
ahumada_wav_entrenamiento = [F1_ahumada(2:2:end); F2_ahumada(2:2:end)]';

for j=4:2:length(files_ahumada)
    if find(files_ahumada(j).name=='e')
        ahumada_wav_entrenamiento(j/2-1,3)=1;
    else
        ahumada_wav_entrenamiento(j/2-1,3)=0;
    end
end
csvwrite_with_headers('./csv/ahumadafilt_wav_entrenamiento.csv', ahumada_wav_entrenamiento, header);

%% mp3

ahumada_mp3_test = [F1_ahumada(1:2:end); F2_ahumada(1:2:end)]';


for j=3:2:length(files_ahumada)
    if find(files_ahumada(j).name=='e')
        ahumada_mp3_test((j-1)/2,3)=1;
    else
        ahumada_mp3_test((j-1)/2,3)=0;
    end
end
csvwrite_with_headers('./csv/ahumadafilt_mp3_test.csv', ahumada_mp3_test, header);
