function PSFstackToTiff(filenameIn,filenameOut)
% Reconstructs from the measured PSF a 3D PSF and finds its focal plane.
% PSF3D is the stack of arrays representing the 3D PSF.
% FocusIndex is the index of the focal plane
PSF=dlmread(filenameIn);
[X,Y]=size(PSF);
Ma = max(PSF(:));
Mi = min(PSF(:));
clear('PSF3D');
for i=1:int32(X/Y)
    thisMat = PSF(1+Y*(i-1):Y*i,:);
    %PSF3D(:,:,i)=smooth2a(thisMat,2,2);
    %[M(i),I(i)]=max(thisMat(:));
    imshow(thisMat/Ma);
    axis off;
    if i==1
        export_fig(filenameOut);
    else
        export_fig('-append', filenameOut);
    end
    if i==20
        break;
    end
end


