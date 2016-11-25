function jet = wrf_busca_jets(topo, hg, mag, dir, umbral)
% jet = wrf_busca_jets(topo, hg, mag, dir, umbral)
% Función para buscar altura a la que se genera máxima velocidad del viento
%
% & Inputs:
%
% topo: topografia del modelo (2D).
% hg : es el campo de alturas geopotenciales (4D).
% mag : es el campo de magnitudes del viento (4D).
% dir : es el campo de direcciones del viento (4D).
% umbral: define altura limite superior (en metros) para buscar sobre topografia.
% Ambos capos deben estar ordenados como (lon, lat, z, time).
%
% & Outputs:
%
% jet : estructura con información del jet, posee altura, magnitud y dirección.

% Busca jets:
nn = size(hg);
for i = 1:nn(1)
 for j = 1:nn(2)
  for k = 1:nn(4)
   [~, pos] = nanmax(squeeze(mag(i,j,:,k)));
   if hg(i,j,pos,k) - topo(i,j) > umbral
    jet.alt(i,j,k) = nan;
    jet.mag(i,j,k) = nan;
    jet.dir(i,j,k) = nan;
   else
    jet.alt(i,j,k) = squeeze(hg(i,j,pos,k)) - squeeze(topo(i,j));
    jet.mag(i,j,k) = squeeze(mag(i,j,pos,k));
    jet.dir(i,j,k) = squeeze(dir(i,j,pos,k));
   end
  end
 end
end
