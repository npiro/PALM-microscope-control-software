function setMirrorBackground(filename)

makeTodaysDirectory();
todaysDate = datestr(now,'yyyy-mm-dd');

if nargin==0
    name = 'bgdMirrorChannels';
end

filename = strcat('Z:\Alexandre-Mougel\mesures\',todaysDate,'\',name,'.mat');

if exist(filename,'file')==2
    load(filename);
else
    voltageVect = zeros(1,32);
    saveMirrorBackground(voltageVect,name);
end

setMirrorChannels(voltageVect);

end