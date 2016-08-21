function psf3d = generateGaussianPSF_3d(range,center,FWHM)
% Generates a square 3D Gaussian PSF. The peak
% amplitude is equal to 1.
% input:        range: width of the image in pixels
%               center: coordinates of the center in pixels
%                       1-by-3 array: [center_x,center_y,center_z]
%               FWHM: FWHM in pixels
%                     1-by-3 array: [FWHM_x,FWHM_y,FWHM_z]
% 
% output:       psf3d:  a one-dimensional [range]-long cell array. each
%                       cell is a [range]-by-[range] 2D double matrix
%                       representing a 'slice' along the Z-direction.

x = 1:range;
psf3d = cell(range);
% creates three gaussian function handles and evaluates it on the frame x
% (see gaussianCurve.m for details).
gx = gaussianCurve(center(1),1,FWHM(1));
gaussianEnvelope_x = gx(x);
gy = gaussianCurve(center(2),1,FWHM(2));
gaussianEnvelope_y = gy(x);
gz = gaussianCurve(center(3),1,FWHM(3));
gaussianEnvelope_z = gz(x);
% generates two square matrices by repeating the two gaussian functions
% alongside their destined axes
yop = repmat(gaussianEnvelope_x,range,1);
yap = repmat(gaussianEnvelope_y.',1,range);
% And bee-bidy-ba-bidy-boo: the center 2D PSF (at Z=center_z)
img = yop.*yap;
% Then the 3D PSF, obtained by multiplying img by a repetition of gz along
% the Z-axis
for i=1:range
    psf3d(i) = {img*gaussianEnvelope_z(i)};
%     figure(888)
%     imshow(psf3d{i});
end

end
