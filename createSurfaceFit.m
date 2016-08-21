function [fitresult, gof, output] = createSurfaceFit(X, Y, Z, x0,y0, I0)
%CREATESURFACEFIT(X,Y,Z)
%  Fit surface to data.
%
%  Data for 'untitled fit 1' fit:
%      X Input : X
%      Y Input : Y
%      Z Output: Z
%  Output:
%      fitresult : an sfit object representing the fit.
%      gof : structure with goodness-of fit info.
%
%  See also FIT, SFIT.

%  Auto-generated by MATLAB on 20-Dec-2011 20:05:08


%% Fit: 'untitled fit 1'.
[xInput, yInput, zOutput] = prepareSurfaceData( X, Y, Z );

% Set up fittype and options.
ft = fittype( 'a + c*exp(-0.5*((x-x0)^2+(y-y0)^2)/w^2)', 'indep', {'x', 'y'}, 'depend', 'z' );
opts = fitoptions( ft );
opts.Algorithm = 'Levenberg-Marquardt';
opts.Display = 'Off';
opts.Lower = [-Inf -Inf -Inf -Inf -Inf];
opts.StartPoint = [1 double(I0) 5 double(x0) double(y0)];
opts.Upper = [Inf Inf Inf Inf Inf];

% Fit model to data.
[fitresult, gof,output] = fit( [xInput, yInput], zOutput, ft, opts );

% Plot fit with data.
%figure( 'Name', 'untitled fit 1' );
%h = plot( fitresult, [xInput, yInput], zOutput );
%legend( h, 'untitled fit 1', 'Z vs. X, Y', 'Location', 'NorthEast' );
%% Label axes
%xlabel( 'X' );
%ylabel( 'Y' );
%zlabel( 'Z' );
%grid on
%view( -85.5, 50 );


