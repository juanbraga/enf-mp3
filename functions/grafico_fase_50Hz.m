function [F1,F2]=grafico_fase_50Hz(file,deltaf,num_periodos,Nfft)

%vari�veis de saida
%F1 --> feauture usando DFT
%F2 --> feature usando DFT^1

%vari�veis de entrada
%arquivo --> localiza��o da grava��o (pasta, diret�rio, subdiret�rio, etc)
%deltaf--> largura de faixa do filtro [Hz] 
%num_periodos --> tamanho da janela (n�mero de ciclos da ENF nominal)
%Nfft --> n�mero de pontos da DFT

if strcmp('.wav', file(end-3:end))
    [samples,fs_original,b]=wavread(file);
else if strcmp('.mp3', file(end-3:end))
    [samples,fs_original,b]=mp3read(file);
    else
       return
    end
end

tam= length(samples);

fs=1000;

original=samples;
original=original-mean(original);

%Para fazer o sub-amostragem a 1200Hz --> diminuir a carga de processamento
%computacional

original_f2=resample(original,fs,fs_original);
tam2=length(original_f2);

%Para o filtro passa baixas agudo

fc=50;

f1=fc-deltaf/2;
f2=fc+deltaf/2;

%para normalizar os valores: [0 fs/2]--> [0 pi] 
w1=f1*2*pi/fs; 
w2=f2*2*pi/fs;

%para normalizar os valores: [0 pi] --> [0 1]
Wn=[w1 w2]/pi;  

%N�mero de coeficientes do filtro
N=10000;

%Requerimento de filtfilt
if tam2<=3*N,
    h=fir1(N,Wn,'bandpass'); %Para definir a resposta impulsiva do filtro
    original_f2=[zeros(1.5*N-round(tam2/2)+50,1);original_f2;zeros(1.5*N+50-round(tam2/2),1)];
    orig_filtrada=filtfilt(h,1,original_f2); %Para executar um filtro sem defazamento
    original_f2=original_f2(1.5*N-round(tam2/2)+50+1:1.5*N-round(tam2/2)+50+tam2);   %Eliminar o excesso de zeros
    orig_filtrada=orig_filtrada(1.5*N-round(tam2/2)+50+1:1.5*N-round(tam2/2)+50+tam2); %Eliminar o excesso de zeros
else
    h=fir1(N,Wn,'bandpass'); %Para definir a resposta impulsiva do filtro
    original_f2=[zeros(1000,1);original_f2;zeros(1000,1)];
    orig_filtrada=filtfilt(h,1,original_f2); %Para executar um filtro sem defazamento
    original_f2=original_f2(1001:1000+tam2);   %Eliminar o excesso de zeros
    orig_filtrada=orig_filtrada(1001:1000+tam2); %Eliminar o excesso de zeros
    
end




%Para o processo de seguimento de fase na ENF (60 Hz em Espanha)
%orig_filtrada=resample(orig_filtrada,10000,fs);
tam2=length(orig_filtrada);

%Para o processo de seguimento de fase na ENF (50 Hz em Espanha)
t_periodo=1/50;
amostras_periodo=t_periodo*fs;

%num_periodos=3;
%num_periodos=10;
t_bloco=num_periodos/50;
amostras_bloco=t_bloco*fs;

n_blocos=fix(tam2/amostras_periodo)-(num_periodos-1);

inicio=1:amostras_periodo:(n_blocos-1)*amostras_periodo+1;

fim=inicio+amostras_bloco-1;

f1                =  zeros(n_blocos,1);
f2                =  f1;
phase1            =  f1;
phase2            =  f1;
der_orig_filtrada=fs*diff([0; orig_filtrada]);

NFFT_2=Nfft/2;
for i=1:n_blocos,
    
    if mod(i,200)==0
       clc;
       disp('Processando ...'); 
       disp (i); 
       disp('out of'); 
       disp(n_blocos)
    end
    %[fftaux1,W]=freqz(hanning(amostras_bloco).*orig_filtrada(inicio(i):fim(i)),1,5000);
    naco    =     orig_filtrada(inicio(i):fim(i));
    nacoDOT =     der_orig_filtrada(inicio(i):fim(i));
    janela=hanning(amostras_bloco);
    xj=janela.*naco;
    [XJ,W]=freqz(xj,1,NFFT_2);
    
    %  % (1) frame sem janelamento:
    % naco=[x(k); naco(1:(windowsize-1))];
    % % (2) DFT^0 janelado:
    % xj=janela.*naco;
    % [XJ,W]=freqz(xj,1,10000);
    % % (3) obtendo xDOT:
    % nacoDOT=[xdot(k); nacoDOT(1:(windowsize-1))];
    % (4) janelar xDOT:
    xjDOT=janela.*nacoDOT;
    % (5) DFT^1 = DFT{xDOT janelado}:
    [XJDOT,W]=freqz(xjDOT,1,NFFT_2);
    % (6) DFT1 = DFT1*F(w):
    XJDOT=XJDOT.*W./(2*sin(W/2));
    % (7) Achar Kmax e computar f(t):
    [maxXJ,Kmax]=max(abs(XJ));
    f1(i)=(fs/2)*W(Kmax)/pi;  %(fs/2)*W(101)/pi = 50Hz
    f2(i)=abs(XJDOT(Kmax))/(2*pi*abs(XJ(Kmax)));
    
    phase1(i)=angle(XJ(Kmax));
    cw0=cos(2*pi*f2(i)/fs);
    sw0=sin(2*pi*f2(i)/fs);
    %phase2(k)=180*(atan((tan(angle(XJDOT(Kmax)))*(1-cw0)-sw0)/(1-cw0+tan(angle(XJDOT(Kmax)))*sw0)))/pi; 
    %phase2(k)=180*(atan((tan(angle(XJDOT(Kmax))-pi)*(1-cw0)-sw0)/(1-cw0+tan(angle(XJDOT(Kmax))-pi)*sw0)))/pi;
    %phase2(i)=(atan((tan(angle(XJDOT(Kmax)))*(1-cw0)-sw0)/(1-cw0+tan(angle(XJDOT(Kmax)))*sw0)));

    ind_men_k_freq=floor(f2(i)*Nfft/fs)+1;
    ind_maj_k_freq=ind_men_k_freq+1;
    
    f_men=(fs/2)*W(ind_men_k_freq)/pi;
    f_maj=(fs/2)*W(ind_maj_k_freq)/pi;
    
    phase_men=(angle(XJDOT(ind_men_k_freq))); %/pi*180 %para theta
    phase_maj=(angle(XJDOT(ind_maj_k_freq))); %/pi*180 %para theta
    
    phase_aux=[phase_men phase_maj];
    phase_aux=unwrap(phase_aux);
    
    phase_men=phase_aux(1);
    phase_maj=phase_aux(2);
    
    phase_theta=(phase_maj-phase_men)*(f2(i)-f_men)/(f_maj-f_men)+phase_men;
    
    phase2(i)=atan( ( tan(phase_theta)*(1-cw0)-sw0 )/( 1 - cw0 + tan(phase_theta)*sw0 ) );
        
end

%===========================================================
%valida��o de phase2
%============================================================

tam_phase=length(f1);
aux_phase2=zeros(tam_phase,2);

ref_phase=[phase1 phase1];
for i=1:tam_phase,
    
    if phase2(i)<0,
        aux_phase2(i,1)= pi+phase2(i);
        aux_phase2(i,2)= phase2(i);
    else
        aux_phase2(i,1)= phase2(i);
        aux_phase2(i,2)= -(pi-phase2(i));
    end
end
 
distan_phase=aux_phase2-ref_phase;
distan_phase=valida_phase(distan_phase);

distan_phase=abs(distan_phase);
[val, indices_phase]=min(distan_phase');
indices_phase=indices_phase';

for i=1:tam_phase,
    
    phase2(i)=aux_phase2(i,indices_phase(i));
end

%===========================================================


phase1=unwrap(phase1);

phase1=180*phase1/pi;


phase2=unwrap(phase2);

phase2=180*phase2/pi;


%================================================
%Para o valor da derivada

derivada1=phase1(2:end)-phase1(1:end-1);
derivada2=phase2(2:end)-phase2(1:end-1);




%====================================================================
%Para as medidas de avalia��o
%====================================================================

aux_der         =derivada1;
aux_der         =aux_der-mean(aux_der);
aux_der         =aux_der.*aux_der;
F1         =sum(abs(aux_der))/(length(aux_der));
F1         =100*log10(F1);


aux_der2        =derivada2;
aux_der2        =aux_der2-mean(aux_der2);
aux_der2        =aux_der2.*aux_der2;
F2         =sum(abs(aux_der2))/(length(aux_der2));
F2         =100*log10(F2);

tempo=tam/fs_original;


% figure(1);
% 
% T_aux=1/fs_original;
% %t=(1:length(phase1))*T_aux;
% 
% t=(1:tam)*T_aux;
% 
% subplot(5,1,1);
% 
% 
% plot(t,samples);
% hold on;
% %plot([pontos_edi(1):pontos_edi(2)]*T_aux,samples(pontos_edi(1):pontos_edi(2)),'r');
% xx1=axis;
% xx1(2)=max(t);
% axis(xx1);
% xlabel('Tempo(segundos)');
% ylabel('Amplitude');
% legend('Sinal Original');
% 
% subplot(5,1,[2 3]);
% plot(phase1,'LineWidth',2);
% hold on;
% xx3=axis;
% xx3(2)=length(phase1);
% xx3(3)=min(phase1)-5;
% xx3(4)=max(phase1)+5;
% axis(xx3);
% xlabel('Ciclos da ENF nominal (n_{b})');
% ylabel('Fase(graus)');
% %title('Estima��o de fase: M�todo DFT');
% legend('DFT');
% 
% 
% subplot(5,1,[4 5]);
% plot(phase2,'LineWidth',2);
% hold on;
% xx4=axis;
% xx4(2)=length(phase2);
% xx4(3)=min(phase2)-5;
% xx4(4)=max(phase2)+5;
% axis(xx4);
% legend('DFT^{1}');
% xlabel('Ciclos da ENF nominal (n_{b})');
% ylabel('Fase(graus)');
