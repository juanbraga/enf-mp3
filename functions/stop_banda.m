function [ y ] = stop_banda( x,Fp1,Fp2,Ast,Ap,fs )
%filtro que atenua la banda especificada
%   
Fp1=Fp1*2/fs;
Fp2=Fp2*2/fs;
Fst1=Fp1+(Fp2-Fp1)/3;
Fst2=Fp1+2*(Fp2-Fp1)/3;
d = fdesign.bandstop('Fp1,Fst1,Fst2,Fp2,Ap1,Ast,Ap2',Fp1,Fst1,Fst2,Fp2,Ap,Ast,Ap);
H=design(d);
%freqz(H);
y=filter(H,x);
end
