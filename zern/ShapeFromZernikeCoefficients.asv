function F = ShapeFromZernikeCoefficients(coeff, X, Y, valid, order)
% Represent a wavefront as a sum of Zernike polynomials with a constant offset using a matrix inversion.
%   Modified for selectable ordering
%function a = zernike_coeffs3(phi, zernv, X, Y, valid, order)
%
% Description: Represent a wavefront as a sum of Zernike polynomials using
%              a matrix inversion.
% 
% Input:    coeff - List of Zernike coefficients from which to compose
%                   shape
%           X,Y = 2D coordinate arrays, as created by meshgrid(x1D,y1D),
%                 normalized to the unit circle.
%           valid = 2D array of 0 and 1 identifying the valid points for
%                 computation of the Zernike polynominal. Normally, this is the
%                 set of points with radii <= 1.0.
%                 X, Y, and Valid must be the same size
%           order (optional) identifies the ordering scheme (per zernfun2A.m)
%             'noll'    = Bob Noll's original ordering
%             'fringe'  = Univ. of Arizona Zernike set
%             'original'= original order of zernfun.m
%             'default' = The is the default ordering
%                       = the 'fringe' (UofA) set + more terms
%             All of these orders are numbered starting from 1, to simplify this code
%             offset is a constant offset to add to Zernike polynomial functions.
%             if set to -1, the minimum value of the entire Zernike set is
%             applied.
% Output:   F(i) - vector of shape function
%
% Description: Composes a wavefront from a list of Zernike coefficients.
% 

%
% Note: zernfun.m & zernike_fcn3.m are required. 
%       zernfun.m is available here: 
%         http://www.mathworks.com/matlabcentral/fileexchange/7687 
%
% Original By: Christopher Wilcox and Freddie Santiago
% Feb 18 2010
% Naval Research Laboratory
% 
% 2010 Aug 18  Carey Smith
%   Eliminate the padding to a 2D array when computing the inverse & a.  
%   Just use 1-d vectors over the area inside the unit circle
%   Calls zernike_fcn3(), in order to be self-consistent on the polynomial ordering.
% 2010 Aug 30  Carey Smith
%   Specify X, Y & valid, so that this is consistent with the calling program.
%

% Checks
if(nargin < 6)
    order = 'default';
else
  if(isempty(order))
    order = 'default';
  end
end

if size(coeff,1) ~= 15 && size(coeff,2) ~= 1
    error('coeff must be a 16 x 1 vector');
end
zernv = 1:15;
if exist('zernike_fcn3.m','file') > 0
  zern_modes = zernike_fcn3(zernv, X, Y, valid, order);
  %ind=find(zernv~=1);

  %zern_modes(:,ind) = zern_modes(:,ind) + 1;

else
  error('zernike_fcn3.m does not exist in your path!');
end
%if constant == -1
%    offset = -min(zern_modes(:));
%else
%    offset = constant;
%end
%zern_modes = zern_modes + offset;
%phi1D = phi(valid);  % Just get the points of phi inside the unit circle--same as the Zernikes
% disp(['size(zern_modes)  = ',int2str(size(zern_modes)),', size(pinv(zern_modes))  = ',int2str(size(pinv(zern_modes))),', size(phi1D) = ',int2str(size(phi1D))]) % DEBUG
%     zern_modes(p x q) * a(q x 1) = phi1D(p x 1)
% ==> a(q x 1) = pinv(zern_modes)(q x p) * phi1D(p x 1)

%a = pinv(zern_modes)*phi1D;
F = zern_modes*coeff;

