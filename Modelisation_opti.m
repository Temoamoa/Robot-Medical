clear all 
close all 
clc

% Constante du pb
rp = 0.005;  %rayon de la poulie (m)
r = 0.006;   %rayon du tube
L = 0.09;    %longueur du tube
d4 = 0.003;  %longueur du bras terminal au point 3


% discrétisation
n = 11;
% rotation moteur sur poulie
% dq = 2*r*theta/rp et theta compris entre 0 et pi/2, attention à la
% singularité en 0
dq = (2*r/rp)*linspace(-pi,pi,n);   


%% MGD
% MGD
% Espace accessible par le robot
Xp1 = zeros(1,n);
Yp1 = zeros(1,n);
Xp2 = zeros(1,n);
Yp2 = zeros(1,n);
for i = 1 : n
    [X,Y] = mgd_RPR(dq(i));
    Xp2(i) = X(2);
    Yp2(i) = Y(2);
    Xp1(i) = X(1);
    Yp1(i) = Y(1);
end

% Singularité en dq = 0
if mod(n,2) == 1
    Xp1(floor(n/2)+1) = 0;
    Yp1(floor(n/2)+1) = L;
    Xp2(floor(n/2)+1) = 0;
    Yp2(floor(n/2)+1) = L+d4;
end

%% Visualisation avec les barres
figure
for i = 1 : n
    % modele 1
%     X1 = [0 Xp1(i)];
%     Y1 = [0 Yp1(i)];
    % modele 2
    X2 = [0 Xp1(i) Xp2(i)];
    Y2 = [0 Yp1(i) Yp2(i)];
    hold on
    plot (X2,Y2)
end
hold off
title('Représentation du robot simplifié avec outil')

%% L'outil est tangent au corps du robot mou /// non représenté
% figure
% plot(Xp1,Yp1)

figure;
plot(Xp1,Yp1,'r',Xp2,Yp2,'b')
grid on
title('Espace géométrique accessible par le bras en fonction du modèle')
legend('Sans outil', 'Avec outil')

%% MCD
% Singularité en 0 tjrs
% for i = 1 : n
%     J = Jacobienne_RPR(dq(i));
% end

