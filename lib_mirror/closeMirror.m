% Close connection with IO32/64
%/***********************************************************************
%
%   closeMirror.m
%
%   matlab function for closing the mirror connection
%   see manual for usage 
%
%   copyright (c) ADAPTICA 2009
%
%***********************************************************************/

function closeMirror

if (calllib('mirrorDriverC', 'mirrorDriverClose')==0)
    unloadlibrary mirrorDriverC
    error('connection to mirror closed wrongly.');
else
    fprintf('connection successfully closed.\n');
end

% unload the dll library
unloadlibrary mirrorDriverC
