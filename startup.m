addpath('main');
addpath(fullfile('MatlabTools'));
addpath(fullfile('MatlabCEA'));
addpath(fullfile('Supporting Functions'));
addpath(fullfile('Data'));
%addpath(fullfile('tdmsSubfunctions'));

% Propellant property tables
N2O_d_table = csvread('Supporting Functions/SimulinkSafeProp/N2O_d_table.csv');
N2O_h_table = csvread('Supporting Functions/SimulinkSafeProp/N2O_h_table.csv');
N2O_u_table = csvread('Supporting Functions/SimulinkSafeProp/N2O_u_table.csv');
N2O_subcooled_pres_range = csvread('Supporting Functions/SimulinkSafeProp/N2O_table_pressures.csv');
N2O_subcooled_temp_range = csvread('Supporting Functions/SimulinkSafeProp/N2O_table_temps.csv');

N2O_sat_v_table = csvread('Supporting Functions/SimulinkSafeProp/N2O_sat_v_table.csv');
N2O_sat_l_table = csvread('Supporting Functions/SimulinkSafeProp/N2O_sat_l_table.csv');
N2O_sat_temprange = csvread('Supporting Functions/SimulinkSafeProp/N2O_sat_temps.csv');