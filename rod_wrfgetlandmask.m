function a = rod_wrfgetlandmask(name);
 % Extrae mascara de terreno de salida WRF.
 aux = ncopen(name);
 a = ncgetvar(aux,'LANDMASK');
