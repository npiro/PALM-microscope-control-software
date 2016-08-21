%/***********************************************************************
%
%   getLocalIp.m
%
%   matlab function for getting the local server IP to which the system
%   connect
%
%   copyright (c) ADAPTICA 2009
%
%***********************************************************************/

function ip=getLocalIp()

ip=calllib('mirrorDriverC', 'getServerIPAddress');
end
