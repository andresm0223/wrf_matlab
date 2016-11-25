function sal = rod_wrfmatrixinterp(lond,latd,campo,lon,lat)
% sal = rod_wrfmatrixinterp(lond,latd,campo,lon,lat)
% Funcion para extraer serie o perfil temporal de un
% campo de WRF.
%
% & Inputs:
% lond: vector de longitud (1D)
% latd: vector de latitud (1D)
% campo: variable de WRF.
% lon: longitud que se desea interpolar.
% lat: latitud que se desea interpolar.

x = interp1(lond,1:length(lond),lon); 
pos_x1 = floor(x); pos_x2 = ceil(x);
y = interp1(latd,1:length(latd),lat);
pos_y1 = floor(y); pos_y2 = ceil(y);
x2 = 1 - (x - pos_x1); x3 = 1 - (pos_x2 - x);
y2 = 1 - (y - pos_y1); y3 = 1 - (pos_y2 - y);

nn = size(campo);
if length(nn) == 3
 sal = squeeze(x2*y2*campo(pos_x1,pos_y1,:)) + ...
 squeeze(x2*y3*campo(pos_x1,pos_y2,:)) + squeeze(x3*y2*campo(pos_x2,pos_y1,:)) + ...
 squeeze(x3*y3*campo(pos_x2,pos_y2,:));
elseif length(nn) == 4
 campo_p = squeeze(x2*y2*campo(pos_x1,pos_y1,:,:)) + ...
 squeeze(x2*y3*campo(pos_x1,pos_y2,:,:)) + squeeze(x3*y2*campo(pos_x2,pos_y1,:,:)) + ...
 squeeze(x3*y3*campo(pos_x2,pos_y2,:,:));
 for i = 1:nn(end)
  sal(:,i) = squeeze(campo_p(:,i));
 end
else
 error('Dimensiones no validas, m√ximo permitido es 4.')
end
