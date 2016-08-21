function [F]=ReconstructFunctionFromActuators(actuators,axis_handle,isplot,handles)

if (exist('handles','var'))
    AtoZ = handles.AtoZ;
    ZtoA = handles.ZtoA;
    PANarray = handles.PANarray;
else
    if (~exist('PANarray'))
        load zernCoeffs.mat;
    end
end
%for i=1:32
%    for j=1:32
%        myZtoA(i,j) = PANarray(i).zernCoeffs(j);
%    end
%end

if ~exist('isplot','var')
    isplot = false;
end
if (~exist('axis_handle') && isplot)
    figure(1);
    axis_handle = gca;
end



x = -1.2:0.02:1.18;
[X,Y] = meshgrid(x,x);
[theta,r] = cart2pol(X,Y);
idx = r<=1;
z = nan(size(X));
F1 = zeros(size(X));

for i=1:64
    F1 = F1 + actuators(i)*PANarray(i).infMat;
    %F2 = F2 + actuators2(i)*PANarray(i).infMat;
end
F1(~idx)=nan;
F=F1;
%contourf(axis_handle,x,x,z,'LevelStep',0.000001,'LineStyle','none');
if isplot
    surf(axis_handle,X,Y,F1);
end