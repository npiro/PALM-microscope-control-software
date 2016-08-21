function SnapShot(hObject, eventdata, handles)
% hObject    handle to SnapShotButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%[x,y,w,h]=AdjustAndSetROI(hObject,handles);
Thorlabs = strcmp(handles.CameraTag,'Thorlabs');
Andor = strcmp(handles.CameraTag,'Andor');

%axes(handles.CameraAxis);
colormap(handles.CameraAxis,jet(256));
v = axis(handles.CameraAxis);

if (Thorlabs)
    FreezeVideo(handles.Camera);
    
    %axes(handles.CameraAxis);
    image(handles.ImageBuffer.image);
    %image(handles.ImageBuffer.image(1:w,1:h));
    
elseif Andor
    
    xrange = int32([ceil(v(3)) floor(v(4))]);
    yrange = int32([ceil(v(1)) floor(v(2))]);
    xbinning = 1;
    ybinning = 1;
    ExposureTime = handles.ExposureTime/1000;
    FramePeriod = 1/handles.FrameRate;
    
    if (~handles.Scanning || handles.FirstImageInScan)
        [xsize,ysize,ExposureTimeOut,AccumulateTimeOut,KineticCycleTimeOut]=AndorSetSnapShotAcquisitionSDK(xrange,yrange,xbinning,ybinning,ExposureTime,FramePeriod,hObject,handles);
        totalpixels = xsize*ysize;
        data = nan(totalpixels,1);
        imPtr = libpointer('int32Ptr',data); % Image buffer
        if handles.Scanning
            handles.xsize = xsize;
            handles.ysize = ysize;
            handles.imPtr = imPtr;
            handles.totalpixels = totalpixels;
            %handles.FirstImageInScan = false;
        end
    else
        if handles.Scanning
            xsize = handles.xsize;
            ysize = handles.ysize;
            totalpixels = handles.totalpixels;
            imPtr = handles.imPtr;
        end
    end
    ret=AndorSnapShotSDK(imPtr,totalpixels);
    if ~ret
        error('Error acquiring single image in function AndorSnapShotSDK');
    end
    img = zeros(512,512);
    img(xrange(1):xrange(2),yrange(1):yrange(2)) = reshape(imPtr.Value,xsize,ysize);
    handles.ImageBuffer.image = img;
    imgg0 = img(img>0);
    if (handles.Scanning && ~handles.FirstImageInScan)
        set(handles.imH,'cdata',img);
    else
        axes(handles.CameraAxis);
        handles.imH=imagesc(img,[min(imgg0),max(imgg0)]);
        %xlim(xrange(1:2)-1);
        %ylim(yrange(1:2)-1);
        
        axis off;
    end
end

if handles.CameraAxesUsed
    axis([yrange,xrange]); % ...to keep the current zoom condition.
    %axis([x,x+w,y,y+h]);
else
    handles.CameraAxesUsed = true;
end

guidata(hObject, handles);