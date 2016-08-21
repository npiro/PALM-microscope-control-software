%/***********************************************************************
%
%   getMirrorSingleChannelStatus.m
%
%   gets the status of a single channel
%
%   copyright (c) ADAPTICA 2009
%
%***********************************************************************/

function val=getMirrorSingleChannelStatus(chnum)

val=calllib('mirrorDriverC', 'getMirrorSingleChannelStatus',chnum);
