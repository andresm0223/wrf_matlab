function rod_extraccion_campos(ruta_domis,ndom,coords,ruta_save,auxlat,auxlon,zlev)

mkdir(ruta_save)
n = length(coords);
n2 = n/2;
lat = coords(1:2:end); 
lon = coords(2:2:end);

% Genera y guarda campos relevantes:
s = rod_wrfgetdata(ruta_domis,ndom,auxlat,auxlon,zlev);
mkdir([ruta_save '/campos'])
save(sprintf([ruta_save 'campos/campo_d%1.0f.mat'],ndom),'s','-v7.3')

% Genera y guarda series relevantes:
cont = 0;
for j = 1:n/2;
	cont = cont + 1;
	wrf(cont).data = rod_wrfgetserie(s,lon(j),lat(j));
end
mkdir([ruta_save '/series'])
save(sprintf([ruta_save 'series/series_d%2.0f'],ndom),'wrf','-v7.3')
clear wrf s
