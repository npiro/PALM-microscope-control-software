%/***********************************************************************
%
%   connectToMirror.m
%
%   matlab function for connecting to IO64/32 device
%   see manual for usage 
%
%   copyright (c) ADAPTICA 2009
%
%***********************************************************************/

function connectToMirror

% load mirrorDriver dll
if not(libisloaded('mirrorDriverC'))
    hfile = 'mirrorDriverCDLL.h';
    loadlibrary('mirrorDriverC', hfile)
    % shows lib functions
    libfunctions('mirrorDriverC','-full')
end

fprintf('calling mirrorDriverInit... \n');
calllib('mirrorDriverC','configIPAddress','192.168.0.1');
if (calllib('mirrorDriverC', 'mirrorDriverInit')==0)
    error('unable to connect to mirror ');
else
    fprintf('connected to mirror.\n');
end
