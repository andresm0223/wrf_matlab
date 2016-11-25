function sal = rod_wrfgetserie(s,lon,lat)
% sal = rod_wrfgetserie(s,lon,lat,levels)
% Función para la interpolación de series de tiempo, 
% o perfil vertical de las salidas de WRF.
%
% & Inputs:
%
% s: estructura con los campos de WRF extraídos.
% lon: longitud que se desea interpolar.
% lat: latitud que se desea interpolar.
% levels: niveles verticales que se desea interpolar para campos 4D.
%
% & Outputs:
%
% sal: estructura con las series y perfiles de los campos en la ubicación 
% seleccionada.

nn = size(s.p);
lat_dom = squeeze(s.lat(1,:,1)); 
nlat = length(lat_dom);
lon_dom = squeeze(s.lon(:,1,1)); 
nlon = length(lon_dom);
% Variables 4D:
sal.u = rod_wrfmatrixinterp(lon_dom,lat_dom,s.u,lon,lat);
sal.v = rod_wrfmatrixinterp(lon_dom,lat_dom,s.v,lon,lat);
sal.w = rod_wrfmatrixinterp(lon_dom,lat_dom,s.w,lon,lat);
sal.p = rod_wrfmatrixinterp(lon_dom,lat_dom,s.p,lon,lat);
sal.hg = rod_wrfmatrixinterp(lon_dom,lat_dom,s.hg,lon,lat);
sal.tp = rod_wrfmatrixinterp(lon_dom,lat_dom,s.tp,lon,lat);
sal.qc = rod_wrfmatrixinterp(lon_dom,lat_dom,s.qc,lon,lat);
sal.qr = rod_wrfmatrixinterp(lon_dom,lat_dom,s.qr,lon,lat);
sal.qv = rod_wrfmatrixinterp(lon_dom,lat_dom,s.qv,lon,lat);
sal.temp = rod_wrfmatrixinterp(lon_dom,lat_dom,s.temp,lon,lat);
sal.tke = rod_wrfmatrixinterp(lon_dom,lat_dom,s.tke,lon,lat);
sal.el_pbl = rod_wrfmatrixinterp(lon_dom,lat_dom,s.el_pbl,lon,lat);
sal.hr = rod_wrfmatrixinterp(lon_dom,lat_dom,s.hr,lon,lat);
sal.agua = rod_wrfmatrixinterp(lon_dom,lat_dom,s.agua,lon,lat);
sal.tp_liq = rod_wrfmatrixinterp(lon_dom,lat_dom,s.tp_liq,lon,lat);
sal.lat = lat;
sal.lon = lon;
% Variables superficiales (3D):
sal.q2 = rod_wrfmatrixinterp(lon_dom,lat_dom,s.q2,lon,lat);
sal.t2 = rod_wrfmatrixinterp(lon_dom,lat_dom,s.t2,lon,lat);
sal.u10 = rod_wrfmatrixinterp(lon_dom,lat_dom,s.u10,lon,lat);
sal.v10 = rod_wrfmatrixinterp(lon_dom,lat_dom,s.v10,lon,lat);
sal.psfc = rod_wrfmatrixinterp(lon_dom,lat_dom,s.psfc,lon,lat);
sal.pre = rod_wrfmatrixinterp(lon_dom,lat_dom,s.pre,lon,lat);
sal.alt_base = rod_wrfmatrixinterp(lon_dom,lat_dom,s.alt_base,lon,lat);
sal.alt_tope = rod_wrfmatrixinterp(lon_dom,lat_dom,s.alt_tope,lon,lat);
sal.grosor = rod_wrfmatrixinterp(lon_dom,lat_dom,s.grosor,lon,lat);
sal.topo = unique(unique(unique(rod_wrfmatrixinterp(lon_dom,lat_dom,s.topo,lon,lat))));
sal.sh = rod_wrfmatrixinterp(lon_dom,lat_dom,s.sh,lon,lat);
sal.lh = rod_wrfmatrixinterp(lon_dom,lat_dom,s.lh,lon,lat);
sal.tsk = rod_wrfmatrixinterp(lon_dom,lat_dom,s.tsk,lon,lat);
sal.sst = rod_wrfmatrixinterp(lon_dom,lat_dom,s.sst,lon,lat);
sal.uast = rod_wrfmatrixinterp(lon_dom,lat_dom,s.uast,lon,lat);
