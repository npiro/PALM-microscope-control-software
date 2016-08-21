function psf = generateGaussianPSF(range,center,FWHM)
% Generates a square 2D Gaussian PSF. The peak
% amplitude is equal to 1.
% input:        range: width of the image in pixels
%               center: coordinates of the center in pixels
%                       1-by-2 array: [center_x,center_y,center_z]
%               FWHM: FWHM in pixels
%                     1-by-2 array: [FWHM_x,FWHM_y,FWHM_z]
% 
% output:       psf:  a 2D [range]-by-[range] double array.

x = 1:range;
% creates three gaussian function handles and evaluates it on the frame x
% (see gaussianCurve.m for details).
gx = gaussianCurve(center(1),1,FWHM(1));
gaussianEnvelope_x = gx(x);
gy = gaussianCurve(center(2),1,FWHM(2));
gaussianEnvelope_y = gy(x);
% generates two square matrices by repeating the two gaussian functions
% alongside their destined axes
yop = repmat(gaussianEnvelope_x,range,1);
yap = repmat(gaussianEnvelope_y.',1,range);
% And bee-bidy-ba-bidy-boo: the center 2D PSF (at Z=center_z)
psf = yop.*yap;

end
