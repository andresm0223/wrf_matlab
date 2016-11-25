function campo_med = wrf_dailycicle(campo,time)
% wrf_dailycicle(campo, time)
% Obtiene el ciclo diario de un campo 3D.
%

n = size(campo);
for i = 1:n(1)
 for j = 1:n(2)
  aux = squeeze(campo(i,j,:));
  campo_med(i,j,:) = grpstats(aux,hour(time),'mean');
 end
end
