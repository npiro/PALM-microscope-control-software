function SetMirrorModes(hObject,handles,Values,isplot)
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
