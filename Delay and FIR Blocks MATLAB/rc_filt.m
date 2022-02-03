function [y] = rc_filt(x, p);

% [y] = rc_filt(x, p);
%
% Returns the spectrum of a root raised cosine filter.
%
% Inputs:
%	x	 Freq samples
%	p.beta	 Roll-off
%	p.fs	 Symbol rate
%	p.root	 0=normal 1=root

y = zeros(size(x));

T = 1/p.fs;
beta = p.beta;

f1 = (1-beta)/(2*T);
f2 = (1+beta)/(2*T);

idx = (x <= f1);
if any(idx),
  y(idx) = T;
end
idx = (x >= f1) & (x < f2);
if any(idx),
  y(idx) = T/2*(1+cos(pi*T/beta*(abs(x(idx))-(1-beta)/(2*T))));
end

if p.root,
  y = sqrt(y);
end
