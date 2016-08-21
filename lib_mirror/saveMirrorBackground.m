function saveMirrorBackground(voltageVect,filename)

makeTodaysDirectory();
todaysDate = datestr(now,'yyyy-mm-dd');

if nargin==1
    filename = 'bgdMirrorChannels';
end

filename = strcat('Z:\LEB\shared\NicolasPiro\mesures\',todaysDate,'\',filename,'.mat');
save(filename,'voltageVect');

setMirrorChannels(voltageVect);

end