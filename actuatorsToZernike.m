function coeffs = actuatorsToZernike(order)
% Takes the influence matrix data and decomposes the influence
% phase of each actuator of the IO32 PAN mirror onto the First ten Zernike
% functions.
%coeffs = actuatorsToZernike(order)
% Input:        order  = the order convention for Zernike functions (see
%                        'zernike_coeffs3').
% Dimensionality: 
% - maximum stroke of an actuator: ~14 microns -> max phase
% added/subtracted: typ. ~30 microns
% - maximum phase in the constructor's influence matrix: 0.41813 microns
% (4.1813E-7 m)
% - phase in microns
% - ZernCoeffs amplitude: 0 <--> 0V
%                         1 <--> 250V

addpath('./lib_mirror');
addpath('./zern');
load('influence_matrix.mat');

if(nargin==0)
    order='default';
end

PANarray = actuator.empty(0,1);
coeffs = nan(32,32);

for i=1:32
    PANarray(i).id = i;
    line = nan(1,120);
    for j=1:120
        for k=1:120 % fills the 'line' array with the j(th) 120-long part of the influence matrix
            index = (j-1)*120+k;
            line(k) = influence_matrix(index,i)-3.1464e+005;
        end
        % replaces NaN by zero in the matrix
        nanidx = isnan(line);
        line(nanidx) = 0;
        % fills the infMat line with the corresponding influence data
        PANarray(i).infMat(j,:) = line(:);
    end
    
    % plotting and saving 2D plots of the current actuator's influence matrix
%     figure(1000)
%     pcolor(PANarray(i).infMat);
%     if i<10
%         saveas(figure(1000),['./influences/actu0' num2str(i) '.png']);
%     else
%         saveas(figure(1000),['./influences/actu' num2str(i) '.png']);
%     end
% 
%     % plotting and saving 3D plots of the current actuator's influence matrix
%     figure(1000)
%     surf(PANarray(i).infMat,'meshStyle','row');
%     if i<10
%         saveas(figure(1000),['./influences/actu0' num2str(i) '.fig']);
%     else
%         saveas(figure(1000),['./influences/actu' num2str(i) '.fig']);
%     end    
end

% Preparing the zernike_coeffs3 input parameters
x = -1:1/60:59/60;
[X,Y] = meshgrid(x,x);
[theta,r] = cart2pol(X,Y);
idx = r<=1;
zernv = 1:32;

% computing and storing the zernike coeffs decomposition
for i=1:32
    infMatrix = PANarray(i).infMat;
    a = zernike_coeffs3_const(infMatrix.*1E8,zernv,X,Y,idx,order,0); % Computed with influence in 10's of nm (1E-8 m)
    PANarray(i).zernCoeffs(:) = a(:);
    coeffs(i,:) = a(:);
end

pinvCoeffs = pinv(coeffs);

%ZtoA = coeffs(:,1:15);   % WRONG!! They should be inverted
%AtoZ = pinvCoeffs(1:15,:);
AtoZ = (coeffs(:,1:15))';   
ZtoA = (pinvCoeffs(1:15,:))';
%ZtoA(:,1) = 1;


save('zernCoeffs.mat','PANarray','ZtoA','AtoZ');

end