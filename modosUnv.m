function modosUnv(numeroModo, f, xi, numNodos, datos, nombreArchivo, opcion)

% Escribe un modo en un unv (tipo de dato 55).
% Datos:
% numeroModo: número del modo
% f: frecuencia en Hz
% xi: amortiguamiento en tanto por 1
% numNodos: número de nodos del sistema
% datos: matriz de 6 columnas Re(x), Im(x), Re(y), Im(y), Re(z), Im(z)
% desplazamiento del modo en cada nodo (con el mismo orden de numNodos)
% nombreArchivo: nombre del archivo sin la extensión unv
% opcion: 'w' para crear el archivo y 'a' para añadir modo a un archivo
% existente

% Datos

omega = 2*pi*f;
eig = -xi*omega + sqrt(1-xi^2)*omega*i;
nodos = 1:numNodos;

% Archivo donde escrbir
fid = fopen([nombreArchivo '.unv'], opcion); % poner opción 'a' para append y 'w' para crear

% Primera línea: -1
fprintf(fid,'%6i%74s\n',-1,' '); % líneas de 80 caracteres donde -1 ocupa los 6 primeros

fprintf(fid,'%6i%74s\n',55,' '); % segunda línea 55 (valores de datos en los nodos)

% Siguientes 5 líneas NONE porque no pueden estar en blanco(en Reflex escribe el método de cálculo, autor, ...)

fprintf(fid,'%-80s\n','NONE'); % 40A2 40 caracteres alfanuméricos de 2 de largo cada uno
fprintf(fid,'%-80s\n','NONE'); 
fprintf(fid,'%-80s\n','NONE'); 
fprintf(fid,'%-80s\n','NONE'); 
fprintf(fid,'%-80s\n','NONE'); 

% La siguiente línea tiene 6 dígitos: 
%
% #1: tipo de modelo:
%     0: desconocido
%     1: estructural
%     2: transmisión de calor
%     3: fluido
% 
% #2: tipo de análisis:
%     0: desconocido
%     1: estático
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
%     2: vector de traslación de 3 gdl
%     3: vector de traslación y rotación de 6 gdl
%     4: tensor simétrico
%     5: tensor general
%
% #4: tipo de respuesta
%     0: desconocida
%     1: general
%     2: tensión
%     3: deformación
%     4: fuerza
%     5: temperatura
%     6: flujo de calor
%     7: energía de deformación
%     8: desplazamiento
%     9: fuerza de reacción
%     10: energía cinética
%     11: velocidad
%     12: aceleración
%     13: densidad de energía de deformación
%     14: densidad de energía cinética
%     15: presión hidrostática
%     16: gradiente de calor
%     17: Code Checking Value (dígito de control?)
%     18: coeficiente de presión
%
% #5: tipo de datos
%     2: reales
%     5: complejos
% #6: número de datos por nodo (gdls)

% Un caso típico es:   1         3         2         8         5         3

fprintf(fid,'%10i%10i%10i%10i%10i%10i\n',1,3,2,8,5,3); % para caso típico de modos complejos

formato = '%13.5e'; % formato de los números E13.5 

% Modos complejos
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Datos del modo

fprintf(fid,'%10i%10i%10i%10i\n',2,6,0,numeroModo); 

% 1#: 2
% 2#: 6
% 3#: Caso de carga 
% 4#: Número del modo

% Valor propio y tal

fprintf(fid,[formato formato formato formato formato formato '\n'],real(eig),imag(eig),0,0,0,0); 

% Para cada nodo escribe línea con número de nodo, salta línea y escribe
% valores Re(x), Im(x), Re(y), Im(y), Re(z), Im(z). 

for k = 1:length(nodos);
    fprintf(fid,'%10i\n',nodos(k)); % escribe número de nodo y salta línea
    fprintf(fid,[formato formato formato formato formato formato '\n'], datos(k,:)); 
end

% Última línea: -1
fprintf(fid,'%6i%74s\n',-1,' ');

fclose(fid); % cerrar el archivo si solo se va a escribir un modo


