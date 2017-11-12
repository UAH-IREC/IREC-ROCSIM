function density = N2O_d(press, temp)
% Density of subcooled nitrous oxide
global N2O_subcooled_pres_range N2O_subcooled_temp_range N2O_d_table;
density = interp2d(press, temp, N2O_subcooled_pres_range, N2O_subcooled_temp_range, N2O_d_table);
end