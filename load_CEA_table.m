function [pressures, mrs, eps, ox_temps, f_temps, CEA_table] = load_CEA_table()
flattened_table = csvread('CEA_table.csv');

pressures = csvread('pressures.csv');
mrs = csvread('MRs.csv');
eps = csvread('expansion_ratios.csv');
ox_temps = csvread('oxidizer_temperatures.csv');
f_temps = csvread('fuel_temperatures.csv');

CEA_table = reshape(flattened_table, [length(pressures), length(mrs), length(eps), length(ox_temps), length(f_temps), 4]);
end