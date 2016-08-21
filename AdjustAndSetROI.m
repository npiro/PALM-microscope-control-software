function [xN,yN,wN,hN]=AdjustAndSetROI(hObject,handles)
v = int32(axis(handles.CameraAxis));
xN = v(1);
yN = v(3);
wN = v(2)-v(1);
hN = v(4)-v(3);
if (mod(xN,16))
    xN = xN-mod(xN,16);
end
if (mod(yN,2))
    yN = yN-1;
end
if (mod(wN,16))
    wN = wN-mod(wN,16)+16;
end
if (mod(hN,2))
    hN = hN+1;
end
v=[xN,xN+wN,yN,yN+hN];
axis(v);

SetAOI(handles.Camera,xN,yN,wN,hN);
handles.AOIx = xN;
handles.AOIy = yN;
handles.AOIw = wN;
handles.AOIh = hN;
guidata(hObject,handles);