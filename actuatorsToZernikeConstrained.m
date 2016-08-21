%function [ZtoA,resnorm,DesiredModes] = actuatorsToZernikeConstrained(order)
nargin=0; % Remove when uncommenting function
addpath('./lib_mirror');
addpath('./zern');
load('influence_matrix.mat');
NumZernikeModes = 15;

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
            line(k) = influence_matrix(index,i);
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
idx = r<=.95;
zernv = 1:32;

ValidInfluenceMatrix = influence_matrix(idx,:)*1e8;
mi=min(ValidInfluenceMatrix(:,4));
ma=max(ValidInfluenceMatrix(:,4));
ValidInfluenceMatrix=ValidInfluenceMatrix;
AmplitudesForEachZernikeMode = zeros(32,NumZernikeModes);
% computing and storing the zernike coeffs decomposition
oldopt=optimset('lsqlin');
opt=optimset(oldopt,'Diagnostics','on','LargeScale','on');
for m=1:NumZernikeModes
    coeffs = zeros(15,1);
    coeffs(m) = 1;
    ThisZernikeMode = ShapeFromZernikeCoefficients(coeffs, X, Y, idx, order);
    %ThisZernikeMode=-ThisZernikeMode+max(ThisZernikeMode(:));
    [AmplitudesForEachZernikeMode(:,m),resnorm(m),residual(:,m),exitflag(m),output(m),lambda(m)]=lsqlin(ValidInfluenceMatrix,ThisZernikeMode,[],[],[],[],-1*ones(32,1),ones(32,1),[],opt);
    DesiredModes(:,m) = ThisZernikeMode;
end
resnorm = resnorm';
%for i=1:32
%    infMatrix = PANarray(i).infMat;
%    a = zernike_coeffs3_const(infMatrix.*1E8,zernv,X,Y,idx,order,0); % Computed with influence in 10's of nm (1E-8 m)
%    PANarray(i).zernCoeffs(:) = a(:);
%    coeffs(i,:) = a(:);
%end

%pinvCoeffs = pinv(coeffs);

%ZtoA = coeffs(:,1:15);   % WRONG!! They should be inverted
%AtoZ = pinvCoeffs(1:15,:);
%AtoZ = (coeffs(:,1:15))';   
%ZtoA = (pinvCoeffs(1:15,:))';
ZtoA = AmplitudesForEachZernikeMode;
%save(ZtoA);



