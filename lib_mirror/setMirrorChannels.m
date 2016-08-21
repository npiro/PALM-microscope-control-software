%/***********************************************************************
%
%   setNumMirrorChannels.m
%   
%   set all mirror channels 
%
%   copyright (c) ADAPTICA 2009
%
%***********************************************************************/

function setMirrorChannels(vals)

if (calllib('mirrorDriverC', 'setMirrorChannels',vals)==0)
    error('setMirrorChannels: something wrong');
end
