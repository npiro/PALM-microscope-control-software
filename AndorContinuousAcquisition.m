function [img2] = AndorContinuousAcquisition(mmc,doplot)
%mmc.setExposure(50);
%mmc.setAutoShutter(true);
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
pMin = libpointer('int32Ptr');
pMax = libpointer('int32Ptr');
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




%im = zeros(512,512);%libpointer('int32Ptr',0); % Image buffer

xpixels = libpointer('int32Ptr',0);
ypixels = libpointer('int32Ptr',0);
exposure = libpointer('singlePtr',0);
accumulate = libpointer('singlePtr',0);
kinetic = libpointer('singlePtr',0);
calllib('ATMCD32D','GetDetector',xpixels,ypixels);
calllib('ATMCD32D','SetAcquisitionMode',3); % Kinetic acquisition mode
calllib('ATMCD32D','SetReadMode',4); % Image readout mode
calllib('ATMCD32D','SetADChannel',0);
LPix = 1;
RPix = xpixels.Value;
BPix = 1;
TPix = ypixels.Value;
binningx = 1;
binningy = 1;
xsize = (RPix-LPix+1)/binningx;
ysize = (TPix-BPix+1)/binningy;
%totalpixels = (RPix-LPix+1)*(TPix-BPix+1)/binningx/binningy;
totalpixels = xsize*ysize;
data = zeros(totalpixels,1);
im = libpointer('int32Ptr',data); % Image buffer
%totalpixels = xpixels.Value*ypixels.Value;
margin = 20;
fig=figure('position',[520 500 xsize+margin*2 ysize+margin*2],...
           'doublebuffer','off',...
           'backingstore','off');
           %,...
           %'menubar','none',...
           %...'toolbar','none',...
           %'tag','imagemovie');
  
axes('units','pixels',...
         'xlimmode','manual',...
         'ylimmode','manual',...
         'zlimmode','manual');%,...
         ...%'climmode','manual',...
         %'alimmode','manual',...
         %'layer','bottom',...
         %'position',[margin margin xsize ysize]);
imH=image(zeros(xsize,ysize),'erasemode','none');
calllib('ATMCD32D','SetImage',binningx,binningy,LPix,RPix,BPix,TPix);
calllib('ATMCD32D','SetExposureTime',0.01);
calllib('ATMCD32D','SetTriggerMode',0); % Internal trigger
calllib('ATMCD32D','SetNumberAccumulations',1);
calllib('ATMCD32D','SetNumberKinetics',100);
calllib('ATMCD32D','SetKineticCycleTime',0.05);
calllib('ATMCD32D','GetAcquisitionTimings',exposure,accumulate,kinetic);
exposure.Value
accumulate.Value
kinetic.Value




acc = libpointer('int32Ptr',0);
series = libpointer('int32Ptr',0);
calllib('ATMCD32D','PrepareAcquisition');
calllib('ATMCD32D','StartAcquisition');
i=0;
frame = int32(0);
AndorWaitForFrameThread(frame,0)
tic;
try
    while (AndorIsSequenceRunning)
        tic;
        while ~frame && toc < 1
            %display('no frame');
            pause(0.02);
        end
        if frame
            frame = int32(0);
            display('frame');
            calllib('ATMCD32D','GetAcquisitionProgress',acc,series);
        %frame
        %display([num2str(acc.Value),' ',num2str(series.Value)]);
       
        %val=calllib('ATMCD32D','WaitForAcquisition');
        %display(['image: ',num2str(i),' ',num2str(val)]);
        %img = mmc.getLastImage;
            ret=calllib('ATMCD32D','GetMostRecentImage',im,totalpixels);
            %display(num2str(ret));
            img2=reshape(im.Value,[xsize,ysize]);
            %plot(im);
            %mi=min(img2(:));
            %ma=max(img2(:));
            %imagesc(img2);
            set(imH,'cdata',img2);
            display(['New frame after:',num2str(toc)]);
            tic;
        end
    end
catch ME
    ME.message
    calllib('ATMCD32D','AbortAcquisition');
    AndorWaitForFrameThread(0,1);
    rethrow(ME);
end
AndorWaitForFrameThread(0,1);
if (TurnOffAfterAcquisition)
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