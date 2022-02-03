function [state_out, y] = fir(state_in, x)
% [state_out, y] = fir(state_in, x);

% Executeing the FIR block.

% Inputs:
% state_in Input state
% x Samples to process
% Outputs:
% state_out Output state
% y Processed samples

% Getting state
s = state_in;

% Moving of samples into tail of buffer
for ii = 0: s.Ns - 1
    % Store a sample
    s.buff(s.n_t+1) = x(ii+1);
    % Incrementing index (circular)
    s.n_t = bitand(s.n_t+1, s.Mmask);
    s.ptr = bitand(s.n_t+s.Mmask, s.Mmask);
    sum = 0.0;
    for j = 0:length(s.h)-1
        sum = sum + s.buff(s.ptr+1)*s.h(j+1);
        s.ptr = bitand(s.ptr+s.Mmask, s.Mmask);
    end
    y(ii+1) = sum;
end

% Filter samples and move into output
% Return updated state
state_out = s;