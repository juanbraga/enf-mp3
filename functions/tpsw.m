function mx=tpsw(x,n,p,a)
% mx=tpsw(x,npts,n,p,a)
% 
% Caculates a local mean estimate of the vector x using the so-called
% "two-pass split window" filtering
% INPUTS:
% x: input vector (supposed to have positive-valued samples)
% n: half of the length of the split window  
% p: half of the length of the central gap
% a: constant used in the omputation of the input signal for the second pass 
% If all samples of x are greater than 1, the value of 'a' should be greater than 1 (between 1 and 5). 
% If all samples of x are between 0 and 1, the value of 'a' should be less
% than 1.

% OUTPUT:
% mx: output vector with local mean estimate
% 
% Based on the original program by William Soares-Filho
% Instituto de Pesquisas da Marinha, RJ- Brazil

% Last modified: 28th March, 2014

% Split-window generation (Impulse response of the filter used in the first pass)
h=[ones(1,n-p+1) zeros(1,2*p-1) ones(1,n-p+1)];	% sets the filter of the first pass, with central gap 
h=h(:); h=h/norm(h,1);	% normalization
% Ordinary rectangular window generation (Impulse response of the filter
% used in the second pass)
h2=ones(length(h),1); h2=h2/norm(h2,1);	% sets second pass filter without the central gap

%%%%%%%%%
x=x(:); Lx=length(x); 
% Preprocessing of the input signal: extension via mirroring
Lxe=n; % Number of samples to be extended on each extremity: half the length of the split window
ini_x=flipud(x(1:Lxe)); % Signal to be appended in the beginning of x
end_x=x(end-(0:(Lxe-1))); % Signal to be appended in the end of x
x=[ini_x;x;end_x];

% First pass: Filtering with the split-window
mx=filter2(h,x,'same'); % zero-delay filtering of x through h 

% mx is the output of the first pass: it will be a smooth version of x,
% without the peaks of x, but with magnitude bias in the regions that
% surround the peaks. 

% Now, ideia is to determine the indices of the regions that surround the
% peaks. 
sind1=((x+2)>a*(mx+2));  % binary indicator of the indices of the peaks in x 
% The offset of 2 units above is to force that x and mx are greater than 1.
% Thus, 'a' can be always greater than 1.
sind1(1:Lxe)=0; sind1(end-Lxe-1:end)=0; % get rid of indicators in the extremities
sind2=filter2(h2,sind1,'same'); % spreads the 1s' regions in sind1 by the length of the split-window: FIR filtering with h2    
sind2=(sind2>0); % binary indicator of the indices of peaks in x plus their surrondings 
sind2=sind2-sind1; % binary indicator of the indices of peak surrondings only (excluding the peaks)  

mx(find(sind2))=x(find(sind2));  % Input of the second-pass: mx is kept 
% unchanged expect for the regions that surround the peaks, where the
% original samples of x are restituted. 

% close all; plot(x); hold on; plot(mx,'r'); pause; close all  % enable
% this line to see the input of the second pass 

% second pass using an ordinary rectangular window 
mx=filter2(h2,mx,'same');  % second pass via zero-delay FIR filtering
mx=mx(round(1.0*Lxe)+(1:Lx)); % removes transient effects in the final output  

