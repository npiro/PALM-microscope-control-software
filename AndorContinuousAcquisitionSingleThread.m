function [img2] = AndorContinuousAcquisition(mmc,doplot)
%mmc.setExposure(50);
%mmc.setAutoShutter(true);
numberOfFrames = 100;
TurnOffAfterAcquisition = false;
if nargin < 2
    doplot = false;
elseif nargin < 1
    mmc = 0;
    %error('AndorSnapShot requires at least one argument. Syntax: AndorSnapShot(mmc,doplot)');
end
if ~libisloaded('ATMCD32D')
    loadlibrary('ATMCD32D.DLL','ATMCD32D.H');
end
val=calllib('ATMCD32D','Initialize','C:\Program Files\Andor SOLIS\Drivers');
pMin = libpointer('int32Ptr',0);
pMax = libpointer('int32Ptr',0);
calllib('ATMCD32D','GetTemperatureRange',pMin,pMax);
temp = -70;
calllib('ATMCD32D','SetTemperature',temp);
calllib('ATMCD32D','CoolerON');
actualTempPtr = libpointer('int32Ptr',0);

calllib('ATMCD32D','GetTemperature',actualTempPtr);
actualTemp = get(actualTempPtr,'Value');
while abs(actualTemp - temp) > 5
    display (['Current temperature: ', num2str(actualTemp)]);
    pause(.5);
    calllib('ATMCD32D','GetTemperature',actualTempPtr);
    actualTemp = get(actualTempPtr,'Value');
end
%mmc.snapImage();

%width=mmc.getImageWidth();
%height=mmc.getImageHeight();
%img2=typecast(img,'uint8');

%mmc.prepareSequenceAcquisition('Andor');
%mmc.initializeCircularBuffer;
%mmc.startSequenceAcquisition('Andor',100,100,true);


figure(1);
clf;


% Set Vertical speed to max
STemp = 0;
VSnumber = int32(0);
indexPtr = libpointer('int32Ptr',0);
speedPtr = libpointer('singlePtr',0);
calllib('ATMCD32D','GetNumberVSSpeeds',indexPtr);
index = indexPtr.Value;
for i=0:index-1
    calllib('ATMCD32D','GetVSSpeed',i, speedPtr);
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
index = indexPtr.Value;
for i=0:index-1
    calllib('ATMCD32D','GetHSSpeed',0,0,i,speedPtr);
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

% Set shutter mode to open

modeIdx = 1;
ret = calllib('ATMCD32D','SetShutter',1, modeIdx, 0, 0);
if (ret ~= 20002)
    error('SetShutter failed');
end

% Set some more camera paramters
xpixels = libpointer('int32Ptr',0);
ypixels = libpointer('int32Ptr',0);

calllib('ATMCD32D','GetDetector',xpixels,ypixels);
calllib('ATMCD32D','SetAcquisitionMode',5); % Kinetic acquisition mode
calllib('ATMCD32D','SetReadMode',4); % Image readout mode
calllib('ATMCD32D','SetADChannel',0);

LPix = 1;
RPix = xpixels.Value;
BPix = 1;
TPix = ypixels.Value;
binningx = 1;
binningy = 1;
totalpixels = (RPix-LPix+1)*(TPix-BPix+1)/binningx/binningy;
data = zeros(totalpixels,1);
im = libpointer('int32Ptr',data); % Image buffer



calllib('ATMCD32D','SetImage',binningx,binningy,LPix,RPix,BPix,TPix);
calllib('ATMCD32D','SetExposureTime',0.001);
calllib('ATMCD32D','SetTriggerMode',0); % Internal trigger
calllib('ATMCD32D','SetNumberAccumulations',1);
%calllib('ATMCD32D','SetNumberKinetics',100);
calllib('ATMCD32D','SetKineticCycleTime',0.5);
exposure = libpointer('singlePtr',0);
accumulate = libpointer('singlePtr',0);
kinetic = libpointer('singlePtr',0);
calllib('ATMCD32D','GetAcquisitionTimings',exposure,accumulate,kinetic);


accinit = libpointer('int32Ptr',0);
seriesInit = libpointer('int32Ptr',0);
acc = libpointer('int32Ptr',0);
series = libpointer('int32Ptr',0);
%calllib('ATMCD32D','PrepareAcquisition');
calllib('ATMCD32D','StartAcquisition');
i=0;
frame = int32(0);
%AndorWaitForFrameThread(frame,0)
calllib('ATMCD32D','GetAcquisitionProgress',accinit,seriesInit);
try
    go_on = true;
    display('Going into first loop')
    while (go_on)
        calllib('ATMCD32D','GetAcquisitionProgress',acc,series);
        display(num2str(acc.Value));
        display(num2str(series.Value));
        go_on = (series.Value == seriesInit.Value);
        frame = int32(0);
        %display('frame');
        %frame
        %display([num2str(acc.Value),' ',num2str(series.Value)]);
        
        %val=calllib('ATMCD32D','WaitForAcquisition');
        %display(['image: ',num2str(i),' ',num2str(val)]);
        %img = mmc.getLastImage;
        %calllib('ATMCD32D','GetMostRecentImage',im,totalpixels);
        %img2=reshape(im,[512,512]);
        %imshow(img2,[min(img2(:)),max(img2(:))]);
    end
    display('Getting out of first loop')
    go_on = true;
    tic;
    frameCounter = int32(0);
    status = int32(0);
    ret = calllib('ATMCD32D','GetAcquisitionProgress',acc,series);
    seriesPrevValue = series.Value;
    while go_on
        ret = calllib('ATMCD32D','GetAcquisitionProgress',acc,series);
        display(['series = ',num2str(series.Value),' at ',num2str(toc),' ms!',' Series prev = ',num2str(seriesPrevValue)]);
        if series.Value > seriesPrevValue;
            display(['Frame ',num2str(frameCounter),' captured at ',num2str(toc),' ms']);
            frameCounter = frameCounter + 1;
            ret=calllib('ATMCD32D','GetMostRecentImage',im,totalpixels);
            display(num2str(ret));
            img2=reshape(im.Value,[512,512]);
            plot(im.Value);
            seriesPrevValue = series.Value;
            tic;
        end
        go_on = (ret == 20002 && (series.Value - seriesInit.Value) < numberOfFrames);
        pause(.05);
    end
catch ME
    ME.message
    calllib('ATMCD32D','AbortAcquisition');
    %AndorWaitForFrameThread(0,1);
    calllib('ATMCD32D','SetShutter',1, 0, 0, 0); % Close shutter
    if (ret ~= 20002)
        error('Error: SetShutter failed');
    end
end
%AndorWaitForFrameThread(0,1);
calllib('ATMCD32D','SetShutter',1, 0, 0, 0); % Close shutter
if (ret ~= 20002)
    error('Error: SetShutter failed');
end
calllib('ATMCD32D','AbortAcquisition');

if (TurnOffAfterAcquisition)
    % Set everything off
    calllib('ATMCD32D','CoolerOFF');
    calllib('ATMCD32D','GetTemperature',actualTempPtr);
    actualTemp = get(actualTempPtr,'Value');
    while actualTemp < 0
        display (['Current temperature: ', num2str(actualTemp)]);
        pause(1);
        calllib('ATMCD32D','GetTemperature',actualTempPtr);
        actualTemp = get(actualTempPtr,'Value');
        
    end
    calllib('ATMCD32D','ShutDown');
end