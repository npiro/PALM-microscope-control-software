function aberratedResponse = dlMicroscope(limitWidth_m,aberration,angle_deg,force,quiet)
% Simulates the influence of the PAN Adaptica Deformable Mirror on a
% gaussian wavefront (representing the diffraction-limited response of a
% wide-field microscope). The effect of a chosen Zernike Mode is computed
% and plotted.
%
% input:    limitWidth_m:   diffraction limit of the microscope (in nm), i.e.
%                           the FWHM of the input Gaussian if we want to
%                           put an aberration-free PSF as input.
%
%           aberration:     string containing the name of the desired
%                           aberration, based on Zernike modes. The
%                           possible aberrations are:
%                               tilt, defocus, astigmatism
%
%           angle:          the angle (in degrees) of the aberration pattern respective
%                           to a horizontal x axis.
%
%           force:          steepness and amplitude of the aberration
%                           pattern applied
%
%       [OPTIONAL]:
%
%           inputWF:        square matrix representing an input wavefront,
%                           if wanted to be different from a flat_phase gaussian (for
%                           example a PSF with induced astigmatism).
%
%           quiet:          String. If the value is 'quiet', the plots won't be displayed.
%                           If the value is 'onlyPSFs', only the PSFs will
%                           be displayed.
%                           (default: show all)

if nargin==4
    quiet = 'blop';
end

nmToPixel = 1/5.0;
range = 1000*nmToPixel;
x = 1:range;
limitWidth = limitWidth_m*nmToPixel;

dlResponse = generateGaussianPSF_3d(range,[range/2 range/2 range/2],[limitWidth limitWidth limitWidth]);

% adding a wanted phase mask and computing the result on the image
ray = 400/1000;
phaseMask = getZernMask(aberration,range,ray,angle_deg,force,'quiet');
defocusMask = getZernMask('defocus',range,ray,angle_deg,force,'quiet');

phaseFactor = exp(1i.*phaseMask);
defocusFactor = exp(1i.*defocusMask);
dlResponse_FT = cell(range);
aberratedResponse_FT = cell(range);
aberratedResponse = cell(range);
abFreePSF = cell(range);
aberratedPSF = cell(range);

for i=1:range
    dlResponse_FT(i) = {ft2(dlResponse{i})};
    aberratedResponse_FT(i) = {dlResponse_FT{i}.*phaseFactor.*defocusFactor};
    aberratedResponse(i) = {ift2(aberratedResponse_FT{i})};
    
    abFreePSF(i) = {dlResponse{i}.*conj(dlResponse{i})};
    aberratedPSF(i) = {aberratedResponse{i}.*conj(aberratedResponse{i})};
end

for i=1:range
    if ~(strcmp(quiet,'onlyPSFs')||strcmp(quiet,'quiet'))
        % plotting the real and imaginary parts of the phase before and after the
        % mask, and the mask
        figure(444)
        subplot(2,3,2)
        pcolor(x,x,phaseMask), shading interp, axis square
        for j=1:range
            subplot(2,3,1)
            imshow(real(dlResponse_FT{j})),shading interp, axis square
            subplot(2,3,3)
            imshow(real(aberratedResponse_FT{j})),shading interp, axis square
            subplot(2,3,4)
            imshow(imag(dlResponse_FT{j})),shading interp, axis square
            subplot(2,3,6)
            imshow(imag(aberratedResponse_FT{j})),shading interp, axis square
        end
    end
    
    if ~strcmp(quiet,'quiet')
        figure(265)
        subplot(1,2,1)
        hold on
        title('aberration-free PSF')
        imshow(abFreePSF{i})
        plot(x,range/2,'y')
        plot(range/2,x,'y')
        hold off
        subplot(1,2,2)
        hold on
        title(strcat(aberration,strcat(num2str(angle_deg),'-aberrated PSF')))
        imshow(aberratedPSF{i})
        plot(x,range/2,'y')
        plot(range/2,x,'y')
        hold off        
    end
end

end


