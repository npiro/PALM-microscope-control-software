function [F]=ReconstructFunctionFromInfluenceMatrix(amplitudes1,axis_handle,UseRealChannelValues)
if (~exist('PANarray'))
    load zernCoeffs.mat;
end
%for i=1:32
%    for j=1:32
%        myZtoA(i,j) = PANarray(i).zernCoeffs(j);
%    end
%end
if ~exist('UseRealChannelValues')
    UseRealChannelValues = false;
end
if ~exist('axis_handle')
    noaxishandle = true;
    figure(1);
    axis_handle = gca;
    clf;
else
    noaxishandle = false;
end
if UseRealChannelValues
    actuators1 = double(getMirrorChannelsStatus);
else
    %amplitudes1p = amplitudes1(ModeNumber.Piston);
    %amplitudes1(ModeNumber.Piston) = 0;
    actuators1 = ZtoA*amplitudes1;
    %actuators1 = actuators1 + amplitudes1p;
    
    %actuators1(actuators1<0) = 0;
end
x = -1.2:0.02:1.18;
[X,Y] = meshgrid(x,x);
[theta,r] = cart2pol(X,Y);
idx = r<=1;
z = nan(size(X));
F1 = zeros(size(X));

for i=1:64
    
    F1 = F1 + actuators1(i)*PANarray(i).infMat;
    %F2 = F2 + actuators2(i)*PANarray(i).infMat;
end
z(idx) = F1(idx);
if noaxishandle
    subplot(2,1,1);
    contourf(x,x,z,'LevelStep',0.000000001,'LineStyle','none');
    subplot(2,1,2);
    surf(X,Y,z);
else
    contourf(axis_handle,x,x,z,'LevelStep',0.000000001,'LineStyle','none');
end