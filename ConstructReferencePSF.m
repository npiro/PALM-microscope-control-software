function [PSF3D,FocusIndex,MaxX,MaxY] = ConstructReferencePSF
% Reconstructs from the measured PSF a 3D PSF and finds its focal plane.
% PSF3D is the stack of arrays representing the 3D PSF.
% FocusIndex is the index of the focal plane
PSF=dlmread('ReferencePSF.dat');
[X,Y]=size(PSF);
Ma = max(PSF(:));
Mi = min(PSF(:));
clear('PSF3D');
for i=1:int32(X/Y)
    thisMat = PSF(1+Y*(i-1):Y*i,:);
    PSF3D(:,:,i)=smooth2a(thisMat,2,2);
    [M(i),I(i)]=max(thisMat(:));
    %imshow(thisMat/Ma);
    %axis off;
    %if i==1
    %    export_fig PSF3D.tiff;
    %else
    %    export_fig -append PSF3D.tiff;
    %end
end

[MaxInt,FocusIndex] = max(M);
MaxX = mod(I(FocusIndex),Y);
MaxY = int32(I(FocusIndex)/Y);

