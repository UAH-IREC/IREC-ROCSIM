function [] = save_CEA_table(pressures, mrs, eps, ox_temps, f_temps, CEA_table)
save_table = reshape(CEA_table, [length(CEA_table(:, 1, 1, 1, 1, 1)), length(CEA_table(1, :, 1, 1, 1, 1)) * length(CEA_table(1, 1, :, 1, 1, 1)) * length(CEA_table(1, 1, 1, :, 1, 1)) * length(CEA_table(1, 1, 1, 1, :, 1)) * length(CEA_table(1, 1, 1, 1, 1, :))]);
csvwrite('CEA_table.csv', save_table);

csvwrite('pressures.csv', pressures);
csvwrite('MRs.csv', mrs);
csvwrite('expansion_ratios.csv', eps);
csvwrite('oxidizer_temperatures.csv', ox_temps);
csvwrite('fuel_temperatures.csv', f_temps);
end