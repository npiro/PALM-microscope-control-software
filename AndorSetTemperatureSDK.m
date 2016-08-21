function AndorSetTemperatureSDK(temp,wait)
% Set the CCD temeprature to the desired value

if (nargin == 1)
    wait = false;
elseif (nargin == 0)
    temp = -70;
    wait = false;
end

pMin = libpointer('int32Ptr',0);
pMax = libpointer('int32Ptr',0);
ret=calllib('ATMCD32D','GetTemperatureRange',pMin,pMax);
if ret ~= 20002
    error(['Error getting temperature range. Error code:',num2str(ret)]);
end
if pMin.Value > temp || pMax.Value < temp
    error('AndorSetTemperature: set temperature out of range.');
end
calllib('ATMCD32D','SetTemperature',temp);
calllib('ATMCD32D','CoolerON');
actualTempPtr = libpointer('int32Ptr',0);

calllib('ATMCD32D','GetTemperature',actualTempPtr);
actualTemp = get(actualTempPtr,'Value');
while abs(actualTemp - temp) > 5 && wait
    display (['Current temperature: ', num2str(actualTemp)]);
    pause(2);
    calllib('ATMCD32D','GetTemperature',actualTempPtr);
    actualTemp = get(actualTempPtr,'Value');
end