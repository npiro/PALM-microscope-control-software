%/***********************************************************************
%
%   setMirrorSingleChannel(VAL,CHNUM)
%
%   sets mirror single channel
%
%   copyright (c) ADAPTICA 2009
%
%***********************************************************************/

function setMirrorSingleChannel(val, chn)

%fprintf('setting ch %d to: %f \n',chn, val);

if (calllib('mirrorDriverC', 'setMirrorSingleChannel', val, chn)==0)
    error('setMirrorSingleChannel: something went wrong');
end
