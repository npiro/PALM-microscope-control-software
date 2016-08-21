function aVect = sendZernMode(mode,amplitude,isplot)
%function aVect = sendZernMode(mode,amplitude,isplot)
% sends the specified Zernike mode to the DM.
% input:    mode: an integer between 0 and 15 giving the Zernike mode
% (default ordering)
%           amplitude: scalar between 0 and 1
%           isplot: if true, plots will be displayed.
% output:   aVect: 32-digit vector of the voltages sent to the DM's
% actuators

load('ZernCoeffs.mat');
%connectToMirror;
if nargin==2
    isplot=false;
end

% defining the wanted vector in the Zernike basis
zVect = zeros(15,1);
zVect(mode) = 1;

% computing the vector in the actuator's basis
aVect = ZtoA*zVect;
aVect = amplitude*(aVect./max(aVect)); % normalize to 1 at max (1 <--> 250V)

if length(aVect)~=32
    error('Error: incorrect number of elements for the channel vector. See sendZernMode for details.');
else
    setMirrorChannels(aVect);
    if isplot==true
        % Preparing the zernike_fcn3 input parameters
        x = -1:0.01:1;
        [X,Y] = meshgrid(x,x);
        [theta,r] = cart2pol(X,Y);
        idx = r<=1;
        zernM = zernfun2([mode],r(idx),theta(idx));
        z = NaN(size(X));
        z(idx) = zernM(:);
        %plotting the Zernike mode we send and the corresponding actuator
        %channel values
        figure(787)
        subplot(1,2,1)
        pcolor(x,x,z), shading interp
        set(gca,'XTick',[],'YTick',[])
        axis square
        title(['Zernike mode'])
        subplot(1,2,2)
        plot(1:32,aVect,'b')
        title(['corresponding actuator channel values'])
    end
end


end

