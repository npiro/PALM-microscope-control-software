function AndorSetEMGainSDK(Gain)

GainLow = libpointer('int32Ptr',0);
GainHigh = libpointer('int32Ptr',0);
calllib('ATMCD32D','GetEMGainRange',GainLow,GainHigh);

if Gain < GainHigh.Value && Gain > GainLow.Value
    calllib('ATMCD32D','SetEMCCDGain',Gain);
else
    error(['EM Gain out of range. Min value: ',num2str(GainLow.Value),' EM Maximum value:', num2str(GainHigh.Value), 'EM Gain: ', num2str(Gain)]);
end

