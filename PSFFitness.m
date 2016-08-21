function [OptVal]=PSFFitness(OptimizableModeAmplitudes,ModesToOptimize,InitialAmplitudes,OptimizeMethod)
% Fitness function for optimization procedure
% OptimizeMethod: 1: Intensity, 2: Radial variance, 3: Sharpness
GUIAmplitudes = InitialAmplitudes;
n = 0;
for i=1:length(ModesToOptimize)
    if (ModesToOptimize(i))
        n = n + 1;
        GUIAmplitudes(i) = OptimizableModeAmplitudes(n);
    end
end
global hObject;
global handles;
%display(GUIAmplitudes);
SetMirrorModes(hObject,handles,GUIAmplitudes,false);

SnapShot(hObject,[],handles);

handles = guidata(hObject);
im=handles.ImageBuffer.image;

if OptimizeMethod == 2
    OptVal=RadialSymmetry(im);
    set(handles.RadialVariance,'String',num2str(OptVal));
elseif OptimizeMethod == 3
    OptVal=-Sharpness(im);
    set(handles.RadialVariance,'String',num2str(OptVal));
else
    OptVal=-MaximumIntensity(im);
    set(handles.RadialVariance,'String',num2str(OptVal));
end
    



%if handles.FirstImageInScan == true;
%    handles.FirstImageInScan = false;
%    guidata(hObject,handles);
%end
