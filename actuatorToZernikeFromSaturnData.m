function [ZtoA,ZtoANeg] = actuatorToZernikeFromSaturnData(ZtoA,ZtoANeg)
dir = 'C:\Documents and Settings\laboleb\My Documents\Adaptica_Controls\SaturnMirror\InvertedModes\Nico';


%if (~exist('ZtoA'))
    ZtoA = zeros(64,15);
    ZtoANeg = zeros(64,15);
%end
load([dir,'\','mode_2.mat']);
ZtoA(:,2)=mirrorchannelvalues;
load([dir,'\','mode_-2.mat']);
ZtoANeg(:,2)=mirrorchannelvalues;
load([dir,'\','mode_3.mat']);
ZtoA(:,3)=mirrorchannelvalues;
load([dir,'\','mode_-3.mat']);
ZtoANeg(:,3)=mirrorchannelvalues;
load([dir,'\','mode_5.mat']);
ZtoA(:,4)=mirrorchannelvalues;
load([dir,'\','mode_-5.mat']);
ZtoANeg(:,4)=mirrorchannelvalues;
load([dir,'\','mode_4.mat']);
ZtoA(:,5)=mirrorchannelvalues;
load([dir,'\','mode_-4.mat']);
ZtoANeg(:,5)=mirrorchannelvalues;
load([dir,'\','mode_6.mat']);
ZtoA(:,6)=mirrorchannelvalues;
load([dir,'\','mode_6.mat']);
ZtoANeg(:,6)=mirrorchannelvalues;
load([dir,'\','mode_8.mat']);
ZtoA(:,7)=mirrorchannelvalues;
load([dir,'\','mode_-8.mat']);
ZtoANeg(:,7)=mirrorchannelvalues;
load([dir,'\','mode_9.mat']);
ZtoA(:,8)=mirrorchannelvalues;
load([dir,'\','mode_-9.mat']);
ZtoANeg(:,8)=mirrorchannelvalues;
load([dir,'\','mode_7.mat']);
ZtoA(:,9)=mirrorchannelvalues;
load([dir,'\','mode_7.mat']);
ZtoANeg(:,9)=mirrorchannelvalues;
load([dir,'\','mode_10.mat']);
ZtoA(:,10)=mirrorchannelvalues;
load([dir,'\','mode_-10.mat']);
ZtoANeg(:,10)=mirrorchannelvalues;
load([dir,'\','mode_13.mat']);
ZtoA(:,11)=mirrorchannelvalues;
load([dir,'\','mode_-13.mat']);
ZtoANeg(:,11)=mirrorchannelvalues;
%ZtoA(11)=voltage_deformation.voltage_spherical;
%ZtoA(12)=voltage_deformation.voltage_secondary_astigmatism;
%ZtoA(13)=voltage_deformation.secondary_astigmatism;
load([dir,'\','mode_15.mat']);
ZtoA(:,15)=mirrorchannelvalues;
load([dir,'\','mode_-15.mat']);
ZtoANeg(:,15)=mirrorchannelvalues;
%ZtoA(:,14)=voltage_deformation.voltage_quadrafoil_60;
%ZtoANeg(14)=voltage_deformation.voltage_quadrafoil_90;
%ZtoA(:,15)=voltage_deformation.voltage_quadrafoil_0;
if (nargin == 0)
    save('zernCoeffs.mat','PANarray','ZtoA','AtoZ','ZtoANeg','AtoZNeg');
end
