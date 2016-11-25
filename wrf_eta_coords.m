function eta = wrf_eta_coords(z, z0, pt)
% eta = wrf_eta_coords(z, z0, pt, ps)
% Funcion para obtener eta coords.
% INPUTS:
%
% z: altura sobre el nivel del suelo [km].
% z0: altura del suelo, respecto del nivel del mar [km].
% pt: presion en tope [hPa].
%
% OUTPUTS:
%
% eta: niveles eta.

H = 8.420;
ps = 1000*exp(-z0/H);
p = 1000*exp(-(z+z0)/H);
eta = (p - pt)/(ps - pt);