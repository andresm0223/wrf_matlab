function interpo = rod_wrfinterpolavert(campo,cvert,nivel)

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
