[s]=PLL_init(0.1,1,1,2*pi/100,1,1024);
Nb=10; %number of blocks
Ns=100; %number of samples
load('ref_stepf'); % input signal
%scaling the provided waveforms
for j= 1:1000
    ref_in(j)= ref_in(j)*3;
end
in_scale = reshape(ref_in,Ns,Nb);
out=zeros(Ns,Nb);
for n=1:Nb
    [out(:,n),s]=PLL(in_scale(:,n),Ns,s);
    plot(1:length(in_scale(:,n)),in_scale(:,n),1:length(in_scale(:,n)),out(:,n))
    
end
y_output= reshape(out,Ns*Nb,1);
y_input=ref_in;
figure
plot(1:length(y_input), y_input);
hold on;
plot(1:length(y_output) , y_output, 'r');
hold off;