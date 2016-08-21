function [MaxIntensity] = MaximumIntensity(subim)
[maxRow rowInd] = max(subim); % Get maximum intensity;
[~, colInd] = max(maxRow);
rowInd = rowInd(colInd);
xRange = rowInd-1:rowInd+1;
xRange((xRange<1)|(xRange>size(subim,1)))=[];
yRange = colInd-1:colInd+1;
yRange((yRange<1)|(yRange>size(subim,2)))=[];
subsubim=subim(xRange,yRange);
MaxIntensity = mean(subsubim(:)); % Mean in few pixels around maximum intensity