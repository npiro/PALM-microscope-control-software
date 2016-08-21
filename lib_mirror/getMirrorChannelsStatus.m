%/***********************************************************************
%
%   getMirrorChannelsStatus.m
%
%   matlab function for getting EUROPA Mirror Current Driver Vers.
%ZtoA
%
%   copyright (c) ADAPTICA 2009
%
%***********************************************************************/

function valArray=getMirrorChannelsStatus

% create libpointer for data exchange
v = ones(1,getNumMirrorChannels);
pv = libpointer('singlePtr', v);

calllib('mirrorDriverC', 'getMirrorChannelsStatus',pv);

% convert to array
valArray = get(pv, 'Value');