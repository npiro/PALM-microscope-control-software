function [OptVal]=PSFFitnessOnActuators(amplitudes,OptimizeMethod)
% Fitness function for optimization procedure
% OptimizeMethod: 1: Intensity, 2: Radial variance, 3: Sharpness

global hObject;
global handles;
%display(GUIAmplitudes);
%SetMirrorModes(hObject,handles,GUIAmplitudes,false);
amplitudes(amplitudes<0) = 0;
amplitudes(amplitudes>1) = 1;
aVect = sqrt(amplitudes);
bar(handles.MirrorChannelAxis,1:64,aVect,'b');
setMirrorChannels(aVect);
h = handles.hPiezo2;
zinit = str2double(get(handles.Zinit,'String'));
zend = str2double(get(handles.Zend,'String'));
zstep = str2double(get(handles.Zstep,'String'));
i=0;
OptVal = 0;

for z=zinit:zstep:zend
    i=i+1;
    h.SetVoltOutput(0,single(z));
    pause(0.3);
    SnapShot(hObject,[],handles);
    handles = guidata(hObject);
    v = int32(axis);
    v(2)=v(2)-1;
    v(4)=v(4)-1;
    im=handles.ImageBuffer.image;
    subim(:,:,i)=im(v(3):v(4),v(1):v(2))';
    
    handles = guidata(hObject);
end
if OptimizeMethod ~= 4
    for i=1:size(subim,3)
        if OptimizeMethod == 2
            [Val,cent]=RadialSymmetry(subim(:,:,i));
            centroids(i,:) = cent;
            hold(handles.CameraAxis,'on');
            plot(v(1)+cent(2)-1,v(3)+cent(1)-1,'xy');
            hold off;
            OptVal=OptVal+Val;
            set(handles.RadialVariance,'String',num2str(OptVal));
        elseif OptimizeMethod == 3
            OptVal=OptVal-Sharpness(subim(:,:,i));
            set(handles.RadialVariance,'String',num2str(OptVal));
        else
            OptVal=OptVal-MaximumIntensity(subim(:,:,i));
            set(handles.RadialVariance,'String',num2str(OptVal));
        end
        if OptimizeMethod == 2
            OptVal=OptVal*(1+std(centroids(:,1)+std(centroids(:,2))));
        end
    end
else
    OptVal = CompareToReferencePSF(hObject,handles,subim,zinit,zend,zstep);
    set(handles.RadialVariance,'String',num2str(OptVal));
end



%if handles.FirstImageInScan == true;
%    handles.FirstImageInScan = false;
%    guidata(hObject,handles);
%end
