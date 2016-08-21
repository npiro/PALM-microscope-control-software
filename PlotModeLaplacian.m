coeffs = zeros(15,1);
m=ModeNumber.TiltY;m=15;
coeffs(m) = 1;
x = -1:1/60:59/60;
[X,Y] = meshgrid(x,x);
[theta,r] = cart2pol(X,Y);
valid = r<=1.0;
idx = r<=.95;
ThisZernikeMode = -ShapeFromZernikeCoefficients(coeffs, X, Y, valid, 'default');
ThisZernikeModeSq = nan(120,120);
ThisZernikeModeSq(valid) = ThisZernikeMode;


Lap=del2(ThisZernikeModeSq);
%DX(~idx)=nan;
%DY(~idx)=nan;
subplot(2,1,1)
surf(X,Y,ThisZernikeModeSq)
subplot(2,1,2)
surf(X,Y,Lap)