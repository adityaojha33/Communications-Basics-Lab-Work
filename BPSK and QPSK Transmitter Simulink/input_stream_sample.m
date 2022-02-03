function [d1] = input_stream_sample(time, data, period, width);

% [d1] = input_stream_sample(time, data, period, width);

Ne = size(data,2);
si = floor(time/period)+1;
if (si <= Ne),
  d1 = double(data(:,si));
else
  d1 = zeros(width,1);
end
%fprintf('t=%g d=',time);
%fprintf('%d ', d1);
%fprintf('\n');
