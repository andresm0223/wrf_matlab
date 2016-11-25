function eta = get_etacoords(p0,z)
% p0 es la presion superficial, en hectopascales.
% z es la altura, en metros.

pt = 10;                  % hPa.
H = 8420;                 % Km
p = p0*exp(-z/H);         % presión de los niveles eta elegidos.
eta = (p - pt)/(p0 - pt); % Niveles eta.
