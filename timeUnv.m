function timeUnv(node, direction, refNode, refDir, data, file)

% Writes time data (dataset 58) to unv file. Only real even case with
% single precision is implemented
%
% TIMEUNV(node, direction, refNode, refDir, data, file)
%
% - node: number of the node
% - direction: 
%              0 - Scalar
%              1 - +X Translation       4 - +X Rotation
%             -1 - -X Translation      -4 - -X Rotation
%              2 - +Y Translation       5 - +Y Rotation
%             -2 - -Y Translation      -5 - -Y Rotation
%              3 - +Z Translation       6 - +Z Rotation
%             -3 - -Z Translation      -6 - -Z Rotation
%
% - refNode: reference node
% - refDir: direction of measurement in reference node
% - data: [time, measurement]
%
% Definition according to http://www.sdrl.uc.edu/sdrl/referenceinfo/universalfileformats/file-format-storehouse/universal-dataset-number-58

% Create file
fid = fopen([file '.unv'], 'a'); % 'a' append

% First line: 80 char line with -1 filling the first 6 
fprintf(fid,'%6i%74s\n',-1,' ');

% Second line: 58 (universal data), same format
fprintf(fid,'%6i%74s\n',58,' ');

% Following 5 lines of data 40A2 (40 alphanum chars of length 2 each)
% - for left justifying
fprintf(fid,'%-80s\n','NONE'); % Description
fprintf(fid,'%-80s\n','NONE'); 
fprintf(fid,'%-80s\n','NONE'); % Date in the form DD-MMM-YY HH:MM:SS (9A1,1X,8A1). Ex: 02-FEB-1978 12:34:12
fprintf(fid,'%-80s\n','NONE'); 
fprintf(fid,'%-80s\n','NONE'); 

% LINE 6
%
% Format(2(I5,I10),2(1X,10A1,I10,I4))
%           DOF Identification
% Field 1    - Function Type
%             1 - Time Response
% Field 2    - Function Identification Number
% Field 3    - Version Number, or sequence number
% Field 4    - Load Case Identification Number
%             0 - Single Point Excitation
% Field 5    - Response Entity Name ("NONE" if unused)
% Field 6    - Response Node
% Field 7    - Response Direction
%              0 - Scalar
%              1 - +X Translation       4 - +X Rotation
%             -1 - -X Translation      -4 - -X Rotation
%              2 - +Y Translation       5 - +Y Rotation
%             -2 - -Y Translation      -5 - -Y Rotation
%              3 - +Z Translation       6 - +Z Rotation
%             -3 - -Z Translation      -6 - -Z Rotation
% Field 8    - Reference Entity Name ("NONE" if unused)
% Field 9    - Reference Node
% Field 10   - Reference Direction  (same as field 7)
% 
%                          NOTE
% 
%    Fields 8, 9, and 10 are only relevant if field 4
%    is zero.

fprintf(fid,'%5i%10i%5i%10i %-10s%10i%4i %-10s%10i%4i\n',1,0,0,0,'NONE',node,direction,'NONE',refNode,refDir);

% LINE 7
%
% Format(3I10,3E13.5)
%                           Data Form
%                Field 1    - Ordinate Data Type
%                             2 - real, single precision
%                             4 - real, double precision
%                             5 - complex, single precision
%                             6 - complex, double precision
%                Field 2    - Number of data pairs for uneven  abscissa
%                             spacing, or number of data values for even
%                             abscissa spacing
%                Field 3    - Abscissa Spacing
%                             0 - uneven
%                             1 - even (no abscissa values stored)
%                Field 4    - Abscissa minimum (0.0 if spacing uneven)
%                Field 5    - Abscissa increment (0.0 if spacing uneven)
%                Field 6    - Z-axis value (0.0 if unused)

rows = size(data,1);
delta = data(2,1) - data(1,1);
min = data(1,1);

fprintf(fid,'%10i%10i%10i%13.5e%13.5e%13.5e\n',4,1,rows,min,delta,0.0);

% LINE 8
%
% Format(I10,3I5,2(1X,20A1))
%                       Abscissa Data Characteristics
%            Field 1    - Specific Data Type
%                         0 - unknown
%                         1 - general
%                         2 - stress
%                         3 - strain
%                         5 - temperature
%                         6 - heat flux
%                         8 - displacement
%                         9 - reaction force
%                         11 - velocity
%                         12 - acceleration
%                         13 - excitation force
%                         15 - pressure
%                         16 - mass
%                         17 - time
%                         18 - frequency
%                         19 - rpm
%                         20 - order
%                         21 - sound pressure
%                         22 - sound intensity
%                         23 - sound power
%            Field 2    - Length units exponent
%            Field 3    - Force units exponent
%            Field 4    - Temperature units exponent
% 
%                                      NOTE
% 
%                Fields 2, 3 and  4  are  relevant  only  if  the
%                Specific Data Type is General, or in the case of
%                ordinates, the response/reference direction is a
%                scalar, or the functions are being used for
%                nonlinear connectors in System Dynamics Analysis.
%                See Addendum 'A' for the units exponent table.
% 
%            Field 5    - Axis label ("NONE" if not used)
%            Field 6    - Axis units label ("NONE" if not used)

% Time in x axis
fprintf(fid,'%10i%5i%5i%5i %-20s %-20s\n',17,0,0,0,'NONE','NONE');

% Record 9:     Format(I10,3I5,2(1X,20A1))
%            Ordinate (or ordinate numerator) Data Characteristics

% Implementes as general
fprintf(fid,'%10i%5i%5i%5i %-20s %-20s\n',1,0,0,0,'NONE','NONE');

% LINE 10 (not used)
%
% Format(I10,3I5,2(1X,20A1))
% Ordinate Denominator Data Characteristics
fprintf(fid,'%10i%5i%5i%5i %-20s %-20s\n',0,0,0,0,'NONE','NONE');

% LINE 11 (not used)
% 
% Format(I10,3I5,2(1X,20A1))
% Z-axis Data Characteristics
fprintf(fid,'%10i%5i%5i%5i %-20s %-20s\n',0,0,0,0,'NONE','NONE');

% LINE 12
%
%                        Data Values
% 
%              Ordinate            Abscissa
%  Case     Type     Precision     Spacing       Format
% -------------------------------------------------------------
%    1      real      single        even         6E13.5
%    2      real      single       uneven        6E13.5
%    3     complex    single        even         6E13.5
%    4     complex    single       uneven        6E13.5
%    5      real      double        even         4E20.12
%    6      real      double       uneven     2(E13.5,E20.12)
%    7     complex    double        even         4E20.12
%    8     complex    double       uneven      E13.5,2E20.12

% Implemented real even case with single precision
fprintf(fid, '%13.5e%13.5e%13.5e%13.5e%13.5e%13.5e\n', data(:,2)');

if rem(size(data,1),6)~=0
   fprintf(fid,'\n');
end

% Last line: -1
fprintf(fid,'%6i%74s\n',-1,' ');

fclose(fid); % close file