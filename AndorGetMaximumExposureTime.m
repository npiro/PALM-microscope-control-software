function [maxExposureTime] =  AndorGetMaximumExposureTime


pMax = libpointer('singlePtr',0.0);
calllib('ATMCD32D','GetMaximumExposure',pMax);


maxExposureTime = pMax.Value;