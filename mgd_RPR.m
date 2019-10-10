function [X,Y] = mgd_RPR(dq)
%% MGD
% MGD
% Espace accessible par le robot
rp = 0.005;  %rayon de la poulie (m)
r = 0.006;   %rayon du tube
L = 0.09;    %longueur du tube
d4 = 0.003;  %longueur du bras terminal au point 3

k = rp*(dq)/(L*r);

thet1 = k*L/2;         %angle 1
thet3 = thet1;         %angle 3

d2 = abs((2/k)*sin(thet1));

T01= T_dh(0,0,0,thet1);
T12 = T_dh(-pi/2,0,d2,0);
T23 = T_dh(pi/2,0,0,thet3);
T34 = T_dh(-pi/2,0,d4,0);

T02 = T01*T12;
T03 = T02*T23;
T04 = T03*T34;

P3 = [T03(1,4), T03(2,4)];
P4 = [T04(1,4), T04(2,4)];

%Zone accessible selon le modèle
% modele 1: outil directement sur le bout 
Xp1 = P3(1);
Yp1 = P3(2);

% modele 2: outil à une distance d4 du bout 
Xp2 = P4(1);
Yp2 = P4(2);

X = [Xp1, Xp2]';
Y = [Yp1, Yp2]';

end