addpath('main');
addpath(fullfile('MatlabTools'));
addpath(fullfile('MatlabCEA'));
addpath(fullfile('Supporting Functions'));
addpath(fullfile('Supporting Functions/SimulinkSafeProp'));
addpath(fullfile('Data'));
%addpath(fullfile('tdmsSubfunctions'));

% Propellant property tables
global N2O_d_table N2O_h_table N2O_u_table N2O_subcooled_pres_range N2O_subcooled_temp_range;
N2O_d_table = csvread('Supporting Functions/SimulinkSafeProp/N2O_d_table.csv');
N2O_h_table = csvread('Supporting Functions/SimulinkSafeProp/N2O_h_table.csv');
N2O_u_table = csvread('Supporting Functions/SimulinkSafeProp/N2O_u_table.csv');
N2O_subcooled_pres_range = csvread('Supporting Functions/SimulinkSafeProp/N2O_table_pressures.csv');
N2O_subcooled_temp_range = csvread('Supporting Functions/SimulinkSafeProp/N2O_table_temps.csv');

global N2O_sat_v_P_table N2O_sat_v_u_table N2O_sat_v_h_table N2O_sat_v_d_table...
    N2O_sat_l_P_table N2O_sat_l_u_table N2O_sat_l_h_table N2O_sat_l_d_table N2O_sat_temprange;

N2O_sat_v_P_table = csvread('Supporting Functions/SimulinkSafeProp/N2O_sat_v_P_table.csv');
N2O_sat_v_u_table = csvread('Supporting Functions/SimulinkSafeProp/N2O_sat_v_u_table.csv');
N2O_sat_v_h_table = csvread('Supporting Functions/SimulinkSafeProp/N2O_sat_v_h_table.csv');
N2O_sat_v_d_table = csvread('Supporting Functions/SimulinkSafeProp/N2O_sat_v_d_table.csv');

N2O_sat_l_P_table = csvread('Supporting Functions/SimulinkSafeProp/N2O_sat_l_P_table.csv');
N2O_sat_l_u_table = csvread('Supporting Functions/SimulinkSafeProp/N2O_sat_l_u_table.csv');
N2O_sat_l_h_table = csvread('Supporting Functions/SimulinkSafeProp/N2O_sat_l_h_table.csv');
N2O_sat_l_d_table = csvread('Supporting Functions/SimulinkSafeProp/N2O_sat_l_d_table.csv');

N2O_sat_temprange = csvread('Supporting Functions/SimulinkSafeProp/N2O_sat_temps.csv');