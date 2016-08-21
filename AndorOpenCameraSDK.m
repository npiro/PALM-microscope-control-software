function AndorOpenCameraSDK

if ~libisloaded('ATMCD32D')
    loadlibrary('ATMCD32D.DLL','ATMCD32D.H');
end
ret=calllib('ATMCD32D','Initialize','C:\Program Files\Andor SOLIS\Drivers');
if ret ~= 20002
   error('Error initializing camera') ;
end
% Set Vertical speed to max
STemp = 0;
VSnumber = int32(0);
indexPtr = libpointer('int32Ptr',0);
speedPtr = libpointer('singlePtr',0);
ret=calllib('ATMCD32D','GetNumberVSSpeeds',indexPtr);
if ret ~= 20002
   error('Error getting number of VS Speeds') ;
end
index = indexPtr.Value;
for i=0:index-1
    calllib('ATMCD32D','GetVSSpeed',i, speedPtr);
    if ret ~= 20002
        error('Error getting VS Speed') ;
    end
    speed = speedPtr.Value;
    if (speed > STemp)
        STemp = speed;
        VSnumber = i;
    end
end

ret = calllib('ATMCD32D','SetVSSpeed',VSnumber);

if (ret ~= 20002)
    error('SetVSSpeed failed');
end

% Set Horizontal Speed to max
STemp = 0;
HSnumber = int32(0);

calllib('ATMCD32D','GetNumberHSSpeeds',0,0,indexPtr);
if ret ~= 20002
   error('Error getting number of HS Speeds') ;
end
index = indexPtr.Value;
for i=0:index-1
    calllib('ATMCD32D','GetHSSpeed',0,0,i,speedPtr);
    if ret ~= 20002
        error('Error getting HS Speed') ;
    end
    speed = speedPtr.Value;
    if (speed > STemp)
        STemp = speed;
        HSnumber = i;
    end
end
ret = calllib('ATMCD32D','SetHSSpeed',0,HSnumber);
if (ret ~= 20002)
    error('SetHSSpeed failed');
end



AndorSetTemperatureSDK(-70,true);
% Set shutter mode to open

modeIdx = 1;
ret = calllib('ATMCD32D','SetShutter',1, modeIdx, 0, 0);
if (ret ~= 20002)
    error('SetShutter failed');
end

calllib('ATMCD32D','SetEMGainMode',3);
