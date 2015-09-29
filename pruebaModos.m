% Prueba modos 

numeroModo = 1;
xi = 0.02;
f = 1;
numNodos = 10; % esto coger del unv de la geometría


puntos = [(linspace(0,pi,numNodos))' zeros(10,2)];
unvWriter(puntos,'geomModos')

datos = zeros(numNodos, 6);
datos(:,3) = sin(puntos(:,1));

modosUnv(numeroModo, f, xi, numNodos,datos,'modoComplejo')