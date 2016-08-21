function mask = getZernMask(mode,range,ray,angle_deg,steepness,quiet)
%computes and returns a square mask with specified Zernike mode shape

if nargin==4
    quiet='zob';
end

x = -1:2/(range-1):1;
angle_rad = angle_deg*pi/180;
[X,Y] = meshgrid(x,x);
mask = NaN(size(X));
z1 = NaN(size(X));
z2 = NaN(size(X));
[theta,R] = cart2pol(X,Y);
idx = R<=ray;

switch(mode)
    case 'tilt'
        zern = [1,2];
        zernM = zernfun2(zern,R(idx),theta(idx));
        z1(idx) = zernM(:,1);
        z2(idx) = zernM(:,2);
        mask = z1*cos(angle_rad) + z2*sin(angle_rad);
    case 'defocus'
        zern = [4];
        zernM = zernfun2(zern,R(idx),theta(idx));
        mask(idx) = zernM(:);
    case 'astigmatism'
        zern = [5,3];
        zernM = zernfun2(zern,R(idx),theta(idx));
        z1(idx) = zernM(:,1);
        z2(idx) = zernM(:,2);
        mask = z1*cos(angle_rad*2) + z2*sin(angle_rad*2);
end

% replace NaN by zero in the mask
blanks = isnan(mask);
mask(blanks)=0;
% normalizing to the constructor's max. phase
% mask = mask/max(max(mask))*4.1813E-7
mask = mask.*steepness;

if ~strcmp(quiet,'quiet')
    mask_size = [size(mask,1),size(mask,2)]
    figure(78)
    pcolor(x,x,mask), shading interp
end


end