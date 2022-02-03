function [y] = pw_lin(x, p);

% [y] = pw_lin(x, p);
%
% Does a piecewise linear response.
%    ____
%   /    \   
%  /      \
% /        \
% f1 f2 f3 f4
%
% Inputs:
%	x	 Freq samples
%	p.x1-x4  Transition points

y = zeros(size(x));

x1 = p.x1;
x2 = p.x2;
x3 = p.x3;
x4 = p.x4;

idx = (x >= x1) & (x < x2);
if any(idx),
  y(idx) = (x(idx)-x1)/(x2-x1);
end
idx = (x >= x2) & (x < x3);
if any(idx),
  y(idx) = 1;
end
idx = (x >= x3) & (x < x4);
if any(idx),
  y(idx) = (x4-x(idx))/(x4-x3);
end

