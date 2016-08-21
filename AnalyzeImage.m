function [MeritFunction,STATS] = AnalyzeImage(filename,draw);
if nargin < 2
    draw = false;
end
im=double(imread(filename));
MaxI = double(max(im(:)));
MinI = double(min(im(:)));
threshold=0.3*(MaxI+MinI)/MaxI;
BImage = im2bw(double(im)/MaxI,threshold);

BW = ~ BImage;
[B,L] = bwboundaries(BImage, 'noholes');
STATS = regionprops(L,im, {'Area','Eccentricity','MaxIntensity'});
Areas = STATS(:).Area;
[MaxA,MaxI]=max(Areas);
BiggestElem = STATS(MaxI);
MeritFunction = (BiggestElem.Eccentricity)*(BiggestElem.MaxIntensity)/BiggestElem.Area;
if (draw)
    subplot(2,1,1);
    image(im);
    axis image;
    subplot(2,1,2);
    imshow(BImage);
    axis image;
    colormap jet
end



