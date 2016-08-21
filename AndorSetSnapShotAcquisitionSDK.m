function [xsize,ysize,ExposureTimeOut,AccumulateTimeOut,KineticCycleTimeOut]=AndorSetSnapShotAcquisitionSDK(xrange,yrange,xbinning,ybinning,ExposureTime,FramePeriod,hObject,handles)

if (exist('hObject','var') && exist('handles','var'))
    calllib('ATMCD32D','SetFrameTransferMode',0);
    [xsize,ysize,ExposureTimeOut,AccumulateTimeOut,KineticCycleTimeOut]=SetCameraSettingsSDK(xrange,yrange,xbinning,ybinning,1,4,0,ExposureTime,FramePeriod,[],1,1,hObject,handles);
else
    calllib('ATMCD32D','SetFrameTransferMode',0);
    [xsize,ysize,ExposureTimeOut,AccumulateTimeOut,KineticCycleTimeOut]=SetCameraSettingsSDK(xrange,yrange,xbinning,ybinning,1,4,0,ExposureTime,FramePeriod,[],1,1);
end