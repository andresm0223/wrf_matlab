function serie = rod_wrfgetserie_lonlat(campo,lon,lat,lonc,latc)
% serie = get_serie_lonlat(campo,lon,lat);
%
% Función para extraer la serie de tiempo de un campo meteorológico en
% una longitud y latitud dada.
%
% & INPUTS:
%
% campo: es el campo meteorológico, de 3 o 4 dimensiones.
% lon: es la longitud del campo.
% lat: es la latitud del campo.
% lonc: es la longitud a extraer.
% latc: es la latitud a extraer.

x = interp1(lon,1:length(lon),lonc);
xx(1) = floor(x); xx(2) = ceil(x);
y = interp1(lat,1:length(lat),latc);
yy(1) = floor(y); yy(2) = ceil(y);

n = size(campo);
if length(n) == 3
 s1 = squeeze(campo(xx(1),yy(1),:));
 s2 = squeeze(campo(xx(1),yy(2),:));
 s3 = squeeze(campo(xx(2),yy(1),:));
 s4 = squeeze(campo(xx(2),yy(2),:));
elseif length(n) == 4
 s1 = squeeze(campo(xx(1),yy(1),:,:));
 s2 = squeeze(campo(xx(1),yy(2),:,:));
 s3 = squeeze(campo(xx(2),yy(1),:,:));
 s4 = squeeze(campo(xx(2),yy(2),:,:));
else
 error('Dimensiones invalidas')
end
serie = ((1-(x-xx(1)))*(1-(y-yy(1)))*s1) + ((1-(xx(2)-x))*(1-(y-yy(1)))*s2) + ...
     ((1-(x-xx(1)))*(1-(yy(2)-y))*s3) + ((1-(xx(2)-x))*(1-(yy(2)-y))*s4);
