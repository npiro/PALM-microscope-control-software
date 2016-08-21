function [mmc] = AndorCloseCamera(mmc)
if nargin ~= 1
    error('AndorCloseCamera requires one argument. Syntax: AndorCloseCamera(mmc,ExposureTime)');
end
mmc.unloadAllDevices();
