% ftAxis cr�e deux tableaux (fr�quence et temps) calibr�s
% nPoints : Nombre de points (en g�n�ral une puissance de 2)
% nuMax   : Valeur maximale de la fr�quence
% nu : Axe des fr�quences. Le point d'indice nPoints/2 vaut toujours 0
% t  : Axe des temps. Le point d'indice nPoints/2 vaut toujours 0

function [nu, t] = ftAxis(nPoints, nuMax)

deltaNu = 2*nuMax/nPoints;
deltaT = 1/(2*nuMax);

nu = -nuMax:2*nuMax/nPoints:nuMax-(2*nuMax/nPoints);
t = -nPoints/2*deltaT:deltaT:(nPoints/2-1)*deltaT;