function [Stot,cent]=RadialSymmetry(subim)
%Calculates the sum of radial variances of an image with respect to its 
%peak value point.
SX = size(subim,1);
SY = size(subim,2);

ImMinusBG=subim-min(subim(:));
[level,EM] = graythresh(ImMinusBG);
x = 1:SX;
y = 1:SY;
[X,Y]=meshgrid(x,y);

ImSm = smooth2a(ImMinusBG,3,3);
level = 0.7;

%bw = im2bw(ImSm,level);
bw = zeros(size(ImMinusBG));
bw(ImMinusBG>max(ImMinusBG(:))*0.5) = 1;
STATS = regionprops(bw, 'Centroid');
cent = STATS.Centroid;

%[M,I1] = max(ImMinusBG);
%[~,cent(2)] = max(M);
%cent(1) = I1(cent(2));
R = 1:1:20.0;
theta = 0:0.1:2*pi;
%maxI=max(ImMinusBG(:));
for i=1:length(R)
    XI = cent(1)+R(i)*cos(theta);
    YI = cent(2)+R(i)*sin(theta);

    Z=interp2(X,Y,ImMinusBG,XI,YI);
    
    S(i)=var(Z(~isnan(Z)));
end
Stot = sum(S);
