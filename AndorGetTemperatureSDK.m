function actualTemp = AndorGetTemperatureSDK
actualTempPtr = libpointer('int32Ptr',0);

calllib('ATMCD32D','GetTemperature',actualTempPtr);
actualTemp = get(actualTempPtr,'Value');