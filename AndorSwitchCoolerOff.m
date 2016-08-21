function AndorSwitchCoolerOff(wait)
if (nargin == 0)
    wait = true;
end

ret=calllib('ATMCD32D','CoolerOFF');
if ret ~= 20002
    error('Error switching off cooler in function AndorSwitchCoolerOff');
end

actualTempPtr = libpointer('int32Ptr',0);
if wait
    calllib('ATMCD32D','GetTemperature',actualTempPtr);
    actualTemp = get(actualTempPtr,'Value');
    while actualTemp < 0
        display (['Current temperature: ', num2str(actualTemp),'. Waiting until temperature reaches 0 deg.']);
        pause(1);
        calllib('ATMCD32D','GetTemperature',actualTempPtr);
        actualTemp = get(actualTempPtr,'Value');
    end    
end