function J = Jacobienne_RPR(dq)
% Appel : J = Jacobienne_RPR(q)
%
% Argument d'entrée : q = vecteur de dimension n=4 des variables articulaires
% Argument de sortie : matrice Jacobienne J du robot RPRR. % Dimensions de
% J : 6 x 3

% Nombre d'articulations
n=3;

% Constante
rp = 0.005;  %rayon de la poulie (m)
r = 0.006;   %rayon du tube
L = 0.09;    %longueur du tube
d4 = 0.003;  %longueur du bras terminal au point 3


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
T0t = T03*T34;

%%%%%%%%%%%%%%%%%%%%%%%%%%

type_arti = 'RPR';

J = zeros(6,n);
for i = 1 : n
    if type_arti(i) == 'R'
        T0i = eval(strcat('T0',num2str(i)));
        zi = T0i(1:3,4);
        li = T0t(1:3,4) - T0i(1:3,4);
        Ji = [cross(zi,li);zi];
        J(:,i) = Ji;
    else
        T0i = eval(strcat('T0',num2str(i)));
        zi = T0i(1:3,4);
        Ji = [zi;0;0;0];
        J(:,i) = Ji;
    end
end
    
end