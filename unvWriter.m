function unvWriter(puntos,nombreArchivo)

% Crea un archivo nombreArchivo.unv de la geometría a partir de una matriz 
% cuyas columnas sean las coordenadas (x,y,z)

columnas = 7;

% Significado de las columnas
% 1: nombre del punto
% 2: defCS (default = 0)
% 3: dispCS (default = 0)
% 4: color (default = 0)
% 5: coordenada x
% 6: coordenada y
% 7: coordenada z

filas = length(puntos);

datos = zeros(filas, columnas);

datos(:,1)=(1:length(puntos))';

datos(:,5:7) = puntos;

% Archivo donde escrbir
fid = fopen([nombreArchivo '.unv'], 'w');

% Primera línea: -1
fprintf(fid,'%6i%74s\n',-1,' '); % 80 caracteres en total, -1 en los 6 primeros

% Segunda: 15 (geometría)

fprintf(fid,'%6i%74s\n',15,' ');

% Escribir matriz
fprintf(fid, '%10i%10i%10i%10i%13.5e%13.5e%13.5e\n', datos');

% Última línea: -1
fprintf(fid,'%6i%74s\n',-1,' ');

fclose(fid);