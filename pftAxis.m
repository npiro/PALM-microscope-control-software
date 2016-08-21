% pftAxis crée deux tableaux (fréquence et temps) calibrés
% nPoints : Nombre de points (en général une puissance de 2)
% nuMax   : Valeur maximale de la fréquence
% nuMin: valeur minimale de la fréquence
% nu : Axe des fréquences. Le point d'indice nPoints/2 vaut toujours 0
% t  : Axe des temps. Le point d'indice nPoints/2 vaut toujours 0

function [nu, t] = pftAxis(nPoints, nuMin, nuMax)

deltaNu = (nuMax-nuMin)/nPoints;
deltaT = 1/(nuMax-nuMin);
nu = nuMin:deltaNu:nuMax-deltaNu;
t = -nPoints/2*deltaT:deltaT:(nPoints/2-1)*deltaT;
