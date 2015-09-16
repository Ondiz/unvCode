function modosUnv(numeroModo, f, xi, numNodos, datos, nombreArchivo, opcion)

% Escribe un modo en un unv (tipo de dato 55).
% Datos:
% numeroModo: n�mero del modo
% f: frecuencia en Hz
% xi: amortiguamiento en tanto por 1
% numNodos: n�mero de nodos del sistema
% datos: matriz de 6 columnas Re(x), Im(x), Re(y), Im(y), Re(z), Im(z)
% desplazamiento del modo en cada nodo (con el mismo orden de numNodos)
% nombreArchivo: nombre del archivo sin la extensi�n unv
% opcion: 'w' para crear el archivo y 'a' para a�adir modo a un archivo
% existente

% Datos

omega = 2*pi*f;
eig = -xi*omega + sqrt(1-xi^2)*omega*i;
nodos = 1:numNodos;

% Archivo donde escrbir
fid = fopen([nombreArchivo '.unv'], opcion); % poner opci�n 'a' para append y 'w' para crear

% Primera l�nea: -1
fprintf(fid,'%6i%74s\n',-1,' '); % l�neas de 80 caracteres donde -1 ocupa los 6 primeros

fprintf(fid,'%6i%74s\n',55,' '); % segunda l�nea 55 (valores de datos en los nodos)

% Siguientes 5 l�neas NONE porque no pueden estar en blanco(en Reflex escribe el m�todo de c�lculo, autor, ...)

fprintf(fid,'%-80s\n','NONE'); % 40A2 40 caracteres alfanum�ricos de 2 de largo cada uno
fprintf(fid,'%-80s\n','NONE'); 
fprintf(fid,'%-80s\n','NONE'); 
fprintf(fid,'%-80s\n','NONE'); 
fprintf(fid,'%-80s\n','NONE'); 

% La siguiente l�nea tiene 6 d�gitos: 
%
% #1: tipo de modelo:
%     0: desconocido
%     1: estructural
%     2: transmisi�n de calor
%     3: fluido
% 
% #2: tipo de an�lisis:
%     0: desconocido
%     1: est�tico
%     2: modos normales 
%     3: modos complejos de primer orden
%     4: transitorio
%     5: respueta en frecuencia
%     6: pandeo
%     7: modos complejos segundo orden
%
% #3: datos
%     0: desconocido
%     1: escalar
%     2: vector de traslaci�n de 3 gdl
%     3: vector de traslaci�n y rotaci�n de 6 gdl
%     4: tensor sim�trico
%     5: tensor general
%
% #4: tipo de respuesta
%     0: desconocida
%     1: general
%     2: tensi�n
%     3: deformaci�n
%     4: fuerza
%     5: temperatura
%     6: flujo de calor
%     7: energ�a de deformaci�n
%     8: desplazamiento
%     9: fuerza de reacci�n
%     10: energ�a cin�tica
%     11: velocidad
%     12: aceleraci�n
%     13: densidad de energ�a de deformaci�n
%     14: densidad de energ�a cin�tica
%     15: presi�n hidrost�tica
%     16: gradiente de calor
%     17: Code Checking Value (d�gito de control?)
%     18: coeficiente de presi�n
%
% #5: tipo de datos
%     2: reales
%     5: complejos
% #6: n�mero de datos por nodo (gdls)

% Un caso t�pico es:   1         3         2         8         5         3

fprintf(fid,'%10i%10i%10i%10i%10i%10i\n',1,3,2,8,5,3); % para caso t�pico de modos complejos

formato = '%13.5e'; % formato de los n�meros E13.5 

% Modos complejos
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Datos del modo

fprintf(fid,'%10i%10i%10i%10i\n',2,6,0,numeroModo); 

% 1#: 2
% 2#: 6
% 3#: Caso de carga 
% 4#: N�mero del modo

% Valor propio y tal

fprintf(fid,[formato formato formato formato formato formato '\n'],real(eig),imag(eig),0,0,0,0); 

% Para cada nodo escribe l�nea con n�mero de nodo, salta l�nea y escribe
% valores Re(x), Im(x), Re(y), Im(y), Re(z), Im(z). 

for k = 1:length(nodos);
    fprintf(fid,'%10i\n',nodos(k)); % escribe n�mero de nodo y salta l�nea
    fprintf(fid,[formato formato formato formato formato formato '\n'], datos(k,:)); 
end

% �ltima l�nea: -1
fprintf(fid,'%6i%74s\n',-1,' ');

fclose(fid); % cerrar el archivo si solo se va a escribir un modo


