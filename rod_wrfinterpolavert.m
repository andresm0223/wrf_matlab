function interpo = rod_wrfinterpolavert(campo,cvert,nivel)
% Interp fields at given height.
%
% Inputs:
%
% campo: 4D field of any WRF output (example temperature).
% cvert: 4D field of geopotential height (previously calculated).
% nivel: Height at witch 4D field is interpolated.

n = size(campo);
for k = 1:n(4)
 for i = 1:n(1)
  for j = 1:n(2)
   serie = squeeze(campo(i,j,:,k));
   cc = squeeze(cvert(i,j,:,k));
   interpo(i,j,k) = interp1(cc,serie,nivel);
  end
 end
end
