function pressure = N2O_sat_P(temp)
% N2O_SAT_P Calculates pressure of saturated N2O at a given temperature
global N2O_sat_temprange N2O_sat_v_table;
pressure = interp1(N2O_sat_temprange, N2O_sat_v_table(:, 1), temp);
end