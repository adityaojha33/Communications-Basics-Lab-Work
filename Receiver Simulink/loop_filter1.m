function [a, b, tau1, tau2, K, p] = loop_filter1(T, xi, K);

% [a, b, tau1, tau2, K, p] = loop_filter1(T, xi, K);
%
% Computes the filter weights for a simple first order loop
% filter.
%
% Inputs:
%	T	Time constant of the loop filter (2*pi/wn)
%	xi	Damping factor (1 = critically damped)
%	K	Loop gain
% Outputs:
%	a		Coefficients for y
%	b		Coefficients for x
%	tau1, tau2	Loop filter frequency coefficients
%	K		Loop gain

% K = 10;
wn = 2*pi/T;
tau1 = K/(wn)^2;
tau2 = xi*2/wn-1/K;

Td = 1;
a1 = -(Td - 2*tau1)/(Td + 2*tau1);
b0 = (Td + 2*tau2)/(Td + 2*tau1);
b1 = (Td - 2*tau2)/(Td + 2*tau1);

a = [a1];
b = [b0 b1];

if (nargout >= 6),
% Test the response of the filter
N = 1000;
f0 = 1/Td;
f = [0:N-1]/N*f0;
s = j*(2*pi*f);
G = (1 + tau2*s)./(1 + tau1*s);

p.fG = f;
p.G = G;

M = 10000;
x = randn(1,M) + j*randn(1,M);
y = zeros(1,M);
for m=2:M,
  y(m) = a1*y(m-1) + b0*x(m) + b1*x(m-1);
end
p.H = fft(y)./fft(x);
p.fH = [0:length(y)-1]/length(y);

end





