tic
psi2pa = 6894.76; % convert psi to Pa
eps = 3.75:.25:5.0;
MRs = 6:.05:10;
temp_f = [265, 285, 305];
temp_ox = [269, 289, 309];
pressures = psi2pa * [200, 300, 400, 500, 600, 700];
interpolated = CEA_5d_table_gen(pressures, MRs, eps, temp_ox, temp_f);
save_CEA_table(pressures, MRs, eps, temp_ox, temp_f, interpolated);
toc