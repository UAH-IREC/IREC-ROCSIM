function int_energy = N2O_u(press, temp)
% Enthalpy of subcooled nitrous oxide
global N2O_subcooled_pres_range N2O_subcooled_temp_range N2O_u_table;
int_energy = interp2d(press, temp, N2O_subcooled_pres_range, N2O_subcooled_temp_range, N2O_u_table);
end