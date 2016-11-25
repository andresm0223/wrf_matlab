function wrf = wrf_genera_dominios(lat_up,  lat_down, lon_left, lon_right, ...
    res_dom_peq, ndom, ratio_res)
% wrf_genera_dominios(lat_up,lat_down,lon_left,lon_right,res_dom_peq,ndom,ratio_res)
% Función para generar información de dominios incorporados en WRF.
%
% INPUTS:
%
% lat_up: latitud superior.
% lat_down: latitud inferior.
% lon_left: longitud izquierda.
% lon_right: longitud derecha.
% res_dom_peq: resolución dominio pequeño [km].
% ndom: número de dominios en simulación.
% ratio_res: radio de resolución entre dominios [km].
%
% OUTPUTS:
%
% wrf: estructura con información relativa a dominios.

%% Obtención de coordenadas extremas dominio pequeño en UTM:
[x1, y1, ~] = deg2utm(lat_up, lon_left);
[x2, y2, ~] = deg2utm(lat_up, lon_right);
[x3, y3, ~] = deg2utm(lat_down, lon_right);
[x4, y4, ~] = deg2utm(lat_down, lon_left);

%% Dimensiones zonales y meridionales, número de grillas de dominio pequeño:
dist_x = sqrt((x1 - x2)^2 + (y1 - y2)^2);  % Distancia horizontal [m].
dist_y = sqrt((x1 - x4)^2 + (y1 - y4)^2);  % Distancia meridional [m].
xgrid = ceil(dist_x/(res_dom_peq*1000));   % Número de grillas zonales.
ygrid = ceil(dist_y/(res_dom_peq*1000));   % Número de grillas meridionales.

while 1
 if rem(abs(xgrid-1),ratio_res) > 0
  xgrid = xgrid + 1;
 else
  break
 end
end

while 1
 if rem(abs(ygrid-1),ratio_res) > 0
  ygrid = ygrid + 1;
 else
  break
 end
end

%% Latitud y longitud central:
lat_c = mean([lat_up lat_down]);          % Latitud central.
lon_c = mean([lon_left lon_right]);       % Longitud central.
[xc, yc, utmz] = deg2utm(lat_c, lon_c);   % Latitud y longitud central en UTC. 

for i = 1:ndom
 lx = (dist_x*ratio_res^(ndom-i))/2;
 ly = (dist_y*ratio_res^(ndom-i))/2;
 [lat1.(sprintf('d%2.2d',i)), lon1.(sprintf('d%2.2d',i))] = utm2deg(xc - lx, yc + ly, utmz);
 [lat2.(sprintf('d%2.2d',i)), lon2.(sprintf('d%2.2d',i))] = utm2deg(xc + lx, yc + ly, utmz);
 [lat3.(sprintf('d%2.2d',i)), lon3.(sprintf('d%2.2d',i))] = utm2deg(xc + lx, yc - ly, utmz);
 [lat4.(sprintf('d%2.2d',i)), lon4.(sprintf('d%2.2d',i))] = utm2deg(xc - lx, yc - ly, utmz);
end

%% Razón de inicializacion para otros dominios:
lataux = linspace(lat3.(sprintf('d%2.2d',ndom-1)), lat1.(sprintf('d%2.2d',ndom-1)), ygrid);
lonaux = linspace(lon4.(sprintf('d%2.2d',ndom-1)), lon3.(sprintf('d%2.2d',ndom-1)), xgrid);
[~, poslon] = min(abs(lonaux - lon_left));
[~, poslat] = min(abs(lataux - lat_down));

%% Escribe estructuctura de datos necesarios:
wrf.ref_lat = lat_c;
wrf.ref_lon = lon_c;
wrf.truelat1 = lat2.d01;
wrf.truelat2 = lat3.d01;
wrf.i_parent = poslon;
wrf.j_parent = poslat;
wrf.ndom = ndom;
wrf.xgrid = xgrid;
wrf.ygrid = ygrid;

