function [amplitudes] = AmplitudesFromShape(ShapeFunction)

if (~exist('PinvInfMat'))
    if (~exist('PinvInfMat.mat'))
        load zernCoeffs.mat;
        for i=1:length(PANarray)
            InfMat(i,:) = PANarray(i).infMat(:);
        end
        PinvInfMat = pinv(InfMat)';
        save PinvInfMat.mat PinvInfMat;
    else
        load PinvInfMat.mat;
    end
end


amplitudes = PinvInfMat*ShapeFunction(:);