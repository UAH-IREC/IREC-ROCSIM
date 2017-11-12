function enthalpy = N2O_h(press, temp)
% Enthalpy of subcooled nitrous oxide
global N2O_subcooled_pres_range N2O_subcooled_temp_range N2O_h_table;
enthalpy = interp2d(press, temp, N2O_subcooled_pres_range, N2O_subcooled_temp_range, N2O_h_table);
end