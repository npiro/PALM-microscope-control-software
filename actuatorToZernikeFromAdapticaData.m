function [ZtoA,ZtoANeg] = actuatorToZernikeFromAdapticaData(ZtoA,ZtoANeg)
load 'C:\Documents and Settings\laboleb\My Documents\Adaptica_Controls\DEMO\AOfiles\voltage_deformation.mat'

if (~exist('ZtoA'))
    ZtoA = zeros(15,32);
end
ZtoA(:,2)=voltage_deformation.voltage_tilt_0;
ZtoANeg(:,2)=voltage_deformation.voltage_tilt_180;
ZtoA(:,3)=voltage_deformation.voltage_tilt_90;
ZtoANeg(:,3)=voltage_deformation.voltage_tilt_270;
ZtoA(:,4)=voltage_deformation.voltage_defocus;
%ZtoANeg(4)=voltage_deformation.voltage_defocus;
ZtoA(:,5)=voltage_deformation.voltage_astigmatism_45;
ZtoANeg(:,5)=voltage_deformation.voltage_astigmatism_135;
ZtoA(:,6)=voltage_deformation.voltage_astigmatism_0;
ZtoANeg(:,6)=voltage_deformation.voltage_astigmatism_90;
ZtoA(:,7)=voltage_deformation.voltage_coma_0;
ZtoANeg(:,7)=voltage_deformation.voltage_coma_180;
ZtoA(:,8)=voltage_deformation.voltage_coma_90;
ZtoANeg(:,8)=voltage_deformation.voltage_coma_270;
ZtoA(:,9)=voltage_deformation.voltage_trefoil_0;
%ZtoANeg(9)=voltage_deformation.voltage_trefoil_0;
ZtoA(:,10)=voltage_deformation.voltage_trefoil_60;
%ZtoANeg(10)=voltage_deformation.voltage_trefoil_60;
%ZtoA(11)=voltage_deformation.voltage_spherical;
%ZtoA(12)=voltage_deformation.voltage_secondary_astigmatism;
%ZtoA(13)=voltage_deformation.secondary_astigmatism;
ZtoA(:,14)=voltage_deformation.voltage_quadrafoil_60;
%ZtoANeg(14)=voltage_deformation.voltage_quadrafoil_90;
ZtoA(:,15)=voltage_deformation.voltage_quadrafoil_0;
