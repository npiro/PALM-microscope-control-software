% pftAxis cr�e deux tableaux (fr�quence et temps) calibr�s
% nPoints : Nombre de points (en g�n�ral une puissance de 2)
% nuMax   : Valeur maximale de la fr�quence
% nuMin: valeur minimale de la fr�quence
% nu : Axe des fr�quences. Le point d'indice nPoints/2 vaut toujours 0
% t  : Axe des temps. Le point d'indice nPoints/2 vaut toujours 0

function [nu, t] = pftAxis(nPoints, nuMin, nuMax)

deltaNu = (nuMax-nuMin)/nPoints;
deltaT = 1/(nuMax-nuMin);
nu = nuMin:deltaNu:nuMax-deltaNu;
t = -nPoints/2*deltaT:deltaT:(nPoints/2-1)*deltaT;
