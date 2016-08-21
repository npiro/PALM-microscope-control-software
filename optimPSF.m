function [optimZernCoeffs, voltage] = optimPSF(FWHM_x_guess,FWHM_y_guess)

makeTodaysDirectory();
todaysDate = datestr(now,'yyyy-mm-dd');
folder = strcat('Z:\Alexandre-Mougel\mesures',todaysDate);

load('zernCoeffs.mat');
connectToMirror;
amplitudeRange = -21:7:21;
widths = zeros(15,amplitudeRange,2);

optimZernCoeffs = zeros(1,15);


for i=1:15
    for j=1:length(amplitudeRange)
        % resetting the mirror channels
        setMirrorBackground();
        mode = i
        amplitude = amplitudeRange(j)
        voltageVect = sendZernMode(mode,amplitude,false);
        input(strcat('Please save the image as <mode>_<amplitude>.bmp then press enter'));
    end
    
    filesList = ls(strcat(folder,'\',mode,'_*.bmp'));
    for k=1:length(filesList)
        filename = filesList(k,:);
        [width_x, width_y] = findAndFit(filename,FWHM_x_guess,FWHM_y_guess,0,0,0);
        widths(mode,j,:) = [width_x, width_y];
    end
    wx = widths(mode,:,1);
    [minW_x minIdx_x] = min(wx);
    wy = widths(mode,:,2);
    [minW_y minIdx_y] = min(wy);
    
    
    if minIdx_x==minIdx_y;
        optimZernCoeffs(i) = amplitudeRange(minIdx_x);
    else
        choice = input('indexes for the minimal FWHMs are different. Which one (x or y) do you want to store? ');
        switch choice
            case 'x'
                optimZernCoeffs(i) = amplitudeRange(minIdx_x);
            case 'y'
                optimZernCoeffs(i) = amplitudeRange(minIdx_y);
            otherwise
                optimZernCoeffs(i) = amplitudeRange(minIdx_x);
        end
    end
    FWHM_x_guess = minW_x;
    FWHM_y_guess = minW_y;
    
    voltage = ZtoA*optimZernCoeffs;
    saveMirrorBackground(voltage);
end

end