%function [optimZernCoeffs, voltage] = optimPSF(FWHM_x_guess,FWHM_y_guess)
FWHM_x_guess=5;
FWHM_y_guess=5;
OptimizeWidths = 0; % Set to 1 to optimize on PSF widths and 0 to optimize on peak intensity (much faster)
makeTodaysDirectory();
todaysDate = datestr(now,'yyyy-mm-dd');
folder = strcat('Z:\LEB\shared\NicolasPiro\mesures\',todaysDate,'\');

load('zernCoeffs.mat');
connectToMirror;
%amplitudeRange = -21:7:21;
amplitudeRange = -30:2:30;
widths = zeros(15,amplitudeRange,2);

optimZernCoeffs = zeros(1,15);


% Get a camara picture and let the user select a ROI
[cam I1] = OpenCamera;
FreezeVideo(cam);
figure(1);
clf;
image(I1.image);

h=imrect;
roi = int32(wait(h));

figure(2);
mode3 = 1;
mode1 = 10;
mode2 = 11;
mode4 = 12;
mode4 = 13;

PeakIntensity = zeros(length(amplitudeRange),length(amplitudeRange));
for i=1:length(amplitudeRange)
    for j=1:length(amplitudeRange)
        % resetting the mirror channels
        setMirrorBackground();
        %display(['Mode: ',num2str(mode)]);
        amplitude1 = amplitudeRange(i);
        amplitude2 = amplitudeRange(j);
        voltageVect = 0.5*(sendZernMode(mode1,amplitude1,false)+...
                      sendZernMode(mode2,amplitude2,false));
        
        saveMirrorBackground(voltageVect);
        try
            FreezeVideo(cam); % Take a new image from the camera: It is stored in the I1 structure.
        catch
            display('Error with FreexeVideo(), restarting cam');
            ExitCamera(cam);
            [cam I1] = OpenCamera;
        end
        Im = I1.image; % image elemtn in I1 structure is the image element.
        imwrite(Im,[folder,num2str(i),'_',num2str(j),'.bmp'],'bmp');
        %subplot(4,2,j);
        subim = Im(roi(2):roi(2)+roi(4),roi(1):roi(1)+roi(3));
        %image(subim);
        [maxRow rowInd] = max(subim); % Get maximum intensity;
        [maxCol colInd] = max(maxRow);
        %[intensity maxInd] = max(subim(:)); 
        xRange = rowInd-1:rowInd+1;
        xRange((xRange<1)|(xRange>size(subim,1)))=[];
        yRange = colInd-1:colInd+1;
        yRange((yRange<1)|(yRange>size(subim,2)))=[];
        subsubim=subim(xRange,yRange);
        PeakIntensity(i,j) = mean(subsubim(:)); % Mean in few pixels around maximum intensity
        figure(3);
        subplot(2,1,1);
        surf(PeakIntensity);
        subplot(2,1,2);
        image(subim);
    end
    %voltage = ZtoA*optimZernCoeffs';
    %saveMirrorBackground(voltage);
    if OptimizeWidths % Fit 2D gaussians and use fitted widths as optimization parameter
        figure(1);
        filesList = ls(strcat(folder,num2str(mode),'_*.bmp'));
        for k=1:size(filesList,1)
            filename = [folder,filesList(k,:)];
            [width_x,width_y] = findAndFit(filename,FWHM_x_guess,FWHM_y_guess,0,0,0,roi);
            widths(mode,k,:) = [width_x, width_y];
        end
        
        av_width = sqrt(widths(mode,:,1).^2+widths(mode,:,1).^2);
        %wx = widths(mode,:,1);
        %[minW_x minIdx_x] = min(wx);
        %wy = widths(mode,:,2);
        %[minW_y minIdx_y] = min(wy);
        [minW minIdx] = min(av_width);
        
        MeanWidth(i,j) = minW;
    else    % Use intensity as optimization parameter (much faster)
        %[maxI maxIndex] = max(intensity(mode));
        %PeakIntensity(i,j) = maxI;
        
    end
    
end
closeMirror
ExitCamera(cam)