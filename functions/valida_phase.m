function [phase1]=valida_phase(angulo)

[a,b]=size(angulo);
phase1=zeros(a,b);

for i=1:a,
    for j=1:b,
        phase=angulo(i,j);
        if phase>2*pi,
            entero=floor(phase/(2*pi));
            phase=phase-entero*2*pi;    
        end

        if phase>pi,
            auxi=phase-pi;
            phase=-(pi-auxi); 
        end
    
        if phase<-2*pi,
            entero=floor(abs(phase)/(2*pi));
            phase=phase+entero*2*pi;    
        end

        if phase<-pi,
            auxi=abs(phase)-pi;
            phase=pi-auxi;
        end
        phase1(i,j)=phase;
    end %for j
end %for i

