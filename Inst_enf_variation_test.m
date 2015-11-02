clear all, close all

addpath ./mp3readwrite/mp3readwrite/
addpath ./functions/

files_ahumada=dir('./corpus_ahumada/');
for i=3:length(files_ahumada)
    archivo=strcat('./corpus_ahumada/',files_ahumada(i).name)
    [coef(i-2)]=Inst_enf_variation(archivo);
    
end

%% evalua datos wav
header_aux = ['coef    ' ;'etiqueta'];
header = cellstr(header_aux);
ahumada_wav_entrenamiento =coef(2:2:end)';

for j=4:2:length(files_ahumada)
    if find(files_ahumada(j).name=='e')
        ahumada_wav_entrenamiento(j/2-1,2)=1;
    else
        ahumada_wav_entrenamiento(j/2-1,2)=0;
    end
end
csvwrite_with_headers('./csv/ahumada_wav_instFreq_entrenamiento.csv', ahumada_wav_entrenamiento, header);

%% evalua audios en mp3
header_aux = ['coef    ' ;'etiqueta'];
header = cellstr(header_aux);

ahumada_wav_test = coef(1:2:end)';

for j=3:2:length(files_ahumada)
    if find(files_ahumada(j).name=='e')
        ahumada_wav_test((j-1)/2,2)=1;
    else
        ahumada_wav_test((j-1)/2,2)=0;
    end
end
csvwrite_with_headers('./csv/ahumada_mp3_instFreq_test.csv', ahumada_wav_test, header);
