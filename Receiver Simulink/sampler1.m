function [sys,x0,str,ts] = sampler1(t,x,u,flag);
% sampler1 - does a sample and hold.  Level sensitive.

switch flag
  
  %%%%%%%%%%%%%%%%%%
  % Initialization %
  %%%%%%%%%%%%%%%%%%
  case 0,                                              
    [sys,x0,str,ts] = mdlInitializeSizes;    

  %%%%%%%%%%%%%%%%%%%%%%%%%
  % Discrete State Update %
  %%%%%%%%%%%%%%%%%%%%%%%%%
  case 2,                                             
    sys = mdlUpdate(t,x,u);
  
  %%%%%%%%%%
  % Output %
  %%%%%%%%%%
  case 3,                                               
    sys = mdlOutputs(t,x,u);

  %%%%%%%%%%%%%
  % Terminate %
  %%%%%%%%%%%%%
  case 9,   
    sys = []; % do nothing

  case {'Start', 'CopyBlock', 'LoadBlock', 'DeleteBlock' },
    % sys = [1];

  otherwise,
    error(['unhandled flag = ',num2str(flag)]);
end

%
%==============================================================================
% mdlInitializeSizes
% Return the sizes, initial conditions, and sample times for the S-function
%==============================================================================
%
function [sys, x0, str, ts] = mdlInitializeSizes

%warning(['The S-function memory block, ''',gcb,''' should be ' ...
%         'replaced with the built-in memory block which can be ' ...
%         'found in the Simulink block library. Note, slupdate can be ', ...
%         'used to automatically update your block diagram.']);

sizes = simsizes;

sizes.NumContStates  = 0;
sizes.NumDiscStates  = 1;
sizes.NumOutputs     = 1;
sizes.NumInputs      = 2;
sizes.DirFeedthrough = 0;
sizes.NumSampleTimes = 1;    
    
sys = simsizes(sizes);    

x0  = 0;
str = [];    
ts  = [0 1];  % continuous sample time [period, offset]

%end mdlInitializeSizes

%
%=============================================================================
% mdlUpdate
% Handle discrete state updates, sample time hits, and major time step
% requirements.
%=============================================================================
%
function sys = mdlUpdate(t,x,u)

if (u(2) > 0.5),
  sys = u(1);
else
  sys = x;
end

%end mdlUpdate

%
%=============================================================================
% mdlOutputs
% Return the output vector for the S-function
%=============================================================================
%
function sys = mdlOutputs(t,x,u)

if (u(2) > 0.5),
  sys = u(1);
else
  sys = x;
end

%sys = x;

%end mdlOutputs
