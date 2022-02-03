function [hw, f, Ha, Hi, win] = win_method(H_func, p, f_max, fs, M, wtype);

% [h, f, Ha, Hi, win] = win_method(H_func, p, fmax, fs, M, wtype);
%
% Creates a filter using the window method.
%
% Inputs:
%	H_func		User-supplied function that gives H(f, p)
%	p		Options to pass to the user function
%	f_max		Maximum integration frequency
%	fs		Sample rate
%	M		Number of filter taps (-1)
%	wtype		Window to use: 0=rect, 1=hamming
%                                    
%
% Outputs:
%	h		Time domain filter taps
%	f		Frequency samples used
%	Ha		Actual response of filter
%	Hi		Ideal response of filter
%	win		Window applied

% Response is real (H is symmetric)
op_real = 1;
op_lin_phase = 1;

% Get the frequency samples
K = 1000;
f = ([0:K-1]+0.5)/K*f_max;
w = 2*pi*f;

% Time samples
m = [0:M].';
om = ones(size(m));

% Evaluate the user function at the sample points
eval(sprintf('Hp = %s(f, p);', H_func));

% Get negative frequencies if necessary
if ~op_real,
  sprintf('Hm = %s(f, p);', H_func);
else
  Hm = conj(Hp);
end

% Get discrete frequencies
wd = w/fs;
dw = 2*pi*f_max/K/fs;

% Put in the delay (lin phase) to make causal.  
if (op_lin_phase),
  lp = exp(-j*wd*M/2);
else
  lp = ones(size(Hp));
end

% Do integration
hp = 1/(2*pi)*sum(((om*(lp.*Hp)).*exp(j*m*wd)).')*dw;
hm = 1/(2*pi)*sum(((om*(conj(lp).*Hm)).*exp(-j*m*wd)).')*dw;

h = (hp + hm).';

% Do window
if wtype == 0,
  win = ones(1,M+1).';
elseif (wtype == 1),
  % Hamming window
  win = 0.54 - 0.46*cos(2*pi*m/M);
else    
  error('Invalid window type');
end

hw = h.*win;

% Compute the response back in the frequency domain
Hi = Hp;

Ha = zeros(size(f));
for ii=1:length(f),
  Ha(ii) = sum(hw.*exp(j*2*pi*f(ii)/fs*m));
end

