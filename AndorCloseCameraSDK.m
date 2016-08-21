function AndorCloseCameraSDK

if ~libisloaded('ATMCD32D')
    loadlibrary('ATMCD32D.DLL','ATMCD32D.H');
end
AndorSwitchCoolerOff(true); 

calllib('ATMCD32D','ShutDown');