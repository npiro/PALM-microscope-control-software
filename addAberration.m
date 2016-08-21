function aVect = addAberration(aberration,angle_deg,amplitude,isplot)

load('ZernCoeffs.mat');
connectToMirror;
angle_rad = angle_deg*pi/180;

if nargin==3
    isplot=false
end

% defining the wanted vector in the Zernike basis
zVect = zeros(15,1);

switch(aberration)
    case 'tilt'
        zVect(1) = cos(angle_rad);
        zVect(2) = sin(angle_rad);
    case 'defocus'
        zVect(4) = 1;
    case 'astigmatism'
        zVect(3) = cos(angle_rad);
        zVect(5) = sin(angle_rad/2);
end

% computing the vector in the actuator's basis
aVect = ZtoA*zVect;
aVect = amplitude*(aVect./max(aVect));

if length(aVect)~=32
    error('Error: incorrect number of elements for the channel vector. See sendZernMode for details.');
else
    setMirrorChannels(aVect);
    if isplot==true
        % Preparing the zernike_fcn3 input parameters
        zernM = getZernMask(aberration,256,1.0,angle_deg,amplitude,'quiet');
        %plotting the Zernike mode we send and the corresponding actuator
        %channel values
        x=1:256;
        figure(787)
        subplot(1,2,1)
        pcolor(x,x,zernM), shading interp
        set(gca,'XTick',[],'YTick',[])
        axis square
        title(['Zernike mode'])
        subplot(1,2,2)
        plot(1:32,aVect,'b')
        title(['corresponding actuator channel values'])
    end
end

end