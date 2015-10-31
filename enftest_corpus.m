clear all, close all

addpath ./mp3readwrite/mp3readwrite/
addpath ./functions/

Nfft=2000;
num_periodos=10;
deltaf=0.8;

%% tests to ahumada

files_ahumada=dir('./corpus_ahumada/');
for i=3:length(files_ahumada)
    [detected_ahumada(i-2) format_ahumada(i-2,:)]=ENFTest(strcat('./corpus_ahumada/',files_ahumada(i).name));
    [F1_ahumada(i-2), F2_ahumada(i-2)] = grafico_fase_50Hz(strcat('./corpus_ahumada/',files_ahumada(i).name),deltaf,num_periodos,Nfft);
end

%% ahumada_csv
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
csvwrite_with_headers('./csv/ahumada_wav_entrenamiento.csv', ahumada_wav_entrenamiento, header);

ahumada_mp3_test = [F1_ahumada(1:2:end); F2_ahumada(1:2:end)]';

for j=3:2:length(files_ahumada)
    if find(files_ahumada(j).name=='e')
        ahumada_mp3_test((j-1)/2,3)=1;
    else
        ahumada_mp3_test((j-1)/2,3)=0;
    end
end
csvwrite_with_headers('./csv/ahumada_mp3_test.csv', ahumada_mp3_test, header);


%% tests to carioca

files_carioca=dir('./corpus_carioca/');
for i=3:length(files_carioca)
    [detected_carioca(i-2) format_carioca(i-2,:)]=ENFTest(strcat('./corpus_carioca/',files_carioca(i).name));
    [F1_carioca(i-2), F2_carioca(i-2)] = grafico_fase_50Hz(strcat('./corpus_carioca/',files_carioca(i).name),deltaf,num_periodos,Nfft);
end

%% carioca csv

carioca_wav_entrenamiento = [F1_carioca(2:2:end); F2_carioca(2:2:end)]';

for j=4:2:length(files_carioca)
    if find(files_carioca(j).name=='e')
        carioca_wav_entrenamiento(j/2-1,3)=1;
    else
        carioca_wav_entrenamiento(j/2-1,3)=0;
    end
end
csvwrite_with_headers('./csv/carioca_wav_entrenamiento.csv', carioca_wav_entrenamiento,header);

carioca_mp3_test = [F1_carioca(1:2:end); F2_carioca(1:2:end)]';

for j=3:2:length(files_carioca)
    if find(files_carioca(j).name=='e')
        carioca_mp3_test((j-1)/2,3)=1;
    else
        carioca_mp3_test((j-1)/2,3)=0;
    end
end
csvwrite_with_headers('./csv/carioca_mp3_test.csv', carioca_mp3_test_header);