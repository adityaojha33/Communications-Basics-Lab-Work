% test_delay1.m
%
% Script to test the delay block. Set up to model the way
% samples would be processed in a DSP program.
% Global parameters
Nb = 10; % Number of buffers
Ns = 128; % Samples in each buffer
Nmax = 200; % Maximum delay
Nd = 10; % Delay of block
% Initialize the delay block
state_delay1 = delay_init(Nmax, Nd);
% Generate some random samples.
x = randn(Ns*Nb, 1);
% Reshape into buffers
xb = reshape(x, Ns, Nb);
% Output samples
yb = zeros(Ns, Nb);
% Process each buffer
for bi=1:Nb
 [state_delay1, yb(:,bi)] = delay(state_delay1, xb(:,bi));
end
% Convert individual buffers back into a contiguous signal.
y = reshape(yb, Ns*Nb, 1);
% Check if it worked right
n = [0:length(x)-1];
figure(1);
plot(n, x, n, y);
figure(2);
plot(n+Nd, x, n, y, 'x');
% Do a check and give a warning if it is not right. Skip first buffer in check
% to avoid initial conditions.
n_chk = 1+[Ns:(Nb-1)*Ns-1];
if any(x(n_chk - Nd) ~= y(n_chk))
 warning('A mismatch was encountered.');
end
