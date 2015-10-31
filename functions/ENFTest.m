function [ detected, format ] = ENFTest( file )
%ENFTEST Summary of this function goes here
%   Detailed explanation goes here
if strcmp('.wav', file(end-3:end))
    [x,fs,nb]=wavread(file);
    format = '.wav';
else if strcmp('.mp3', file(end-3:end))
    [x,fs,nb]=mp3read(file);
    format = '.mp3';
    else
       return
    end
end

fsrs=200; % frequency for re-sampling 
%----------------------------------------
% BAND-PASS filter 1 (50Hz)
%----------------------------------------
N=500;
deltaf1=0.1;
f1=50-deltaf1/2; %tempo cont�nuo
f2=50+deltaf1/2;
w1=2*pi*f1/fsrs;  %tempo discreto
w2=2*pi*f2/fsrs;
h1=fir1(N,[w1 w2]/pi,'bandpass');
[H1,W]=freqz(h1,1,100000);
%----------------------------------------

% BAND-PASS filter 2 (60Hz)
%----------------------------------------
deltaf2=0.1;
f1=60-deltaf2/2; %tempo cont�nuo
f2=60+deltaf2/2;
w1=2*pi*f1/fsrs;  %tempo discreto
w2=2*pi*f2/fsrs;
h2=fir1(N,[w1 w2]/pi,'bandpass');
[H2,W]=freqz(h2,1,100000);

% figure, plot((fsrs/2)*W/pi,abs(H1))
% hold on
% plot((fsrs/2)*W/pi,abs(H2),'--r')
% hold off

x=x-mean(x); x=x/std(x);
boo=x.*hamming(length(x));
% [X,W]=freqz(boo,1,5000000);
% subplot(2,1,1)
% plot((fs/2)*W/pi,abs(X),'linewidth',1.5)
% xlabel('Frequency (Hz)')
% axis([0 200 0 5000])
% grid
x=resample(x,fsrs,fs);
x50=filtfilt(h1,1,x);
x60=filtfilt(h2,1,x);
[X,W]=freqz(x,1,10000);
[X50,W]=freqz(x50,1,10000);
[X60,W]=freqz(x60,1,10000);
var50=var(abs(X50));
var60=var(abs(X60));

if var50 > 10*var60
    disp(file)
    disp('50Hz ENF is present!')
    detected = 1;
elseif var60 > 10*var50
    disp(file)
    disp('60H ENF is present!')
    detected = 1;
else
    disp(file)
    disp('No ENF!!!')
    detected = 0;
end

% title('CARIOCA')
% subplot(2,1,2)
% plot((fsrs/2)*W/pi,abs(X50),'linewidth',1.5); hold; plot((fsrs/2)*W/pi,abs(X60),'linewidth',1.5,'color',[1 0 0])
% xlabel('Frequency (Hz)')
% 
% if var50 > 10*var60
%     % axis([40 70 0 100])
%     ylabel('ENF 50Hz')
%     grid
% elseif var60 > 10*var50
%     % axis([40 70 0 10])
%     grid
%     ylabel('ENF 60Hz')
% else
%     % axis([40 70 0 0.1])
%     grid
%     ylabel('No ENF')
% end
% legend('After 50Hz BP filter','After 60Hz BP filter')


end

