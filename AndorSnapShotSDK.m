function [ret] = AndorSnapShotSDK(imPtr,totalpixels)
% Take a single image with the current settings (see
% AndorSetSnapShotAcquisition). Provide the pointer to the image buffer and
% the total number of pixels (xsize*ysize) as arguments.
timeout = 5;

calllib('ATMCD32D','StartAcquisition');
tStart=tic; % Start timer
timeout = false; 
while (AndorIsSequenceRunning && ~timeout)
    pause (0.01);
    timeout = (toc(tStart) < timeout); % Get out of here if elapsed time is higher than TIMEOUT seconds
end
if timeout
    ret = false;
else
    %display(num2str(toc(tStart)));
    ret0=calllib('ATMCD32D','GetAcquiredData',imPtr,totalpixels);
    if ret0 == 20002
        ret = true;
    else
        ret = false;
    end
end

