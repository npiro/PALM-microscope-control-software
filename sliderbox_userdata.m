function varargout = sliderbox_userdata(varargin)
%SLIDERBOX_USERDATA M-file for sliderbox_userdata.fig
%      SLIDERBOX_USERDATA, by itself, creates a new SLIDERBOX_USERDATA or raises the existing
%      singleton*.
%
%      H = SLIDERBOX_USERDATA returns the handle to a new SLIDERBOX_USERDATA or the handle to
%      the existing singleton*.
%
%      SLIDERBOX_USERDATA('Property','Value',...) creates a new SLIDERBOX_USERDATA using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to sliderbox_userdata_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      SLIDERBOX_USERDATA('CALLBACK') and SLIDERBOX_USERDATA('CALLBACK',hObject,...) call the
%      local function named CALLBACK in SLIDERBOX_USERDATA.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
%      This GUI uses the Handles Structure to communicate values
%      between a slider and the edit text box. It uses UserData to keep
%      a count of the number of errors the user makes in the edit box.
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help sliderbox_userdata

% Last Modified by GUIDE v2.5 26-Nov-2008 14:18:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @sliderbox_userdata_OpeningFcn, ...
                   'gui_OutputFcn',  @sliderbox_userdata_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before sliderbox_userdata is made visible.
function sliderbox_userdata_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for sliderbox_userdata
handles.output = hObject;
% INITALIZE ERROR COUNT AND USE EDITTEXT1 OBJECT'S USERDATA TO STORE IT.
data.number_errors = 0;
set(handles.edittext1,'UserData',data)

% Update handles structure
guidata(hObject,handles);

% UIWAIT makes sliderbox_userdata wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = sliderbox_userdata_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

set(handles.edittext1,'String',...
   num2str(get(hObject,'Value')));

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function edittext1_Callback(hObject, eventdata, handles)
% hObject    handle to edittext1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edittext1 as text
%        str2double(get(hObject,'String')) returns contents of edittext1 as a double

val = str2double(get(hObject,'String'));
% Determine whether val is a number between 0 and 1.
if isnumeric(val) && length(val)==1 && ...
   val >= get(handles.slider1,'Min') && ...
   val <= get(handles.slider1,'Max')
   set(handles.slider1,'Value',val);
else
% Retrieve and increment the error count.
% Error count is in the edit text UserData, 
% so we already have its handle.
   data = get(hObject,'UserData');
   data.number_errors = data.number_errors+1;
% Save the changes.
   set(hObject,'UserData',data); 
% Display new total.
   set(hObject,'String',...
   ['You have entered an invalid entry ',...
    num2str(data.number_errors),' times.']);
   % Restore focus to the edit text box after error
   uicontrol(hObject)
end


% --- Executes during object creation, after setting all properties.
function edittext1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edittext1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


