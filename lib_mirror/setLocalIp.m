%/***********************************************************************
%
%   setlocalIp.m
%   
%   set the local ip
%
%   copyright (c) ADAPTICA 2009
%
%***********************************************************************/

function setLocalIp(vals)

if (calllib('mirrorDriverC', 'configIPAddress',vals)==0)
    error('configIPAddress: something wrong');
end
