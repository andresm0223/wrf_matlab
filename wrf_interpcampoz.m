function ci = wrf_interpcampoz(campo,t,z,z0)
% interpola campo 4D, con alturas asociadas z, a la altura z0 sobre 
% el nivel del suelo.

n = size(campo);
cont = 0;
for i = 1:n(1)
	for j = 1:n(2)
		for k = 1:n(4)
			c_aux = squeeze(campo(i,j,:,k));
			z_aux = squeeze(z(i,j,:,k));
			ci(i,j,k) = interp1(z_aux,c_aux,z0);
			cont = cont + 1;
			disp(100*cont/(n(1)*n(2)*n(4)))
		end
	end
end
