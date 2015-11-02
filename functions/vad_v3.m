function  [vad,ind0,ind1]=vad_v3(x,fs,p1,p2)
% [vad,ind0,ind1]=vad_v3(x,fs,p1,p2);
% Last modified: 28th March, 2014
% Author: Paulo Esquef, e-mail: pesquef@lncc.br

% INPUTS
% x: input signal (column vector)
% fs: sampling frequency
% p1: minimum voice-inactivity duration in ms, i.e., any mutes will last more than p1 
% p2: minimum voice-active duration in ms, i.e., any voice-active part will
% last at least p2

% typical values: p1=150 ms to 250 ms and p2=50 ms

% OUTPUTS:
% vad: binary indicator vector. vad=1 implies sample related to
% voice-active parts.

% ind0: set of indices related to the voice-inactive intervals. Ex. first mute
% interval ranges from ind0(1) to ind0(2) whereas the second mute interval
% ranges from ind0(3) to ind0(4)

% ind1: set of indices related to the mute intervals. Ex. first vad
% interval ranges from ind1(1) to ind1(2) whereas the second mute interval
% ranges from ind1(3) to ind1(4)


phoneme_int=25; % mean phoneme interval in ms 
win_phoneme=round(phoneme_int*fs/1000);  % mean mute interval in samples 
win1=round(win_phoneme/3);

mx=(abs(x));  % magnitude of the the input vector
energy_profile=ordfilt2(mx,round(win1/2),ones(win1,1)); % applies median filter to mx with window of about 25 ms 

% Obs.: the term energy-profile above is an abuse of terminology, since |x| and not x.^2 is being filtered. 

clear mx

mep=median(energy_profile); % median of the energy _profile 
% OBS: mep is an estimate of the half-excursion of the background level 
[cc,thr_min] = hist(energy_profile,50); % histogram of energy_profile
[vv,inddd] = max(cc); % finds maximum of the histogram count
thr_min=thr_min(inddd+1); % sets minimum threshold for the background level as one bin above that of the maximum (this is on experimental basis)
% The above measure is taken to avoid a too low thr when a large portion of
% the signal is of background noise.
thr=max(3*mep,thr_min);

energy_profile=mep+energy_profile; % lifts up energy_profile by its own mean
energy_profile=ordfilt2(energy_profile,win_phoneme,ones(win_phoneme,1)); % applies maximum filter to the energy profile

vad=energy_profile>thr; % compares energy_profile with thr to generate the initial VAD  
clear energy_profile

% Post processing of VAD:
% Task 1) to remove too short-duration voice-active bursts 
% Task 2) to merge voice-active regions separated by too short-duration mutes

win_mute=round(p1*fs/1000);  % minimum voice-inactivity interval in samples 
win_sp=round(p2*fs/1000);  % minimum voice-activity interval in samples 

[vad,ind1,ind0]=vad_post_processing(~vad,win_sp); % Task 1
[vad,ind0,ind1]=vad_post_processing(~vad,win_mute); % Task2 

function [vad,ind0,ind1]=vad_post_processing(vad,M)

% vad: initial vad as a binary indicator function
% M: minimum number of zero-value consecutive samples in vad

% Function goal:
% 1) fill in zero-valued gaps shorter then M samples

[ind0,ind1]=find_transition_indices(vad);
if ~isempty(ind0),
    for k=2:2:length(ind0),
        if ((ind0(k)-ind0(k-1)) < M) && ind0(k-1)~=1 && ind0(k)~=length(vad),
            ind0(k)=-1; ind0(k-1)=-1;        
        end
    end
    ind0(ind0==-1)=[];
    vad=ones(size(vad));
    for k=1:2:length(ind0)-1,
        vad(ind0(k):ind0(k+1))=0;
    end
end
[ind0,ind1]=find_transition_indices(vad);


function [ind0,ind1]=find_transition_indices(vad)
% vad: binary indicator function
% ind0: indices of the beginning and end of the zero-valued segments in vad 
% ind1: indices of the beginning and end of the one-valued segments in vad

vad1=vad(1);
vadend=vad(end);

ind1_ini=find(diff(vad)==1)+1;
ind1_end=find(diff(vad)==-1);

ind0_ini=find(diff(~vad)==1)+1;
ind0_end=find(diff(~vad)==-1);

ind1=sort([ind1_ini;ind1_end]);
ind0=sort([ind0_ini;ind0_end]);

if isempty(ind0)&&isempty(ind1),
    % either vad is all 1's or all 0's
    if vad1==1,
        ind1=[1 length(vad)];
        ind0=[];
    else
        ind0=[1 length(vad)];
        ind1=[];
    end
else
    if ~vad1&&(ind0(1)<ind1(1)), % if vad1 is equal to 0
        ind0=[1; ind0];
    end

    if ~vadend&&(ind0(end)>ind1(end)), % if vadend is equal to 0
        ind0=[ind0; length(vad)];
    end

    if vad1&&(ind1(1)<ind0(1)), % if vad1 is equal to 1
        ind1=[1; ind1];
    end

    if vadend&&(ind1(end)>ind0(end)), % if vadend is equal to 1
        ind1=[ind1; length(vad)];
    end
end




