function [F]=PlotShapeFunction(F,idx,axis_handle)
if (~exist('PANarray'))
    load zernCoeffs.mat;
end
%for i=1:32
%    for j=1:32
%        myZtoA(i,j) = PANarray(i).zernCoeffs(j);
%    end
%end

if ~exist('axis_handle')
    figure(1);
    axis_handle = gca;
end

x = -1.2:0.02:1.18;
[X,Y] = meshgrid(x,x);
[theta,r] = cart2pol(X,Y);
if ~exist('idx')
    idx = r<=0.8;
end

F1 = nan(size(X));

F1(idx)=F; 
%contourf(axis_handle,x,x,z,'LevelStep',0.000001,'LineStyle','none');
surf(axis_handle,X,Y,F1);