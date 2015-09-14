clear
clc

% Radio de la pieza

r = 80;

% Número de vueltas

n = 1;


% Puntos en cada vuelta

p = 16;

puntos = zeros(n*p,2);

alfa = - 360/p;
A = [cosd(alfa) -sind(alfa);
     sind(alfa)  cosd(alfa)];

for kont2 = 1:n

    a = kont2*r/n;
    inicial = [0 a]'; % empieza en la vertical
    puntos(p*(kont2-1)+1,:)= inicial;
    
    for kont = 1:(p-1)

        final = A*inicial;
        
        puntos(p*(kont2-1)+ 1 + kont,:)= final;

        hold on
        
        inicial = final;

    end

end

puntos(abs(puntos)<10^-4)=0;

plot(puntos(:,1), puntos(:,2),'o'), xlim([-r,r]),ylim([-r,r])
axis equal

puntos = [puntos zeros(length(puntos),1)]; 

unvWriter(puntos,'geometria')

