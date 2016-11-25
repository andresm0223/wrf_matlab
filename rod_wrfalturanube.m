function [base, tope, grosor] = rod_wrfalturanube(nube, hgt)
% [base, tope] = rod_wrfalturanube(nube)
% FunciÃn para obtener la altura de tope y base de la nube.
%
% Inputs:
% nube: El campo nube hace referencia a la variable qcloud de WRF.
% hgt: Es el campo de alturas geopotenciales.
%
% Outputs:
% base : es la altura de base de la nube.
% tope: es la altura del tope de la nube.
% grosor: indica grosor de la capa de nubes.

n = size(nube);
for i = 1:n(1)
 for j = 1:n(2)
  for k = 1:n(4)
   serie_nube = nube(i,j,:,k); % Perfil de qcloud para tiempo k.
   altura = hgt(i,j,:,k);
   aux = altura(serie_nube>0);
   if length(aux) > 0
    tope(i,j,k) = aux(end); base(i,j,k) = aux(1);
    grosor(i,j,k) = aux(end) - aux(1);
   else
    tope(i,j,k) = nan; base(i,j,k) = nan;
    grosor(i,j,k) = nan;
   end
  end
 end
end
