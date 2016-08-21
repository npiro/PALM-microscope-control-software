function [actualTemp] = GetTemperatureSDK

calllib('ATMCD32D','GetTemperature',actualTempPtr);
actualTemp = get(actualTempPtr,'Value');