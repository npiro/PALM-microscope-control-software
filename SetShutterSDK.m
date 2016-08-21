function SetShutterSDK(mode)

if (strcmp(mode,'open'))
    modeIdx = 1;
elseif (strcmp(mode,'close'))
    modeIdx = 2; 
elseif (strcmp(mode,'auto'))
    modeIdx = 0;
else
    error('Invalid mode index');
end

ret = calllib('ATMCD32D','SetShutter',1, modeIdx, 0, 0);
if (ret ~= 20002)
    error('SetShutter failed');
end