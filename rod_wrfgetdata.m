function s = rod_wrfgetdata(ruta,dom,auxlat,auxlon,zlev)
% s = rod_wrfgetdata(ruta,dom)
% FunciÃn para extraer campos principales de WRF.
%
% & Inputs:
%
% ruta: ruta donde se encuentran los archivos wrfout.
% dom: NÃmero de dominio del cual se desea extraer el
% punto de grilla. Depende del nÃmero mÃximo 
% de dominios que posea la simulaciÃn.
%
% & Outputs:
%
% s: estructura con los campos principales extraidos.

s.u = []; 
s.v = []; 
s.w = []; 
s.p = []; 
s.hg = []; 
%s.qr = [];
s.tp = []; 
%s.q2 = []; 
s.t2 = []; 
%s.qc = []; 
s.u10 = []; 
s.v10 = []; 
s.psfc = []; 
s.lat = []; 
s.lon = [];
s.pre = []; 
%s.qv = []; 
%s.tke = []; 
s.temp = []; 
%s.hr = [];
s.topo = []; 
%s.agua = []; 
%s.tp_liq = []; 
%s.alt_base = [];
%s.alt_tope = []; 
%s.grosor = []; 
%s.lh = []; 
%s.sh = [];
s.tsk = []; 
%s.sst = []; 
%s.uast = []; 
%s.el_pbl = [];
aux = sprintf([ruta '/wrfout_d%2.2d*00:00:00'],dom);
archivos = rod_lscell(aux);
cont = 0;
for i = 1:length(archivos)
 disp(['Iterando para ' archivos{i}])
 %% Extrae campos primarios de simulación:
 % Extrae campos de latitud y longitud y busca posiciones auxiliares a
 % extraer:
 lat_dom = ncread(archivos{i},'XLAT');     % latitud dominio.
 lon_dom = ncread(archivos{i},'XLONG');    % longitud dominio.
 squeeze(lon_dom(:,1,1))
 poslat = find(squeeze(lat_dom(1,:,1)) >= auxlat(1) & squeeze(lat_dom(1,:,1)) <= auxlat(2));
 poslon = find(squeeze(lon_dom(:,1,1)) >= auxlon(1) & squeeze(lon_dom(:,1,1)) <= auxlon(2));

 u_dom = ncread(archivos{i},'U');          % velocidad zonal.
 v_dom = ncread(archivos{i},'V');          % velocidad meridional
 w_dom = ncread(archivos{i},'W');          % velocidad vertical.
 ph_dom = ncread(archivos{i},'PH');        % perturbación geopotencial.
 phb_dom = ncread(archivos{i},'PHB');      % estado-base geopotencial.
 t_dom = ncread(archivos{i},'T');          % perturbación de temperatura potencial.
 p_dom = ncread(archivos{i},'P');          % perturbación de presión.
 pb_dom = ncread(archivos{i},'PB');        % estado-base presión.
%q2 = ncread(archivos{i},'Q2');            % razón de mezcla a 2m.
 t2 = ncread(archivos{i},'T2');            % temperatura a 2m.
 psfc = ncread(archivos{i},'PSFC');        % presión superficial.
 u10 = ncread(archivos{i},'U10');          % velocidad zonal a 10m.
 v10 = ncread(archivos{i},'V10');          % velocidad meridional a 10m.
%qvapor = ncread(archivos{i},'QVAPOR');    % razón de mezcla de vapor.
% qcloud = ncread(archivos{i},'QCLOUD');    % razÃn de mezcla de nube.
% qrain = ncread(archivos{i},'QRAIN');      % razÃn de mezcla de lluvia.
% hgt_dom = ncread(archivos{i},'HGT');      % altura de terreno.
% rainc = ncread(archivos{i},'RAINC');      % lluvia convectiva.
% rainnc = ncread(archivos{i},'RAINNC');    % lluvia no convectiva.
 topo_dom = ncread(archivos{i},'HGT');     % topografÃa.
% tke_dom = ncread(archivos{i},'TKE_PBL');  % TKE.
% lh = ncread(archivos{i},'LH');            % Calor latente.
% sh = ncread(archivos{i},'HFX');           % Calor sensible.
 tsk = ncread(archivos{i},'TSK');          % Temperatura del suelo.
% sst = ncread(archivos{i},'SST');          % SST [K].
% uast = ncread(archivos{i},'UST');         % Velocidad de fricciÃn.
% el_pbl = ncread(archivos{i},'EL_PBL');    % Longitud capa limite (usado como proxy para turbulencia de macroscala).
 %% Campos secundarios:
 u = 0.5*(u_dom(1:end-1,:,:,:) + u_dom(2:end,:,:,:));
 v = 0.5*(v_dom(:,1:end-1,:,:) + v_dom(:,2:end,:,:));
 w = 0.5*(w_dom(:,:,1:end-1,:) + w_dom(:,:,2:end,:));
 %tke = 0.5*(tke_dom(:,:,1:end-1,:) + tke_dom(:,:,2:end,:));
 geop = ph_dom + phb_dom;                                    % geopotencial.
 h_geop = geop/9.81;                
 h_geop = 0.5*(h_geop(:,:,1:end-1,:) + h_geop(:,:,2:end,:)); % altura geopotencial.
 t_pot = t_dom + 300;                                        % temperatura potencial.
 p = 0.01*(p_dom + pb_dom);                                  % presión.
 %prec = rainc + rainnc;                                      % precipitaciÃn total.
 temp = t_pot.*(1000./p).^(-287/1004);                       % temperatura [K].
 %esat = 6.112*exp((17.67*(temp-273.15))./((temp-273.15) + 243.5));  % presiÃn parcial de vapor saturado (no se guarda).
 %qsat = (0.622*esat)./(p-esat);                              % Tasa de vapor de agua saturado (no se guarda).
 %hr = 100*qvapor./qsat;                                      % Humedad relativa.
 %tempv = temp.*(1 + (0.6077.*qvapor));                       % Temperatura virtual (no se guarda).
 %rho = p./(287.*tempv);                                      % Densidad del aire (no se guarda).
 %agua = ((qcloud(:,:,1:end-1,:) + qcloud(:,:,2:end,:))/2).*((rho(:,:,1:end-1,:) + rho(:,:,2:end,:))/2).*...
	%(h_geop(:,:,2:end,:) - h_geop(:,:,1:end-1,:));       % Contenido de agua líquida [kg/m2].
 %t_pot_liq = t_pot - ((2260000/1004).*qcloud);              % Temperatura potencial agua líquida.
 %[base, tope, grosor] = rod_wrfalturanube(qcloud,h_geop);    % Altura de base, tope y grosor de nube.
 %% Arreglo dimensional:
 u = u(poslon,poslat,1:zlev,:);
 v = v(poslon,poslat,1:zlev,:);
 w = w(poslon,poslat,1:zlev,:);
 p = p(poslon,poslat,1:zlev,:);
 h_geop = h_geop(poslon,poslat,1:zlev,:);
 t_pot = t_pot(poslon,poslat,1:zlev,:);
 t2 = t2(poslon,poslat,:);
 u10 = u10(poslon,poslat,:);
 v10 = v10(poslon,poslat,:);
 psfc = psfc(poslon,poslat,:);
 lat_dom = lat_dom(poslon,poslat,:);
 lon_dom = lon_dom(poslon,poslat,:);
 topo_dom = topo_dom(poslon,poslat,:);
 temp = temp(poslon,poslat,1:zlev,:);
 tsk = tsk(poslon,poslat,:);
 
 %% Guarda variables: 
 s.u = cat(4,s.u,single(u)); 
 s.v = cat(4,s.v,single(v));
 s.w = cat(4,s.w,single(w)); 
 s.p = cat(4,s.p,single(p));
 s.hg = cat(4,s.hg,single(h_geop)); 
 s.tp = cat(4,s.tp,single(t_pot));
 %s.qc = cat(4,s.qc,single(qcloud)); 
 %s.qr = cat(4,s.qr,single(qrain)); 
 %s.q2 = cat(3,s.q2,single(q2)); 
 s.t2 = cat(3,s.t2,single(t2)); 
 s.u10 = cat(3,s.u10,single(u10)); 
 s.v10 = cat(3,s.v10,single(v10)); 
 s.psfc = cat(3,s.psfc,single(psfc)); 
 s.lat= cat(3,s.lat,single(lat_dom)); 
 s.lon = cat(3,s.lon,single(lon_dom));
 %s.pre = cat(3,s.pre,single(prec)); 
 %s.qv = cat(4,s.qv,single(qvapor)); 
 s.topo = cat(3,s.topo,single(topo_dom)); 
 %s.tke = cat(4,s.tke,single(tke)); 
 s.temp = cat(4,s.temp,single(temp)); 
 %s.hr = cat(4,s.hr,single(hr)); 
 %s.agua = cat(4,s.agua,single(agua));
 %s.tp_liq = cat(4,s.tp_liq,single(t_pot_liq)); 
 %s.el_pbl = cat(4,s.el_pbl,single(el_pbl));
 %s.alt_base = cat(3,s.alt_base,single(base)); 
 %s.alt_tope = cat(3,s.alt_tope,single(tope));
 %s.grosor = cat(3,s.grosor,single(grosor)); 
 %s.lh = cat(3,s.lh,single(lh));
 %s.sh = cat(3,s.sh,single(sh)); 
 s.tsk = cat(3,s.tsk,single(tsk));
 %s.sst = cat(3,s.sst,single(sst)); 
 %s.uast = cat(3,s.uast,single(uast));
 
 
 
 
 
 
end
