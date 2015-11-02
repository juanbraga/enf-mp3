function coef=Inst_enf_variation(file)

if strcmp('.wav', file(end-3:end))
    [x,fs,b]=wavread(file);
else if strcmp('.mp3', file(end-3:end))
    [x,fs,b]=mp3read(file);
    else
       return
    end
end

fsd=1000;
xd=resample(x,fsd/1000,fs/1000,20);
xd=0.99*xd/max(abs(xd));
p1=150;  % Minimum voice-inactivity duration in ms
p2=50;   % Minimum voice-activity duration in ms
%%%%% Calling function vad_v3 / by Paulo Esquef 2014
[vad,ind0,ind1] = vad_v3(xd,fsd,p1,p2);
load filter_50Hz_1p4Hz_4th
xd_f=filtfilt(b,a,xd);
window=hann(length(xd_f));
[Xdf,w]=freqz(xd_f.*window,1,100000,'whole');
xenfa=hilbert(xd_f);
[Xenfa,w]=freqz(xenfa.*window,1,100000,'whole');
f=fsd*angle(xenfa.*conj([0; xenfa(1:end-1)]))/(2*pi);


%Step5
N=5;  % order
[b20,a20] = ellip(N,0.5,64.25,[19.37]./(fsd/2)); 
%freqz(b20,a20,4*8192,fsd)
br=1000; % nr samples discarded in the begining and at the end
mf=median(f(br:end-br));

d=abs(filtfilt(b20,a20,f-mf));

br=1000; % nr samples discarded in the begining and at the end
ventana=zeros(length(d),1);
ventana(br:end-br)=1;
% plot(d.*ventana)

%b=tpswma_new2(d,length(d),600,150,2); % calculates a variable thrshold for mf via TPSW filtering 
b=tpsw(d,500,125,1);  % the length of the split-window is 100 samples
% mx=tpsw(x,npts,n,p,a)
% Caculates a local mean estimate of the vector x using the so-called
% "two-pass split window" filtering
% INPUTS:
% x: input vector (supposed to have positive-valued samples)
% n: half of the length of the split window  
% p: half of the length of the central gap
% a: constant used in the computation of the input signal for the second pass 
% If all samples of x are greater than 1, the value of 'a' should be greater than 1 (between 1 and 5). 
% If all samples of x are between 0 and 1, the value of 'a' should be less
% than 1.
% OUTPUT:
% mx: output vector with local mean estimate
b=filter2(ones(100,1)./100,b); 

%d=d(br:end-br); 
d=d.*ventana;
%b=b(br:end-br); 
t=b+5*median(b); 
t=t.*ventana;
[d_max, i]=max(d);
th=t(i);
coef=d_max/th;
if d_max>th
    disp('edited')
else
    disp(' not edited')
end
% plot(d,'b','linewidth',2)
% hold on
% plot(t,'k','linewidth',2)
% xlabel('n (samples at f_{sd}=1000Hz)')
% legend('d(n)','t(n)')
% title(titulo)
