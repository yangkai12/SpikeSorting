function yMod=TenToN(A,N)
% Search range of sparse signal
yDiv=A;
yMod=zeros(1,3);
i=1;
while A>0
    
    yMod(i)=mod(A,N);
    A=floor(A/N);
    i=i+1;
end

