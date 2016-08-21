%/***********************************************************************
%
%   mirrorDriverTest_1.m
%
%   matlab test script 
%
%   copyright (c) ADAPTICA 2009
%
%***********************************************************************/

clear all;
close all;
clc;

fprintf('*************************************************\n');
fprintf('*\n');
fprintf('* mirrorDriverTest_1 \n');
fprintf('*\n');
fprintf('* MATLAB API for Mirror Driver Test Procedure\n');
fprintf('* (c) ADAPTICA 2009\n');
fprintf('* \n');
fprintf('*************************************************\n');

fprintf('\n testing mirrorDriver functions: \n');
fprintf('\n press a key to start test\n');
pause;

%%%%%%%% data used for testing %%%%%%%%
testval = 0.33;
testchnum = 1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% init com & connect
connectToMirror;

%% get num of channels
numMirrorChannels = getNumMirrorChannels

%% get current driver vers
driverVers = getDriverVersion

fprintf('\n calling setMirrorSingleChannel for setting channels randomly...\n');
pause(1);
for i=0:numMirrorChannels-1
    setMirrorSingleChannel(rand, i);
end

fprintf('\n calling getMirrorSingleChannelStatus...\n');
pause(1);
chanStatus = getMirrorSingleChannelStatus(testchnum)

fprintf('\n calling getMirrorChannelsStatus...\n');
pause(1);

fprintf('\n deforming all channels randomly & getting status...\n');
figure(1)
pause(1);
for i=0:20
    for i=1:numMirrorChannels
        vals(i) = rand;
    end
    setMirrorChannels(vals);
    %vals = getMirrorChannelsStatus;
    plot(vals)    
    grid on;
    xlabel('channel num')
    ylabel('channel norm. value ')
    title('Mirror Current Status')
    pause(0.1);
end

pause(1);

fprintf('\n getting current IP... \n'); 
getLocalIp()

pause(1);
fprintf('\n set current IP to 192.168.0.1 \n'); 
setLocalIp('102.168.0.1')



fprintf('\n closing mirror connection... \n');    
pause(1);

closeMirror;


