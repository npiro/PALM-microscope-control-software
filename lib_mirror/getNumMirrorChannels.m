%/***********************************************************************
%
%   getNumMirrorChannels.m
%
%   get the number of channel
%
%   copyright (c) ADAPTICA 2009
%
%***********************************************************************/

function chnum=getNumMirrorChannels

chnum=calllib('mirrorDriverC', 'getNumMirrorChannels');

if (chnum==-1)
    error('not connected to mirror.')
end