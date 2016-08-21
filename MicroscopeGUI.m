


function varargout = MicroscopeGUI(varargin)
% MICROSCOPEGUI MATLAB code for MicroscopeGUI.fig
%      MICROSCOPEGUI, by itself, creates a new MICROSCOPEGUI or raises the existing
%      singleton*.
%
%      H = MICROSCOPEGUI returns the handle to a new MICROSCOPEGUI or the handle to
%      the existing singleton*.
%
%      MICROSCOPEGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MICROSCOPEGUI.M with the given input arguments.
%
%      MICROSCOPEGUI('Property','Value',...) creates a new MICROSCOPEGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MicroscopeGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MicroscopeGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MicroscopeGUI

% Last Modified by GUIDE v2.5 02-Feb-2012 15:45:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @MicroscopeGUI_OpeningFcn, ...
    'gui_OutputFcn',  @MicroscopeGUI_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before MicroscopeGUI is made visible.
function MicroscopeGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MicroscopeGUI (see VARARGIN)

%handles.ProgressBar = uiwaitbar([250 332 200 20]);
% Choose default command line output for MicroscopeGUI
handles.output = hObject;

% Define Zernike mode amplitudes array
handles.StepSize = 5;
handles.RangeSize = 100;
handles.amplitudes = zeros(15,1);
handles.VideoCapture = false;
global VideoCapture;
VideoCapture = false;
handles.VideoThreadExists = false;
handles.CameraAxesUsed = false;
handles.ContinousScan = false;
handles.Scanning = false;
handles.EMGainOn = false;
handles.CameraTag = 'Andor';
handles.OptimizeTag = 'Intensity';
TickHandles = [handles.ScanDefocus,handles.ScanAstigmatism,handles.ScanAstigmatism45,handles.ScanTiltX,handles.ScanTiltY,handles.ScanComaX,handles.ScanComaY,handles.ScanSpherical,handles.ScanTrefoil,handles.ScanTrefoil45,handles.ScanSecondAstigmatism,handles.ScanTrefoil135,handles.ScanTrefoil90];
ControlHandles = [handles.DefocusControl,handles.AstigmatismControl,handles.Astigmatism45Control,handles.TiltXControl,handles.TiltYControl,handles.ComaXControl,handles.ComaYControl,handles.SphericalControl,handles.TrefoilControl,handles.Trefoil45Control,handles.SecondAstigmatismControl,handles.Trefoil135Control,handles.Trefoil90Control];
ValueHandles = [handles.DefocusValue,handles.AstigmatismValue,handles.Astigmatism45Value,handles.TiltXValue,handles.TiltYValue,handles.ComaXValue,handles.ComaYValue,handles.SphericalValue,handles.TrefoilValue,handles.Trefoil45Value,handles.SecondAstigmatismValue,handles.Trefoil135Value,handles.Trefoil90Value];
ModeNumbers = [ModeNumber.Defocus,ModeNumber.Astigmatism,ModeNumber.Astigmatism45,ModeNumber.TiltX,ModeNumber.TiltY,ModeNumber.ComaX,ModeNumber.ComaY,ModeNumber.Spherical,ModeNumber.Trefoil,ModeNumber.Trefoil45,ModeNumber.Astigmatism2,ModeNumber.Astigmatism245,ModeNumber.Trefoil135,ModeNumber.Trefoil90];

%TickHandles = [handles.ScanDefocus,handles.ScanAstigmatism,handles.ScanTiltX,handles.ScanTiltY,handles.ScanComaX,handles.ScanComaY,handles.ScanSpherical];
%ControlHandles = [handles.DefocusControl,handles.AstigmatismControl,handles.TiltXControl,handles.TiltYControl,handles.ComaXControl,handles.ComaYControl,handles.SphericalControl];
%ValueHandles = [handles.DefocusValue,handles.AstigmatismValue,handles.TiltXValue,handles.TiltYValue,handles.ComaXValue,handles.ComaYValue,handles.SphericalValue];
%ModeNumbers=[ModeNumber.Defocus,ModeNumber.Astigmatism,ModeNumber.TiltX,ModeNumber.TiltY,ModeNumber.ComaX,ModeNumber.ComaY,ModeNumber.Spherical];

% Load mirror data and save it in handles structure
load('zernCoeffs.mat');
handles.AtoZ = AtoZ;
handles.PANarray = PANarray;
handles.ZtoA = ZtoA;
handles.AtoZNeg = AtoZNeg;
handles.ZtoANeg = ZtoANeg;

handles.ControlHandles = ControlHandles;
handles.ValueHandles = ValueHandles;
handles.TickHandles = TickHandles;
handles.ModeNumbers = ModeNumbers;
handles.FrameRate=get(handles.FrameRateControl,'Value');
handles.ExposureTime=get(handles.ExposureTimeControl,'Value');
set(handles.FrameRateValue,'String',num2str(handles.FrameRate));
set(handles.ExposureTimeValue,'String',num2str(handles.ExposureTime));
SetTotalPointsToScan(hObject,handles);
set(handles.StepSizeValue,'String',num2str(handles.StepSize));
set(handles.RangeSizeValue,'String',num2str(handles.RangeSize));

handles.hPiezo1=handles.activex2;
handles.hPiezo1.StartCtrl;
handles.hPiezo2=handles.activex3;
handles.hPiezo2.StartCtrl;
handles.hPiezo3=handles.activex4;
handles.hPiezo3.StartCtrl;

handles.P =1;
handles.I=1;
handles.Int = 0;% Set integral part of PI contoler to 0

% Register event listener for CameraAxis to monitor for zoom changes.
%hProp = findprop(handles.CameraAxis,'XLim');  % a schema.prop object
%handles.hListener = handle.listener(hhSlider,hProp,'PropertyPostSet',@CameraAxisZoomCallback);

%set(hObject,'doublebuffer','off');
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MicroscopeGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MicroscopeGUI_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in InitMirror.
function InitMirror_Callback(hObject, eventdata, handles)
% hObject    handle to InitMirror (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
initMirror;

% --- Executes on button press in CloseMirrorButton.
function CloseMirrorButton_Callback(hObject, eventdata, handles)
% hObject    handle to CloseMirrorButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
closeMirror;

% --- Executes on button press in OpenCamera.
function OpenCamera_Callback(hObject, eventdata, handles)
% hObject    handle to OpenCamera (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if strcmp(handles.CameraTag,'Thorlabs')
    [handles.Camera handles.ImageBuffer] = OpenCamera;
elseif strcmp(handles.CameraTag,'Andor')
    AndorOpenCameraSDK;
    handles.ShutterOpen = true;
end
guidata(hObject, handles);


% --- Executes on button press in CloseCameraButton.
function CloseCameraButton_Callback(hObject, eventdata, handles)
% hObject    handle to CloseCameraButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if strcmp(handles.CameraTag,'Thorlabs')
    ExitCamera(handles.Camera);
elseif strcmp(handles.CameraTag,'Andor')
    AndorCloseCameraSDK();
end

% --- Executes on button press in SetMirrorShape.

function SetMirrorShape_Callback(hObject, eventdata, handles)
% hObject    handle to SetMirrorShape (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global VideoCapture;
amplitudes = handles.amplitudes/100;
amplitudes*100
isplot = true;
setMirrorShapeInZernBasis(amplitudes,isplot,handles.ShapeGraphAxis,handles.MirrorChannelAxis,handles);
if ~VideoCapture
    SnapShotButton_Callback(handles.SnapShotButton, eventdata, handles);
end


% --- Executes on slider movement.
function PistonControl_Callback(hObject, eventdata, handles)
% hObject    handle to PistonControl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
value=get(hObject,'Value');
handles.amplitudes(ModeNumber.Piston) = double(value);
set(handles.PistonValue,'String',num2str(value));
guidata(hObject, handles);
SetMirrorShape_Callback(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function PistonControl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PistonControl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function PistonValue_Callback(hObject, eventdata, handles)
% hObject    handle to PistonValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of PistonValue as text
%        str2double(get(hObject,'String')) returns contents of PistonValue as a double
set(handles.PistonControl,'Value',str2double(get(hObject,'String')));
PistonControl_Callback(handles.PistonControl, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function PistonValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PistonValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on slider movement.
function DefocusControl_Callback(hObject, eventdata, handles)
% hObject    handle to DefocusControl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
value=get(hObject,'Value');
handles.amplitudes(ModeNumber.Defocus) = double(value);
set(handles.DefocusValue,'String',num2str(value));
guidata(hObject, handles);
SetMirrorShape_Callback(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function DefocusControl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DefocusControl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

set(hObject,'Min',-200);
set(hObject,'Max',200);
% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function AstigmatismControl_Callback(hObject, eventdata, handles)
% hObject    handle to AstigmatismControl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
value=get(hObject,'Value');
handles.amplitudes(ModeNumber.Astigmatism) = double(value);
set(handles.AstigmatismValue,'String',num2str(value));
guidata(hObject, handles);
SetMirrorShape_Callback(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function AstigmatismControl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AstigmatismControl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject,'Min',-300);
set(hObject,'Max',300);
% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in VideoToggle.
function VideoToggle_Callback(hObject, eventdata, handles)
% hObject    handle to VideoToggle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%handles = guidata(hObject);
global VideoCapture;
VideoCapture = ~VideoCapture;
%VideoCapture = handles.VideoCapture
%handles.VideoCapture = ~VideoCapture;

%guidata(hObject, handles);

%VideoCapture2 = handles.VideoCapture
axes(handles.CameraAxis);
colormap(handles.CameraAxis,jet(256));
%set(handles.CameraAxis, 'XLimMode', 'manual', 'YLimMode', 'manual');
frame = int32(0);

Thorlabs = strcmp(handles.CameraTag,'Thorlabs');
Andor = strcmp(handles.CameraTag,'Andor');
%if (handles.VideoCapture)
if (VideoCapture)
    set(handles.VideoToggle,'String','Stop video');
    if Thorlabs
        CaptureVideo(handles.Camera);
        VideoModeThread(handles.Camera,frame,0); % Create thread and video event handler
    elseif Andor

        AndorWaitForFrameThread(frame,0); % Create thread and video event handler
        FramePeriod = 1/handles.FrameRate;
        v = axis(handles.CameraAxis)
        
        xrange = int32([ceil(v(3)) floor(v(4))]);
        yrange = int32([ceil(v(1)) floor(v(2))]);
        if abs(xrange(1)-xrange(2)) == 1 && abs(yrange(1)-yrange(2)) == 1
            xrange = [1 512];
            yrange = [1 512];
        end
        [xsize,ysize,ExposureTimeOut,AccumulateTimeOut,KineticCycleTimeOut]=AndorSetContinuousAcquisitionSDK(xrange,yrange,1,1,handles.ExposureTime/1000,FramePeriod,hObject,handles)
        totalpixels = xsize*ysize;
        data = zeros(totalpixels,1);
        im = libpointer('int32Ptr',data); % Image buffer
        AndorStartAcquisitionSDK();
        
    end
    handles.VideoThreadExists = 1;
    
    
    %end
else
    set(handles.VideoToggle,'String','Start video');
    if strcmp(handles.CameraTag, 'Thorlabs')
        disp('Thorlabs stop');
        VideoModeThread(handles.Camera,frame,1); % Stop event handler
        StopCaptureVideo(handles.Camera); % Stop continuous video
        
        %disp('Calling VideoModeThread with 1');
        
    elseif strcmp(handles.CameraTag, 'Andor')
        AndorWaitForFrameThread(0,1); % Destroy thread
        AndorAbortAcquisitionSDK(); % Stop continuous acquisition
    end
    handles.VideoThreadExists = false;
    
    %end
end
%guidata(hObject, handles);
firstframe = true;
tic;
framecount = 0;

%while (handles.VideoCapture) % Wait for the frame variable to be changed
while (VideoCapture)
    % within the C++ mex function VideoModeThread
    % which runs an independent thread monitoring
    % camera frame capture events.
    if (~frame)
        pause(.02);
        %handles = guidata(hObject);
        %VCinFrame=handles.VideoCapture
        %display('no frame yet');
    else
        framecount = framecount + 1;
        if mod(framecount,100) == 0
            display(['Frames per second:',num2str(100/toc)]);
            tic;
            %VC = handles.VideoCapture;
            %display(VC);
        end
        %a = axis; % These strange operations are done...
        if firstframe
            if (Thorlabs)
                imH=image(handles.ImageBuffer.image);
                
            elseif (Andor)
                AndorGetLastImage(im,totalpixels);
                img = zeros(512,512);
                img(xrange(1):xrange(2),yrange(1):yrange(2)) = reshape(im.Value,xsize,ysize);
                imgg0 = img(img>0);
                %img=reshape(im.Value,xsize,ysize);
                imH=imagesc(img,[min(imgg0(:)),max(imgg0(:))]);
                %set(handles.CameraAxis,'CLimMode','auto');
            end
            firstframe = false;
        else
            if (Thorlabs)
                set(imH,'cdata',handles.ImageBuffer.image);
                
            elseif (Andor)
                AndorGetLastImage(im,totalpixels);
                img(xrange(1):xrange(2),yrange(1):yrange(2)) = reshape(im.Value,xsize,ysize);
                %imgg0 = img(img>0);
                %img=reshape(im.Value,xsize,ysize);
                %imH=imagesc(img,[min(imgg0(:)),max(imgg0(:))]);
                set(imH,'cdata',img);
            end
            drawnow;
        end
        %if handles.CameraAxesUsed
        axis([yrange,xrange]);
        %axis(a); % ...to keep the current zoom condition.
        %end
        handles = guidata(hObject);
        handles.CameraAxesUsed = true;
        guidata(hObject, handles);
        axis off;
        frame = 0;
    end
    
end
%handles = guidata(hObject);
%handles.VideoCapture = false;
%VC = handles.VideoCapture;
%display(VC);
%guidata(hObject,handles);

% --- Executes on button press in SnapShotButton.
function SnapShotButton_Callback(hObject, eventdata, handles)
% hObject    handle to SnapShotButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%[x,y,w,h]=AdjustAndSetROI(hObject,handles);
SnapShot(hObject, eventdata, handles);



function DefocusValue_Callback(hObject, eventdata, handles)
% hObject    handle to DefocusValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DefocusValue as text
%        str2double(get(hObject,'String')) returns contents of DefocusValue as a double
set(handles.DefocusControl,'Value',str2double(get(hObject,'String')));
guidata(hObject,handles);

DefocusControl_Callback(handles.DefocusControl, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function DefocusValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DefocusValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'String','0');





function AstigmatismValue_Callback(hObject, eventdata, handles)
% hObject    handle to AstigmatismValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of AstigmatismValue as text
%        str2double(get(hObject,'String')) returns contents of AstigmatismValue as a double
set(handles.AstigmatismControl,'Value',str2double(get(hObject,'String')));
guidata(hObject,handles);
AstigmatismControl_Callback(handles.AstigmatismControl, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function AstigmatismValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AstigmatismValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'String','0');





% --- Executes on slider movement.
function TiltXControl_Callback(hObject, eventdata, handles)
% hObject    handle to TiltXControl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
value=get(hObject,'Value');
handles.amplitudes(ModeNumber.TiltX) = double(value);
set(handles.TiltXValue,'String',num2str(value));
guidata(hObject, handles);
SetMirrorShape_Callback(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function TiltXControl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TiltXControl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
set(hObject,'Min',-200);
set(hObject,'Max',200);
guidata(hObject, handles);

% --- Executes on slider movement.
function TiltYControl_Callback(hObject, eventdata, handles)
% hObject    handle to TiltYControl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
value=get(hObject,'Value');
handles.amplitudes(ModeNumber.TiltY) = double(value);
set(handles.TiltYValue,'String',num2str(value));
guidata(hObject, handles);
SetMirrorShape_Callback(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function TiltYControl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TiltYControl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
set(hObject,'Min',-200);
set(hObject,'Max',200);
guidata(hObject, handles);

function ComaYValue_Callback(hObject, eventdata, handles)
% hObject    handle to ComaYValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ComaYValue as text
%        str2double(get(hObject,'String')) returns contents of ComaYValue as a double
set(handles.ComaYControl,'Value',str2double(get(hObject,'String')));
guidata(hObject,handles);
ComaYControl_Callback(handles.ComaYControl, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function ComaYValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ComaYValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function TiltYValue_Callback(hObject, eventdata, handles)
% hObject    handle to TiltYValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TiltYValue as text
%        str2double(get(hObject,'String')) returns contents of TiltYValue as a double
set(handles.TiltYControl,'Value',str2double(get(hObject,'String')));
guidata(hObject,handles);
TiltYControl_Callback(handles.TiltYControl, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function TiltYValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TiltYValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function ComaXControl_Callback(hObject, eventdata, handles)
% hObject    handle to ComaXControl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
value=get(hObject,'Value');
handles.amplitudes(ModeNumber.ComaX) = double(value);
set(handles.ComaXValue,'String',num2str(value));
guidata(hObject, handles);
SetMirrorShape_Callback(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function ComaXControl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ComaXControl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function ComaYControl_Callback(hObject, eventdata, handles)
% hObject    handle to ComaYControl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
value=get(hObject,'Value');
handles.amplitudes(ModeNumber.ComaY) = double(value);
set(handles.ComaYValue,'String',num2str(value));
guidata(hObject, handles);
SetMirrorShape_Callback(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function ComaYControl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ComaYControl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function ComaXValue_Callback(hObject, eventdata, handles)
% hObject    handle to ComaXValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ComaXValue as text
%        str2double(get(hObject,'String')) returns contents of ComaXValue as a double
set(handles.ComaXControl,'Value',str2double(get(hObject,'String')));
guidata(hObject,handles);
ComaXControl_Callback(handles.ComaXControl, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function ComaXValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ComaXValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function TiltXValue_Callback(hObject, eventdata, handles)
% hObject    handle to TiltXValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TiltXValue as text
%        str2double(get(hObject,'String')) returns contents of TiltXValue as a double
set(handles.TiltXControl,'Value',str2double(get(hObject,'String')));
guidata(hObject,handles);
TiltXControl_Callback(handles.TiltXControl, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function TiltXValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TiltXValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
try
    ExitCamera(handles.Camera);
    closeMirror;
    frame = int32(0);
    VideoModeThread(handles.Camera,frame,1);
catch ME
end
delete(hObject);



function SphericalValue_Callback(hObject, eventdata, handles)
% hObject    handle to SphericalValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SphericalValue as text
%        str2double(get(hObject,'String')) returns contents of SphericalValue as a double
set(handles.SphericalControl,'Value',str2double(get(hObject,'String')));
guidata(hObject,handles);
SphericalControl_Callback(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function SphericalValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SphericalValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function SphericalControl_Callback(hObject, eventdata, handles)
% hObject    handle to SphericalControl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
value=get(hObject,'Value');
handles.amplitudes(ModeNumber.Spherical) = double(value);
set(handles.SphericalValue,'String',num2str(value));
guidata(hObject, handles);

SetMirrorShape_Callback(handles.SetMirrorShape, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function SphericalControl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SphericalControl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in SimpleOptimize.
function SimpleOptimize_Callback(hObject, eventdata, handles)
% hObject    handle to SimpleOptimize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global VideoCapture;
HalfScanRange = handles.RangeSize/2; % Half of the size of the scan range
step = handles.StepSize; % Step size
PointsInSingleMode= int32(2*HalfScanRange/step + 1); % Total number of amplitude points to scan for each mode
TickHandles = handles.TickHandles;
AberrationControlHandles = handles.ControlHandles;
ModesIndeces = handles.ModeNumbers;

Andor = strcmp(handles.CameraTag,'Andor');
Thorlabs = strcmp(handles.CameraTag,'Thorlabs');
OptimizeIntensity = strcmp(handles.OptimizeTag,'Intensity')
OptimizeRadialSymmetry = strcmp(handles.OptimizeTag,'RadialSymmetry');
OptimizeSharpness = strcmp(handles.OptimizeTag,'Sharpness');
if (VideoCapture)
    display('Video was on');
    VideoWasOn = true;
    VideoToggle_Callback(hObject, eventdata, handles);
    %VideoCapture = false;
    %guidata(hObject, handles);
    
else
    VideoWasOn = false;
end

NumModes = length(TickHandles);
CentralAmplitudes = zeros(1,length(handles.amplitudes));

for i=1:NumModes
    ModesToScan(i)=get(TickHandles(i),'Value');
    CentralValues(i)=get(AberrationControlHandles(i),'Value');
    
    if (ModesToScan(i))
        AmplitudeValues(i,:) = CentralValues(i)-HalfScanRange:step:CentralValues(i)+HalfScanRange;
    else
        AmplitudeValues(i,:) = zeros(1,PointsInSingleMode)+CentralValues(i);
    end
end

TotalModesToScan = sum(ModesToScan);
ModesToScanIndeces=find(ModesToScan);

% Set ModeAmplitudes array to the values specified in the GUI

ModeAmplitudes = CentralValues;

if Thorlabs % Thorlabs camera used
    [x,y,width,height]=GetAOI(handles.Camera);
    
    [xN,yN,wN,hN]=AdjustAndSetROI(hObject,handles);
end

handles = guidata(hObject);
handles.Scanning = true;
handles.FirstImageInScan = true;
%guidata(hObject,handles);
tic
for n = 1:TotalModesToScan
    ThisModeIndex = ModesToScanIndeces(n);
    Amplitudes = AmplitudeValues(ThisModeIndex,:);
    
    PeakIntensity = zeros(length(Amplitudes),1);
    for p=1:length(Amplitudes)
        ModeAmplitudes(ThisModeIndex) = Amplitudes(p);
        SetMirrorModes(hObject,handles,ModeAmplitudes,false); % Set mirror shape
        if (p==1)
            pause(0.2); % Wait until mirror reaches stationary shape
        else
            pause(0.01);
        end
        SnapShotButton_Callback(hObject,eventdata,handles); % Take a snap shot
        handles = guidata(hObject);
        v = int32(axis);
        im=handles.ImageBuffer.image;
        if (Thorlabs)
            subim=im(v(3):v(4)-1,v(1):v(2)-1);
        elseif (Andor)
            subim = im;
        end
        
        %subim = im(xN:xN+wN,yN:yN+hN);
        if OptimizeIntensity
            %[maxRow rowInd] = max(subim); % Get maximum intensity;
            %[~, colInd] = max(maxRow);
            %rowInd = rowInd(colInd);
            %xRange = rowInd-1:rowInd+1;
            %xRange((xRange<1)|(xRange>size(subim,1)))=[];
            %yRange = colInd-1:colInd+1;
            %yRange((yRange<1)|(yRange>size(subim,2)))=[];
            %subsubim=subim(xRange,yRange);
            %PeakIntensity(p) = mean(subsubim(:)); % Mean in few pixels around maximum intensity
            PeakIntensity(p) = MaximumIntensity(subim);
        elseif OptimizeRadialSymmetry
            RadSym = RadialSymmetry(subim);
            PeakIntensity(p) = -RadSym;
            set(handles.RadialVariance,'String',num2str(RadSym));
        elseif OptimizeSharpness
            Sharp = Sharpness(subim);
            PeakIntensity(p) = Sharp;
            set(handles.RadialVariance,'String',num2str(Sharp));
        end
        if handles.FirstImageInScan == true;
            handles.FirstImageInScan = false;
            guidata(hObject,handles);
        end
    end
    [MaxInt,MaxInd]=max(PeakIntensity);
    ModeAmplitudes(ThisModeIndex) = Amplitudes(MaxInd);
    
    handles = guidata(hObject);
    SetMirrorModes(hObject,handles,ModeAmplitudes);
    handles = guidata(hObject);
    %a = handles.amplitudes
    %handles.ModeAmplitudes = ModeAmplitudes;
    guidata(hObject,handles);
    
end
handles = guidata(hObject);
handles.Scanning = false;
guidata(hObject,handles);
display(['Total scan took ',num2str(toc),' s.'])
if Thorlabs
    SetAOI(handles.Camera,x,y,width,height);
end
if (VideoWasOn)
    display('Video was on at the end');
    %handles.VideoCapture
    %VideoCapture = true;
    VideoToggle_Callback(handles.VideoToggle, eventdata, handles);
end

% --- Executes on button press in ScanShapeSpace.
function ScanShapeSpace_Callback(hObject, eventdata, handles)
% hObject    handle to ScanShapeSpace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

HalfScanRange = handles.RangeSize/2; % Half of the size of the scan range
step = handles.StepSize; % Step size
PointsInSingleMode= int32(2*HalfScanRange/step + 1); % Total number of amplitude points to scan for each mode
TickHandles = [handles.ScanDefocus,handles.ScanAstigmatism,handles.ScanTiltX,handles.ScanTiltY,handles.ScanComaX,handles.ScanComaY,handles.ScanSpherical];
AberrationControlHandles = [handles.DefocusControl,handles.AstigmatismControl,handles.TiltXControl,handles.TiltYControl,handles.ComaXControl,handles.ComaYControl,handles.SphericalControl];
ModesIndeces = [ModeNumber.Defocus,ModeNumber.Astigmatism,ModeNumber.TiltX,ModeNumber.TiltY,ModeNumber.ComaX,ModeNumber.ComaY,ModeNumber.Spherical];

NumModes = length(TickHandles);

for i=1:NumModes
    ModesToScan(i)=get(TickHandles(i),'Value');
    CentralValues(i)=get(AberrationControlHandles(i),'Value');
    
    if (ModesToScan(i))
        AmplitudeValues(i,:) = CentralValues(i)-HalfScanRange:step:CentralValues(i)+HalfScanRange;
    else
        AmplitudeValues(i,:) = zeros(1,PointsInSingleMode)+CentralValues(i);
    end
end
AmplitudeValues = AmplitudeValues'/100;
TotalModesToScan = sum(ModesToScan);
ModesToScanIndeces=find(ModesToScan);
TotalNumberOfPoints = PointsInSingleMode^TotalModesToScan;

% Generate list of values to scan
Values(1,:) = AmplitudeValues(1,:);
Indeces(1,:) = ones(1,NumModes);
for n=2:TotalNumberOfPoints
    if mod(n,1000) == 0
        display(['Number of points generated: ',num2str(n)])
    end
    %Values(n,:) = Values(n-1,:);
    Indeces(n,:) = Indeces(n-1,:);
    i = 1;
    Indeces(n,ModesToScanIndeces(i)) = Indeces(n,ModesToScanIndeces(i)) + 1;
    while (Indeces(n,ModesToScanIndeces(i)) > PointsInSingleMode)
        Indeces(n,ModesToScanIndeces(i)) = 1;
        Indeces(n,ModesToScanIndeces(i+1)) = Indeces(n,ModesToScanIndeces(i+1)) + 1;
        i = i + 1;
    end
    
    for i=1:NumModes
        Values(n,i) = AmplitudeValues(Indeces(n,i),i);
    end
end
PeakIntensity=zeros(1,TotalNumberOfPoints);
axes(handles.CameraAxis);

display(['Number of points: ',num2str(TotalNumberOfPoints)]);
fighandle=figure(2);
%progressbarGUI(hObject,handles,0);
while (handles.ContinuousScan)
    for n=1:TotalNumberOfPoints
        Amplitudes = Values(n,:);
        ModeAmplitudes = zeros(length(handles.amplitudes),1);
        for i=1:length(ModesIndeces)
            ModeAmplitudes(ModesIndeces(i)) = Amplitudes(i);
        end
        setMirrorShapeInZernBasis(ModeAmplitudes/100,isplot,handles.ShapeGraphAxis,handles.MirrorChannelAxis,handles);
        pause(0.2); % Wait until mirror reaches stationary shape
        SnapShotButton_Callback(hObject,eventdata,handles); % Take a snap shot
        v = int32(axis);
        im=handles.ImageBuffer.image;
        subim=im(v(3):v(4),v(1):v(2));
        
        
        [maxRow rowInd] = max(subim); % Get maximum intensity;
        [~, colInd] = max(maxRow);
        rowInd = rowInd(colInd);
        xRange = rowInd-1:rowInd+1;
        xRange((xRange<1)|(xRange>size(subim,1)))=[];
        yRange = colInd-1:colInd+1;
        yRange((yRange<1)|(yRange>size(subim,2)))=[];
        subsubim=subim(xRange,yRange);
        PeakIntensity(n) = mean(subsubim(:)); % Mean in few pixels around maximum intensity
        
        if mod(n,10) == 0
            %progressbarGUI(hObject,handles,n/TotalNumberOfPoints);
            figure(fighandle);
            if (TotalModesToScan == 2)
                Z = zeros(PointsInSingleMode,PointsInSingleMode)
                Z(:) = PeakIntensity(:);
                Y = AmplitudeValues(:,ModesToScanIndeces(1));
                X = AmplitudeValues(:,ModesToScanIndeces(2));
                
                surf(X,Y,Z);
            else
                plot(PeakIntensity);
            end
            
        end
    end
end
[MaxInt,MaxInd]=max(PeakIntensity);
BestValues = Values(MaxInd,:);
SetMirrorModes(hObject,handles,BestValues/100);
handles.ModeAmplitudes = Values;
handles.PeakIntensity = PeakIntensity;
guidata(hObject,handles);
save('ScanData.mat','Values','PeakIntensity');


% --- Executes on button press in ScanDefocus.
function ScanDefocus_Callback(hObject, eventdata, handles)
% hObject    handle to ScanDefocus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ScanDefocus
SetTotalPointsToScan(hObject,handles);

% --- Executes on button press in ScanAstigmatism.
function ScanAstigmatism_Callback(hObject, eventdata, handles)
% hObject    handle to ScanAstigmatism (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ScanAstigmatism
SetTotalPointsToScan(hObject,handles);

% --- Executes on button press in ScanTiltX.
function ScanTiltX_Callback(hObject, eventdata, handles)
% hObject    handle to ScanTiltX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ScanTiltX
SetTotalPointsToScan(hObject,handles);

% --- Executes on button press in ScanTiltY.
function ScanTiltY_Callback(hObject, eventdata, handles)
% hObject    handle to ScanTiltY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ScanTiltY
SetTotalPointsToScan(hObject,handles);

% --- Executes on button press in ScanComaX.
function ScanComaX_Callback(hObject, eventdata, handles)
% hObject    handle to ScanComaX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ScanComaX
SetTotalPointsToScan(hObject,handles);

% --- Executes on button press in ScanComaY.
function ScanComaY_Callback(hObject, eventdata, handles)
% hObject    handle to ScanComaY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ScanComaY
SetTotalPointsToScan(hObject,handles);

% --- Executes on button press in ScanSpherical.
function ScanSpherical_Callback(hObject, eventdata, handles)
% hObject    handle to ScanSpherical (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ScanSpherical
SetTotalPointsToScan(hObject,handles);

% --- Executes on slider movement.
function CameraGainControl_Callback(hObject, eventdata, handles)
% hObject    handle to CameraGainControl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
gain=get(hObject,'Value');
if strcmp(handles.CameraTag,'Thorlabs')
    SetGainAndExposureTime(handles.Camera,gain,0);
elseif strcmp(handles.CameraTag,'Andor')
    AndorSetEMGainSDK(gain);
end
set(handles.CameraGainValue,'String',num2str(gain));

% --- Executes during object creation, after setting all properties.
function CameraGainControl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CameraGainControl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function ExposureTimeControl_Callback(hObject, eventdata, handles)
% hObject    handle to ExposureTimeControl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
ExposureTime=get(hObject,'Value');
handles.ExposureTime = ExposureTime;

if strcmp(handles.CameraTag,'Thorlabs')
    NewExposureTime=SetGainAndExposureTime(handles.Camera,0,ExposureTime);
    set(hObject,'Value',NewExposureTime); % Real new exposure time might differ to the user desired one
    set(handles.ExposureTimeValue,'String',num2str(NewExposureTime));
elseif strcmp(handles.CameraTag,'Andor')
    maxExp=AndorGetMaximumExposureTime*1000;
    if ExposureTime < 0
        ExposureTime = 0;
        handles.ExposureTime = ExposureTime;
    end
    if ExposureTime > maxExp
        ExposureTime = maxExp;
        handles.ExposureTime = ExposureTime;
    end
    set(hObject,'Value',ExposureTime);
    set(handles.ExposureTimeValue,'String',num2str(ExposureTime));
end
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function ExposureTimeControl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ExposureTimeControl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function StepSizeValue_Callback(hObject, eventdata, handles)
% hObject    handle to StepSizeValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of StepSizeValue as text
%        str2double(get(hObject,'String')) returns contents of StepSizeValue as a double

handles.StepSize = str2num(get(hObject,'String'));
guidata(hObject,handles);
SetTotalPointsToScan(hObject,handles);



% --- Executes during object creation, after setting all properties.
function StepSizeValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to StepSizeValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function RangeSizeValue_Callback(hObject, eventdata, handles)
% hObject    handle to RangeSizeValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RangeSizeValue as text
%        str2double(get(hObject,'String')) returns contents of RangeSizeValue as a double
handles.RangeSize = str2num(get(hObject,'String'));
guidata(hObject,handles);
SetTotalPointsToScan(hObject,handles);




% --- Executes during object creation, after setting all properties.
function RangeSizeValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RangeSizeValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function TotalPointsToScanValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TotalPointsToScanValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function TotalPointsToScanValue_Callback(hObject, eventdata, handles)
% hObject    handle to TotalPointsToScanValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TotalPointsToScanValue as text
%        str2double(get(hObject,'String')) returns contents of TotalPointsToScanValue as a double


function SetTotalPointsToScan(hObject,handles)
TickHandles = handles.TickHandles;
for i=1:length(TickHandles)
    ModesToScan(i)=get(TickHandles(i),'Value');
end
NumModesToScan=sum(ModesToScan);
TotalPointsToScan = int32(handles.RangeSize/handles.StepSize + 1)^NumModesToScan;
handles.TotalPointsToScan = TotalPointsToScan;
set(handles.TotalPointsToScanValue,'String',num2str(TotalPointsToScan));
guidata(hObject,handles);

function SetMirrorModesOld(hObject,handles,Values,isplot)
if (~exist('isplot'))
    isplot = true;
end
ControlHandles = handles.ControlHandles;
ValueHandles = handles.ValueHandles;
ModeNumbers = handles.ModeNumbers;
ModeAmplitudes = handles.amplitudes;
%ModeAmplitudes(ModeNumber.Piston) = handles.amplitudes(ModeNumber.Piston);
for i=1:length(ControlHandles) % Set the controls
    set(handles.ControlHandles(i),'Value',Values(i));
    set(handles.ValueHandles(i),'String',num2str(Values(i)));
    ModeAmplitudes(ModeNumbers(i))=Values(i);
end
handles = guidata(hObject);
handles.amplitudes = ModeAmplitudes;

guidata(hObject,handles);
setMirrorShapeInZernBasis(ModeAmplitudes/100,true,handles.ShapeGraphAxis,handles.MirrorChannelAxis,handles);



% --- Executes on button press in SaveImageButton.
function SaveImageButton_Callback(hObject, eventdata, handles)
% hObject    handle to SaveImageButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
v = int32(axis);
v(2)=v(2)-1;
v(4)=v(4)-1;
im=handles.ImageBuffer.image;

subim=im(v(3):v(4),v(1):v(2))';
[filename, pathname, filterindex] = uiputfile( ...
    {'*.fig;*.jpg;*.bmp;*.gif;*.eps;*.mat','Image Files (*.fig,*.jpg,*.bmp,*.gif,*.eps,*.mat)';...
    '*.*',  'All Files (*.*)'},...
    'Save as');
if isempty(strfind(filename, '.mat'))
    imwrite(subim,[pathname,filename]);
else
    save([pathname,filename],'subim');
end


% --- Executes on button press in ShowShape.
function ShowShape_Callback(hObject, eventdata, handles)
% hObject    handle to ShowShape (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
f=figure(1);
a=get(f,'CurrentAxes');
ReconstructFunctionFromInfluenceMatrix(handles.amplitudes,a,true);


% --- Executes on slider movement.
function FrameRateControl_Callback(hObject, eventdata, handles)
% hObject    handle to FrameRateControl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
FrameRate=get(hObject,'Value');
handles.FrameRate = FrameRate;
if strcmp(handles.CameraTag,'Thorlabs')
    NewFrameRate=SetFrameRate(handles.Camera,FrameRate);
    set(hObject,'Value',NewFrameRate); % Real new exposure time might differ to the user desired one
    set(handles.FrameRateValue,'String',num2str(NewFrameRate));
elseif strcmp(handles.CameraTag,'Andor')
    %[minFR,maxFR]=AndorGetFrameRateRange;
    %if FrameRate < minExp
    %    FrameRate = minFR;
    %    handles.FrameRate = FrameRate;
    %end
    %if FrameRate > maxFR
    %    FrameRate = maxFR;
    %    handles.FrameRate = FrameRate;
    %end
    set(hObject,'Value',FrameRate);
    set(handles.FrameRateValue,'String',num2str(FrameRate));
end
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function FrameRateControl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FrameRateControl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function FrameRateValue_Callback(hObject, eventdata, handles)
% hObject    handle to FrameRateValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FrameRateValue as text
%        str2double(get(hObject,'String')) returns contents of FrameRateValue as a double
set(handles.FrameRateControl,'Value',str2double(get(hObject,'String')));
guidata(hObject,handles);
FrameRateControl_Callback(handles.FrameRateControl, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function FrameRateValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FrameRateValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ExposureTimeValue_Callback(hObject, eventdata, handles)
% hObject    handle to ExposureTimeValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ExposureTimeValue as text
%        str2double(get(hObject,'String')) returns contents of ExposureTimeValue as a double
set(handles.ExposureTimeControl,'Value',str2double(get(hObject,'String')));
guidata(hObject,handles);
ExposureTimeControl_Callback(handles.ExposureTimeControl, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function ExposureTimeValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ExposureTimeValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function CameraGainValue_Callback(hObject, eventdata, handles)
% hObject    handle to CameraGainValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CameraGainValue as text
%        str2double(get(hObject,'String')) returns contents of CameraGainValue as a double
set(handles.CameraGainControl,'Value',str2double(get(hObject,'String')));
guidata(hObject,handles);
CameraGainControl_Callback(handles.CameraGainControl, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function CameraGainValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CameraGainValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function PixelClockFrequencyControl_Callback(hObject, eventdata, handles)
% hObject    handle to PixelClockFrequencyControl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
PixelClockFrequency=get(hObject,'Value');
NewPixelClockFrequency=SetPixelClockFrequency(handles.Camera,PixelClockFrequency);
set(hObject,'Value',NewPixelClockFrequency); % Real new exposure time might differ to the user desired one
set(handles.PixelClockFrequencyValue,'String',num2str(NewPixelClockFrequency));


% --- Executes during object creation, after setting all properties.
function PixelClockFrequencyControl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PixelClockFrequencyControl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function PixelClockFrequencyValue_Callback(hObject, eventdata, handles)
% hObject    handle to PixelClockFrequencyValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of PixelClockFrequencyValue as text
%        str2double(get(hObject,'String')) returns contents of PixelClockFrequencyValue as a double
set(handles.PixelClockFrequencyControl,'Value',str2double(get(hObject,'String')));
guidata(hObject,handles);
PixelClockFrequencyControl_Callback(handles.PixelClockFrequencyControl, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function PixelClockFrequencyValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PixelClockFrequencyValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ContinuousScanToggle.
function ContinuousScanToggle_Callback(hObject, eventdata, handles)
% hObject    handle to ContinuousScanToggle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.ContinousScan = ~Handles.ContinousScan;
guidata(hObject,handles);


% --- Executes when selected object is changed in CameraSelection.
function CameraSelection_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in CameraSelection
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
switch get(eventdata.NewValue,'Tag') % Get Tag of selected object.
    case 'Andor'
        handles.CameraTag = 'Andor';
    case 'Thorlabs'
        handles.CameraTag = 'Thorlabs';
        % Code for when Thorlabs is selected.
    otherwise
        display(get(eventdata.NewValue,'Tag'))
end
guidata(hObject, handles);


function CameraAxisZoomCallback

display 'XLim event!'


% --------------------------------------------------------------------
function activex2_HWResponse(hObject, eventdata, handles)
% hObject    handle to activex2 (see GCBO)
% eventdata  structure with parameters passed to COM event listener
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function activex2_SettingsChanged(hObject, eventdata, handles)
% hObject    handle to activex2 (see GCBO)
% eventdata  structure with parameters passed to COM event listener
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in OpenPositioningCameraButton.
function OpenPositioningCameraButton_Callback(hObject, eventdata, handles)
% hObject    handle to OpenPositioningCameraButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[handles.CameraPositioning handles.ImageBufferPositioning] = OpenCamera;
NewExposureTime=SetGainAndExposureTime(handles.CameraPositioning,0.1,0.001);
guidata(hObject,handles);

% --- Executes on button press in ClosePositioningCameraButton.
function ClosePositioningCameraButton_Callback(hObject, eventdata, handles)
% hObject    handle to ClosePositioningCameraButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ExitCamera(handles.CameraPositioning);


% --- Executes on button press in CorrectPositionButton.
function CorrectPositionButton_Callback(hObject, eventdata, handles)
% hObject    handle to CorrectPositionButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

P = str2num(get(handles.PValue,'String'));
I = str2num(get(handles.IValue,'String'));
Zsetpoint = str2num(get(handles.SetpointValue,'String'));
Gain = str2num(get(handles.GainValue,'String'));
X = double(handles.X);
Y = double(handles.Y);
initRow = handles.initRow;
endRow = handles.endRow;
initCol = handles.initCol;
endCol = handles.endCol;

Regulate = true;

if (isfield(handles,'Int'))
    Int = handles.Int;
else
    Int = 0;
end
if (isfield(handles,'Prop'))
    Prop = handles.Prop;
else
    Prop = 0;
end
while (Regulate)
    P = str2num(get(handles.PValue,'String'));
    I = str2num(get(handles.IValue,'String'));
    Zsetpoint = str2num(get(handles.SetpointValue,'String'));
    Gain = str2num(get(handles.GainValue,'String'));
    FreezeVideo(handles.CameraPositioning);
    im =handles.ImageBufferPositioning.image;
    image(im(initRow:endRow,initCol:endCol));
    Z = double(im(initRow:endRow,initCol:endCol));
    [maxI,maxRs]=max(Z);
    [~,maxC]=max(maxI);
    maxR=maxRs(maxC);
    [fitresult,gof,output] = createSurfaceFit(X, Y, Z, X(1,1)+maxR,Y(1,1)+maxC,max(max(I)));
    %x0 = 5.2*fitresult.x0; % DCC1545M thorlabs cam cas 5.2 um square pixels
    %Z0=X(:)'*Z(:)/sum(Z(:));
    Z0 = fitresult.x0;
    set(handles.CurrentPositionValue,'String',num2str(Z0));
    Prop = P*(Z0-Zsetpoint);
    Int = Int+I*(Z0-Zsetpoint);
    
    if Int > 10;
        Int = 10;
    end
    Voltage = -Gain*(Prop+Int);
    display(['P:',num2str(Prop),' I:',num2str(Int),' V:',num2str(Voltage)]);
    if (Voltage < 0)
        Voltage = 0;
    elseif (Voltage > 150)
        Voltage = 150;
    end
    h = handles.hPiezo2;
    h.SetVoltOutput(0,Voltage);
    pause(0.01);
    if (abs(Z0-Zsetpoint) < 0.001)
        Regulate = false;
    end
    
end
handles.Voltage = Voltage;
handles.Int = Int;
handles.Prop = Prop;
guidata(hObject,handles);

% --- Executes on button press in SetRefereceButton.
function SetRefereceButton_Callback(hObject, eventdata, handles)
% hObject    handle to SetRefereceButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

FreezeVideo(handles.CameraPositioning);
im =handles.ImageBufferPositioning.image;
axes(handles.PositioningCameraAxes);
[maxIs,maxRows]=max(im);
[~,maxCol]=max(maxIs);
maxRow = maxRows(maxCol);
initCol = maxCol-10;
endCol = maxCol+10;
initRow = maxRow-10;
endRow = maxRow+10;
[X,Y]=meshgrid(initCol:endCol,initRow:endRow);
image(im(initRow:endRow,initCol:endCol));
handles.initCol = initCol;
handles.endCol = endCol;
handles.initRow = initRow;
handles.endRow = endRow;
handles.X = X;
handles.Y = Y;
guidata(hObject,handles);



function SetpointValue_Callback(hObject, eventdata, handles)
% hObject    handle to SetpointValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SetpointValue as text
%        str2double(get(hObject,'String')) returns contents of SetpointValue as a double


% --- Executes during object creation, after setting all properties.
function SetpointValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SetpointValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function IValue_Callback(hObject, eventdata, handles)
% hObject    handle to IValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of IValue as text
%        str2double(get(hObject,'String')) returns contents of IValue as a double


% --- Executes during object creation, after setting all properties.
function IValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to IValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function PValue_Callback(hObject, eventdata, handles)
% hObject    handle to PValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of PValue as text
%        str2double(get(hObject,'String')) returns contents of PValue as a double


% --- Executes during object creation, after setting all properties.
function PValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function GainValue_Callback(hObject, eventdata, handles)
% hObject    handle to GainValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of GainValue as text
%        str2double(get(hObject,'String')) returns contents of GainValue as a double


% --- Executes during object creation, after setting all properties.
function GainValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to GainValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function CurrentPositionValue_Callback(hObject, eventdata, handles)
% hObject    handle to CurrentPositionValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CurrentPositionValue as text
%        str2double(get(hObject,'String')) returns contents of CurrentPositionValue as a double


% --- Executes during object creation, after setting all properties.
function CurrentPositionValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CurrentPositionValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ShutterToggle.
function ShutterToggle_Callback(hObject, eventdata, handles)
% hObject    handle to ShutterToggle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if (isfield(handles,'ShutterOpen'))
    handles.ShutterOpen = ~handles.ShutterOpen;
    if (handles.ShutterOpen)
        SetShutterSDK('open');
        set(handles.ShutterToggle,'String','Close shutter');
    else
        SetShutterSDK('close');
        set(handles.ShutterToggle,'String','Open shutter');
    end
else
    SetShutterSDK('close');
    handles.ShutterOpen = false;
end
guidata(hObject,handles);


% --- Executes on button press in EMGainToggle.
function EMGainToggle_Callback(hObject, eventdata, handles)
% hObject    handle to EMGainToggle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if (isfield(handles,'EMGainOn'))
    handles.EMGainOn = ~handles.EMGainOn;
    if (handles.EMGainOn)
        SetShutterSDK('open');
        set(handles.EMGainOn,'String','Turn EM Gain off');
    else
        SetShutterSDK('close');
        set(handles.EMGainOn,'String','Turn EM Gain on');
    end
else
    SetShutterSDK('close');
    handles.EMGainOn = false;
end
guidata(hObject,handles);


% --- Executes on button press in MeasurePSF.
function MeasurePSF_Callback(hObject, eventdata, handles)
% hObject    handle to MeasurePSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
zinit = str2double(get(handles.Zinit,'String'))
zend = str2double(get(handles.Zend,'String'))
zstep = str2double(get(handles.Zstep,'String'))
h = handles.hPiezo2;
[filename, pathname, filterindex] = uiputfile( ...
    {'*.mat','Matlab File (*.mat)';...
    '*.*',  'All Files (*.*)'},...
    'Save as');
firstiteration = true;
for z = zinit:zstep:zend
    h.SetVoltOutput(0,single(z));

    pause(0.3);

    SnapShotButton_Callback(handles.SnapShotButton, eventdata, handles);
    handles = guidata(hObject);
    v = int32(axis);
    v(2)=v(2)-1;
    v(4)=v(4)-1;
    im=handles.ImageBuffer.image;
    subim=im(v(3):v(4),v(1):v(2))';
    
    if firstiteration
        dlmwrite(filename,subim);
        firstiteration = false;
    else
        dlmwrite([pathname,filename],subim,'-append');
    end
end

function Zinit_Callback(hObject, eventdata, handles)
% hObject    handle to Zinit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Zinit as text
%        str2double(get(hObject,'String')) returns contents of Zinit as a double


% --- Executes during object creation, after setting all properties.
function Zinit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Zinit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Zend_Callback(hObject, eventdata, handles)
% hObject    handle to Zend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Zend as text
%        str2double(get(hObject,'String')) returns contents of Zend as a double


% --- Executes during object creation, after setting all properties.
function Zend_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Zend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Zstep_Callback(hObject, eventdata, handles)
% hObject    handle to Zstep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Zstep as text
%        str2double(get(hObject,'String')) returns contents of Zstep as a double


% --- Executes during object creation, after setting all properties.
function Zstep_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Zstep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Trefoil45Value_Callback(hObject, eventdata, handles)
% hObject    handle to Trefoil45Value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.Trefoil45Control,'Value',str2double(get(hObject,'String')));
guidata(hObject,handles);
Trefoil45Control_Callback(handles.Trefoil45Control, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function Trefoil45Value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Trefoil45Value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function TrefoilControl_Callback(hObject, eventdata, handles)
% hObject    handle to TrefoilControl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'Value');
handles.amplitudes(ModeNumber.Trefoil) = double(value);
set(handles.TrefoilValue,'String',num2str(value));
guidata(hObject, handles);
SetMirrorShape_Callback(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function TrefoilControl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TrefoilControl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function Trefoil45Control_Callback(hObject, eventdata, handles)
% hObject    handle to Trefoil45Control (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'Value');
handles.amplitudes(ModeNumber.Trefoil45) = double(value);
set(handles.Trefoil45Value,'String',num2str(value));
guidata(hObject, handles);
SetMirrorShape_Callback(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function Trefoil45Control_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Trefoil45Control (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function TrefoilValue_Callback(hObject, eventdata, handles)
% hObject    handle to TrefoilValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.TrefoilControl,'Value',str2double(get(hObject,'String')));
guidata(hObject,handles);
TrefoilControl_Callback(handles.TrefoilControl, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function TrefoilValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TrefoilValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SecondAstigmatismValue_Callback(hObject, eventdata, handles)
% hObject    handle to SecondAstigmatismValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.SecondAstigmatismControl,'Value',str2double(get(hObject,'String')));
guidata(hObject,handles);
SecondAstigmatismControl_Callback(handles.SecondAstigmatismControl, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function SecondAstigmatismValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SecondAstigmatismValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function SecondAstigmatismControl_Callback(hObject, eventdata, handles)
% hObject    handle to SecondAstigmatismControl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'Value');
handles.amplitudes(ModeNumber.Astigmatism2) = double(value);
set(handles.SecondAstigmatismValue,'String',num2str(value));
guidata(hObject, handles);
SetMirrorShape_Callback(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function SecondAstigmatismControl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SecondAstigmatismControl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in ScanTrefoil.
function ScanTrefoil_Callback(hObject, eventdata, handles)
% hObject    handle to ScanTrefoil (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

SetTotalPointsToScan(hObject,handles);


% --- Executes on button press in ScanTrefoil45.
function ScanTrefoil45_Callback(hObject, eventdata, handles)
% hObject    handle to ScanTrefoil45 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

SetTotalPointsToScan(hObject,handles);

% --- Executes on button press in ScanSecondAstigmatism.
function ScanSecondAstigmatism_Callback(hObject, eventdata, handles)
% hObject    handle to ScanSecondAstigmatism (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

SetTotalPointsToScan(hObject,handles);

% --- Executes on slider movement.
function Astigmatism45Control_Callback(hObject, eventdata, handles)
% hObject    handle to Astigmatism45Control (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'Value');
handles.amplitudes(ModeNumber.Astigmatism45) = double(value);
set(handles.Astigmatism45Value,'String',num2str(value));
guidata(hObject, handles);
SetMirrorShape_Callback(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function Astigmatism45Control_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Astigmatism45Control (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function Astigmatism45Value_Callback(hObject, eventdata, handles)
% hObject    handle to Astigmatism45Value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.Astigmatism45Control,'Value',str2double(get(hObject,'String')));
guidata(hObject,handles);
Astigmatism45Control_Callback(handles.Astigmatism45Control, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function Astigmatism45Value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Astigmatism45Value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ScanAstigmatism45.
function ScanAstigmatism45_Callback(hObject, eventdata, handles)
% hObject    handle to ScanAstigmatism45 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

SetTotalPointsToScan(hObject,handles);



function Trefoil135Value_Callback(hObject, eventdata, handles)
% hObject    handle to Trefoil135Value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.Trefoil135Control,'Value',str2double(get(hObject,'String')));
guidata(hObject,handles);
Trefoil135Control_Callback(handles.Trefoil135Control, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function Trefoil135Value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Trefoil135Value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function Trefoil135Control_Callback(hObject, eventdata, handles)
% hObject    handle to Trefoil135Control (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

value=get(hObject,'Value');
handles.amplitudes(ModeNumber.Trefoil135) = double(value);
set(handles.Trefoil135Value,'String',num2str(value));
guidata(hObject, handles);
SetMirrorShape_Callback(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function Trefoil135Control_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Trefoil135Control (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in ScanTrefoil135.
function ScanTrefoil135_Callback(hObject, eventdata, handles)
% hObject    handle to ScanTrefoil135 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

SetTotalPointsToScan(hObject,handles);



function Trefoil90Value_Callback(hObject, eventdata, handles)
% hObject    handle to Trefoil90Value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.Trefoil90Control,'Value',str2double(get(hObject,'String')));
guidata(hObject,handles);
Trefoil90Control_Callback(handles.Trefoil90Control, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function Trefoil90Value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Trefoil90Value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function Trefoil90Control_Callback(hObject, eventdata, handles)
% hObject    handle to Trefoil90Control (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

value=get(hObject,'Value');
handles.amplitudes(ModeNumber.Trefoil90) = double(value);
set(handles.Trefoil90Value,'String',num2str(value));
guidata(hObject, handles);
SetMirrorShape_Callback(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function Trefoil90Control_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Trefoil90Control (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in ScanTrefoil90.
function ScanTrefoil90_Callback(hObject, eventdata, handles)
% hObject    handle to ScanTrefoil90 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
SetTotalPointsToScan(hObject,handles);


% --- Executes on button press in GeneticOptimizePSF.
function GeneticOptimizePSF_Callback(hObject, eventdata, handles)
% hObject    handle to GeneticOptimizePSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
OptimizePSF(hObject,handles); 


% --------------------------------------------------------------------
function activex3_HWResponse(hObject, eventdata, handles)
% hObject    handle to activex3 (see GCBO)
% eventdata  structure with parameters passed to COM event listener
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when selected object is changed in OptimizeSelector.
function OptimizeSelector_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in OptimizeSelector 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
switch get(eventdata.NewValue,'Tag') % Get Tag of selected object.
    case 'Intensity'
        handles.OptimizeTag = 'Intensity';
    case 'RadialSymmetry'
        handles.OptimizeTag = 'RadialSymmetry';
    case 'Sharpness'
        handles.OptimizeTag = 'Sharpness';
    case 'ExperimentalPSF'
        handles.OptimizeTag = 'ExperimentalPSF';
    otherwise
        display(get(eventdata.NewValue,'Tag'))
end
guidata(hObject, handles);


% --- Executes on button press in GeneticOptimizePSFAct.
function GeneticOptimizePSFAct_Callback(hObject, eventdata, handles)
% hObject    handle to GeneticOptimizePSFAct (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
OptimizePSFonActuators(hObject,handles);


% --- Executes on button press in UseActuatorInicialCorrection.
function UseActuatorInicialCorrection_Callback(hObject, eventdata, handles)
% hObject    handle to UseActuatorInicialCorrection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of UseActuatorInicialCorrection

UseActuatorCorrection=get(hObject,'Value');
handles.UseActuatorCorrection = UseActuatorCorrection;
if (UseActuatorCorrection)
    load GAdata.mat;
    handles.IniticalCorrection = Res';
    setMirrorChannels(Res);
end
guidata(hObject,handles);
