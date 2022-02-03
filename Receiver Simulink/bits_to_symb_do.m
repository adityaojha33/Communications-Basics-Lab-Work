function [s] = bits_to_symb_do(b);

% [s] = bits_to_symb_do(b);

s = sum(b(:).*2.^[0:length(b)-1].');
