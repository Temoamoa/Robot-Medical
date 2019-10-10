function T=T_dh(alpha,d,r,q)
% Appel : T=dh(alpha,d,r,q)
%
% Retourne la matrice homogène obtenue par la méthode de Denavit-Hartenberg
% (DH) (voir chapitre 2 du cours). Les arguments de la
% fonction sont les paramètres de DH.


T = [cos(q)                  -sin(q)                 0               d;
    cos(alpha)*sin(q)      cos(alpha)*cos(q)       -sin(alpha)     -r*sin(alpha);
    sin(alpha)*sin(q)      sin(alpha)*cos(q)       cos(alpha)      r*cos(alpha);
        0                      0                        0               1];

end
