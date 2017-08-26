%% Liquid Rocket Script with Simulink
% Model LRSim1D
clc,clear
startup % run startup script for CEA and Coolprop
%runsim() % Uses default parameters
%Changes temperature (K), pressure (Pa), MR, area ratio, and chamber
%pressure (psi)

%% Simulation Conditions
atm_conditions.garbage = 0;
atmoptions = readtable('simconfig.xlsx', 'Sheet', 'Simulation Conditions');

[val, type] = param_from_table(atmoptions, 'Ambient pressure', 1);
if type == ParameterType.SingleValue
    atm_conditions.pamb = val;
end

[val, type] = param_from_table(atmoptions, 'Ambient temperature', 1);
if type == ParameterType.SingleValue
    atm_conditions.Tamb = val;
end

%% Propellant Options
prop_params.garbage = 0;
prop_params.ox.garbage = 0;
prop_params.f.garbage = 0;
propoptions = readtable('simconfig.xlsx', 'Sheet', 'Propellant Parameters');
for i = 1:height(propoptions)
    if strcmp(table2cell(propoptions(i, 1)), 'Oxidizer')
        name = table2cell(propoptions(i, 2));
        formula = table2cell(propoptions(i, 3));
        prop_params.ox.name = {name{1}, formula{1}};
    elseif strcmp(table2cell(propoptions(i, 1)), 'Fuel')
        name = table2cell(propoptions(i, 2));
        formula = table2cell(propoptions(i, 3));
        prop_params.f.name = {name{1}, formula{1}};
    end
end

[val, type] = param_from_table(propoptions, 'Oxidizer volume', 1);
if type == ParameterType.SingleValue
    prop_params.ox.V = val;
end

[val, type] = param_from_table(propoptions, 'Oxidizer mass', 1);
if type == ParameterType.SingleValue
    prop_params.ox.m = val;
end

%% Rocket Options
rocket_params.garbage = 0;
rocketoptions = readtable('simconfig.xlsx', 'Sheet', 'Rocket Parameters');
[val, type] = param_from_table(rocketoptions, 'Total inert mass', 1);
if type == ParameterType.SingleValue
    rocket_params.minert = val;
end

[val, type] = param_from_table(rocketoptions, 'Largest circular diameter', 1);
if type == ParameterType.SingleValue
    rocket_params.d = val;
end

[val, type] = param_from_table(rocketoptions, 'Thrust-to-weight ratio', 1);
if type == ParameterType.SingleValue
    rocket_params.TW = val;
end

%% Engine Options
engine_params.garbage = 0;
engineoptions = readtable('simconfig.xlsx', 'Sheet', 'Engine Parameters');
[val, type] = param_from_table(engineoptions, 'Chamber pressure', 1);
if type == ParameterType.SingleValue
    engine_params.pct_psi = val;
end

[val, type] = param_from_table(engineoptions, 'Expansion ratio', 1);
if type == ParameterType.SingleValue
    engine_params.eps = val;
end

[val, type] = param_from_table(engineoptions, 'C*', 1);
if type == ParameterType.SingleValue
    engine_params.cstar_eta = val;
end

[val, type] = param_from_table(engineoptions, 'Engine mass', 1);
if type == ParameterType.SingleValue
    engine_params.m = val;
end

[val, type] = param_from_table(engineoptions, 'Contraction ratio', 1);
if type == ParameterType.SingleValue
    engine_params.epsc = val;
end

[val, type] = param_from_table(engineoptions, 'Characteristic length', 1);
if type == ParameterType.SingleValue
    engine_params.Lstar = val;
end

[val, type] = param_from_table(engineoptions, 'Mixture ratio', 1);
if type == ParameterType.SingleValue
    engine_params.MR = val;
end

[val, type] = param_from_table(engineoptions, 'Chamber-to-throat contraction angle', 1);
if type == ParameterType.SingleValue
    engine_params.thetac = val;
end

[val, type] = param_from_table(engineoptions, 'Nozzle cone half angle', 1);
if type == ParameterType.SingleValue
    engine_params.alpn = val;
end

%% Simulation Execution

[max, flightdata, forces, Roc, Eng, Prop] = runsim(atm_conditions, prop_params, engine_params, rocket_params)