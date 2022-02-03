[s]=PLL_init(0.1,1,1,2*pi/100,1,1024);
Nb=10; %number of blocks
Ns=100; %number of samples

load('ref_stepf'); %input signal
in= reshape(ref_in,Ns,Nb);
out = zeros(Ns,Nb);
for n=1:Nb
    [out(:,n),s]=PLL(in(:,n),Ns,s);
    plot(1:length(in(:,n)),in(:,n),1:length(in(:,n)),out(:,n))
    
end

