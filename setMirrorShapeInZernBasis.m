function aVect = setMirrorShapeInZernBasis(amplitudes,isplot,axes_handle,channelaxes_handle,handles)
%function aVect = setMirrorShapeInZernBasis(amplitudes,isplot,axes_handle)
% sends the specified combination of amplitudes of Zernike modes to the DM.
% input:    amplitude: 16 element array with each of the Zernike mode amplitudes
% (default ordering)
%           isplot: if true, plots will be displayed.
%           axes_handle: axes or figure handle to plot to
% output:   aVect: 32-digit vector of the voltages sent to the DM's
% actuators

if (~exist('handles'))
    load('ZernCoeffs.mat');
else
    PANarray = handles.PANarray;
    AtoZ = handles.AtoZ;
    ZtoA = handles.ZtoA;
    AtoZNeg = handles.AtoZNeg;
    ZtoANeg = handles.ZtoANeg;
end

%AtoZ = handles.AtoZ;
%PANarray = handles.PANarray;
%ZtoA = handles.ZtoA;
%connectToMirror;
if nargin==1
    isplot=false;
    axes_handle = 20;
elseif nargin<3
    axes_handle = 20;
    channelaxes_handle = 21;
elseif nargin<4
    channelaxes_handle = 21;
end

% computing the vector in the actuator's basis
%amplitudes1 = amplitudes(1);
%amplitudes(1) = 0;
pos = amplitudes>=0;
amplitudesPos = amplitudes;
amplitudesNeg = -amplitudes;
amplitudesPos(~pos) = 0;
amplitudesNeg(pos) = 0;

aVect = sqrt(ZtoA*amplitudesPos+ZtoANeg*amplitudesNeg);

%amplitudes(1) = amplitudes1;
%aVect = aVect;% + amplitudes(ModeNumber.Piston);
%if length(aVect)~=32
if length(aVect)~=64
    error('Error: incorrect number of elements for the channel vector. See setMirrorShapeInZernBasis for details.');
else
    if (handles.UseActuatorCorrection)
        aVect = sqrt(aVect.^2+(handles.IniticalCorrection).^2);
    end
    setMirrorChannels(aVect);
    if isplot==true
        % Preparing the zernike_fcn3 input parameters
        x = -6:0.1:5.999;
        [X,Y] = meshgrid(x,x);
        [theta,r] = cart2pol(X,Y);
        idx = r<=1;
        
        %MirrorShape = amplitudes(1)*zernfun2defaultOrdering(1,r(idx),theta(idx));
        %for modeN=2:15
        %    MirrorShape = MirrorShape+amplitudes(modeN)*zernfun2defaultOrdering(modeN,r(idx),theta(idx));
        %end
        
        %z = NaN(size(X));
        %z(idx) = MirrorShape(:);
        %plotting the Zernike mode we send and the corresponding actuator
        %channel values
        %axes(axes_handle);
        %subplot(1,2,1);
        
        %title(['Zernike mode'])
        ma = max(aVect);
        mi = min(aVect);
        if (ma < 1 && mi > 0)
            ChannelArray=aVect;
        else
            ChannelArray=aVect;
            ChannelArray(aVect>1) = 1;
            ChannelArray(aVect<0) = 0;
            %ChannelArray=double(getMirrorChannelsStatus);
        end
        z=ReconstructFunctionFromActuators(ChannelArray,[],false,handles);
        pcolor(axes_handle,x,x,z), shading(axes_handle,'interp');
        set(axes_handle,'XTick',[],'YTick',[])
        axis(axes_handle,'square')
        %f2=figure(2);
        %clf;
        %ax = get(f2,'CurrentAxes');
        %subplot(2,1,1);
        %bar(ax,1:32,aVect);
        %xlabel('output vector');
        %subplot(2,1,2);
        %bar(ax,1:32,ChannelArray(1:32));
        %xlabel('read vector');
        bar(channelaxes_handle,1:64,ChannelArray(1:64),'b');
        
        %title(['corresponding actuator channel values'])
    end
end


end

