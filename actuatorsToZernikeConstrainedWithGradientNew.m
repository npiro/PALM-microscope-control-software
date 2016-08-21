%function [ZtoA,resnorm,DesiredModes] = actuatorsToZernikeConstrainedWithGradient(order)
nargin=0; % Remove when uncommenting function
addpath('./lib_mirror');
addpath('./zern');
load('C:\Documents and Settings\laboleb\My Documents\Adaptica_Controls\SaturnMirror\SAT_1107000001\Influence Matrix\influence_matrix.mat');
NumZernikeModes = 15;
wavelength = 633e-9;

if(nargin==0)
    order='default';
end

PANarray = actuator.empty(0,1);
coeffs = nan(32,32);

for i=1:64
    PANarray(i).id = i;
    line = nan(1,120);
    for j=1:120
        for k=1:120 % fills the 'line' array with the j(th) 120-long part of the influence matrix
            index = (j-1)*120+k;
            line(k) = influence_matrix(index,i)/wavelength;
        end
        % replaces NaN by zero in the matrix
        nanidx = isnan(line);
        line(nanidx) = 0;
        % fills the infMat line with the corresponding influence data
        PANarray(i).infMat(j,:) = line(:);
    end
    [PANarray(i).DXinfMat,PANarray(i).DYinfMat] = gradient(PANarray(i).infMat);
    
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
%x = -1:1/60:59/60;
%step=double(2/119);
x = -1:2/119:1;
[X,Y] = meshgrid(x,x);
[theta,r] = cart2pol(X,Y);
valid = r<=1.0;
idx = r<=1.0;
idx2=[idx,idx];
idx2l=[idx(:),idx(:)];
zernv = 1:32;

for i=1:length(PANarray)
    PANarray(i).DXinfMat(~idx)=0;
    PANarray(i).DYinfMat(~idx)=0;
    DerivInfluenceMatrix(:,i) = [PANarray(i).DXinfMat(:);PANarray(i).DYinfMat(:)];
end
%ValidInfluenceMatrix = influence_matrix(idx,:)*1e8;
ValidInfluenceMatrixGradient = DerivInfluenceMatrix(idx2,:);
%mi=min(ValidInfluenceMatrix(:,4));
%ma=max(ValidInfluenceMatrix(:,4));
%ValidInfluenceMatrix=ValidInfluenceMatrix;
AmplitudesForEachZernikeMode = zeros(64,NumZernikeModes);
% computing and storing the zernike coeffs decomposition
oldopt=optimset('lsqlin');
opt = optimset('Display','final','TolFun',1e-50,'Jacobian','on','LargeScale','on','Diagnostics','on');

%opt=optimset(oldopt,'Diagnostics','on','LargeScale','on','Display','iter');
for m=2:NumZernikeModes
    display(m);
    coeffs = zeros(15,1);
    coeffs(m) = 0.1;
    
    ThisZernikeMode = ShapeFromZernikeCoefficients(coeffs, X, Y, valid, order);
    ThisZernikeModeNeg = -ThisZernikeMode;
    %if (m == 4)
    %    ThisZernikeMode=ThisZernikeMode;
    %end
    ThisZernikeModeSq = zeros(120,120);
    ThisZernikeModeSqNeg = zeros(120,120);
    ThisZernikeModeSq(valid) = ThisZernikeMode;
    ThisZernikeModeSqNeg(valid) = ThisZernikeModeNeg;
    [DX,DY]=gradient(ThisZernikeModeSq);
    [DXn,DYn]=gradient(ThisZernikeModeSqNeg);
    DX(~idx)=0;
    DY(~idx)=0;
    DXn(~idx)=0;
    DYn(~idx)=0;
    ThisZernikeModeGradient=[DX(:);DY(:)];
    ThisZernikeModeGradientNeg=[DXn(:);DYn(:)];
    %ThisZernikeModeGradient(~idx2)=0;
    ThisZernikeModeGradient=ThisZernikeModeGradient(idx2l);
    ThisZernikeModeGradientNeg=ThisZernikeModeGradientNeg(idx2l);
    %ThisZernikeMode=-ThisZernikeMode+max(ThisZernikeMode(:));
    %[AmplitudesForEachZernikeMode(:,m),resnorm(m),residual(:,m),exitflag(m),output(m),lambda(m)]=lsqlin(ValidInfluenceMatrix,ThisZernikeMode,[],[],[],[],-1*ones(32,1),ones(32,1),[],opt);
    [AmplitudesForEachZernikeMode(:,m),resnorm(m),residual(:,m),exitflag(m),output(m),lambda(m)]=lsqlin(ValidInfluenceMatrixGradient,ThisZernikeModeGradient,[],[],[],[],0*ones(64,1),5*ones(64,1),0.5*ones(64,1),opt);
    [AmplitudesForEachZernikeModeNeg(:,m),resnormNeg(m),residualNeg(:,m),exitflagNeg(m),outputNeg(m),lambdaNeg(m)]=lsqlin(ValidInfluenceMatrixGradient,ThisZernikeModeGradientNeg,[],[],[],[],0*ones(64,1),5*ones(64,1),0.5*ones(64,1),opt);
    
    DesiredModes(:,m) = ThisZernikeMode;
    DesiredModesGradient(:,m) = ThisZernikeModeGradient;
    DesiredModesNeg(:,m) = ThisZernikeModeNeg;
    DesiredModesGradientNeg(:,m) = ThisZernikeModeGradientNeg;
    surface = zeros(120,120);
    for i=1:64
        surface = surface + AmplitudesForEachZernikeMode(i,m)*PANarray(i).infMat;
    end
    figure(1);
    surf(surface);
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
AtoZ = pinv(ZtoA);
ZtoANeg = AmplitudesForEachZernikeModeNeg;
AtoZNeg = pinv(ZtoANeg);

%[ZtoA,ZtoANeg] = actuatorToZernikeFromSaturnData(ZtoA,ZtoANeg);
save('zernCoeffs.mat','PANarray','ZtoA','AtoZ','ZtoANeg','AtoZNeg');



