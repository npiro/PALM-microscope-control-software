   
%/***********************************************************************
%
%   getDriverVersion.m
%
%   matlab function for getting EUROPA Mirror Current Driver Vers. 
%
%   copyright (c) ADAPTICA 2009
%
%***********************************************************************/

function vers=getDriverVersion

loadlibrary mirrorDriverC mirrorDriverCDLL.h
vers=calllib('mirrorDriverC', 'getDriverVersion');

if (vers==-1)
    error('unable to get current driver version: not connected to mirror. ');
end