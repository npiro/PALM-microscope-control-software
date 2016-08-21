function [xsize,ysize,ExposureTimeOut,AccumulateTimeOut,KineticCycleTimeOut]=AndorSetContinuousAcquisitionSDK(xrange,yrange,xbinning,ybinning,ExposureTime,FramePeriod,hObject,handles)
if (exist('hObject','var') && exist('handles','var'))
    [xsize,ysize,ExposureTimeOut,AccumulateTimeOut,KineticCycleTimeOut]=SetCameraSettingsSDK(xrange,yrange,xbinning,ybinning,5,4,0,ExposureTime,FramePeriod,[],[],[],hObject,handles);
else
    [xsize,ysize,ExposureTimeOut,AccumulateTimeOut,KineticCycleTimeOut]=SetCameraSettingsSDK(xrange,yrange,xbinning,ybinning,5,4,0,ExposureTime,FramePeriod,[],[],[]);
end