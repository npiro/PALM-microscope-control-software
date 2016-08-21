function [xsize,ysize,ExposureTimeOut,AccumulateTimeOut,KineticCycleTimeOut]=...
            SetCameraSettingsSDK(xrange,yrange,xbinning,ybinning,...
               AcquisitionMode,ReadMode,ADChannel,ExposureTime,KineticCycleTime,TriggerMode,...
               NumberAccumulations,NumberKinetics,hObject,handles)
           

% Set acquisition parameters. For a standard kinetic acquisition, call
% SetCameraSettingsSDK([],[],1,1,3,4,0,exposure time,frame period time,[],[],number of frames)

xpixels = libpointer('int32Ptr',0);
ypixels = libpointer('int32Ptr',0);
exposure = libpointer('singlePtr',0);
accumulate = libpointer('singlePtr',0);
kinetic = libpointer('singlePtr',0);
calllib('ATMCD32D','GetDetector',xpixels,ypixels);
if ~isempty(AcquisitionMode) 
    calllib('ATMCD32D','SetAcquisitionMode',AcquisitionMode); % 3 for Kinetic acquisition mode
end
if ~isempty(ReadMode) 
    calllib('ATMCD32D','SetReadMode',ReadMode); % 4: Image readout mode
end
if ~isempty(ADChannel)
    calllib('ATMCD32D','SetADChannel',ADChannel); % 0: default
end
if ~isempty(xrange)
    LPix = xrange(1); % LPix = 1;
    RPix = xrange(2); % xpixels.Value;
else
    LPix = 1;
    RPix = xpixels.Value;
end
if ~isempty(yrange)
    BPix = yrange(1); % 1;
    TPix = yrange(2); % ypixels.Value;
else
    BPix = 1;
    TPix = ypixels.Value;
end
if isempty(xbinning)
    xbinning = 1;
end
if isempty(ybinning)
	ybinning = 1;
end
xsize = (RPix-LPix+1)/xbinning;
ysize = (TPix-BPix+1)/ybinning;
%totalpixels = (RPix-LPix+1)*(TPix-BPix+1)/binningx/binningy;
totalpixels = xsize*ysize;
data = zeros(totalpixels,1);
im = libpointer('int32Ptr',data); % Image buffer

if (exist('handles','var'))
    handles.imageBufferPtr = im;
    guidata(hObject,handles); % Save image buffer to handles 
end
%totalpixels = xpixels.Value*ypixels.Value;
margin = 20;


calllib('ATMCD32D','SetImage',xbinning,ybinning,LPix,RPix,BPix,TPix);
if ~isempty(ExposureTime)
    calllib('ATMCD32D','SetExposureTime',ExposureTime);
end
if ~isempty(TriggerMode)
	calllib('ATMCD32D','SetTriggerMode',TriggerMode); 
else
    calllib('ATMCD32D','SetTriggerMode',0); % Default: Internal trigger
end
if ~isempty(NumberAccumulations)
    calllib('ATMCD32D','SetNumberAccumulations',NumberAccumulations); % Default 1
else
    calllib('ATMCD32D','SetNumberAccumulations',1);
end
if ~isempty(NumberKinetics)
    calllib('ATMCD32D','SetNumberKinetics',NumberKinetics);
end
if ~isempty(KineticCycleTime)
    calllib('ATMCD32D','SetKineticCycleTime',KineticCycleTime);
end

calllib('ATMCD32D','GetAcquisitionTimings',exposure,accumulate,kinetic);

ExposureTimeOut=exposure.Value;
AccumulateTimeOut=accumulate.Value;
KineticCycleTimeOut=kinetic.Value;