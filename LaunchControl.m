%% Liquid Rocket Script with Simulink
% Model LRSim1D
clc,clear
startup % run startup script for CEA and Coolprop
%runsim() % Uses default parameters
%Changes temperature (K), pressure (Pa), MR, area ratio, and chamber
%pressure (psi)

%% Simulation Conditions
atm_conditions = [];
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
prop_params = [];
% prop_params.ox.garbage = 0;
% prop_params.f.garbage = 0;
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
rocket_params = [];
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
engine_params = [];
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

[max, flightdata, forces, Roc, Eng, Prop] = runsim(atm_conditions, prop_params, engine_params, rocket_params);

%% Output

% From https://www.mathworks.com/matlabcentral/answers/2603-add-a-new-excel-sheet-from-matlab
% Connect to Excel
Excel = actxserver('excel.application');
% Get Workbook object
WB = Excel.Workbooks.Open(fullfile(pwd, 'simconfig.xlsx'), 0, false);
Excel.Visible = true;
% Get Worksheets object
WS = WB.Worksheets;
% Add after the last sheet
WS.Add([], WS.Item(WS.Count));
WS.Item(WS.Count).Name = ['Results ' strrep(datestr(now()), ':', '-')];

% https://stackoverflow.com/questions/7636567/write-information-into-excel-after-each-loop
WB.Sheets.Item(WS.Count).Activate();
Excel.Range('A1:E1').Select();
Excel.Selection.Value = {'Time (s)', 'Acceleration (m/s)', 'Velocity (m/s)', 'Altitude (m)', 'Mach Number'};
[rows, ~] = size(flightdata);
Excel.Range(sprintf('A2:E%i', rows)).Select();
Excel.Selection.Value = num2cell(flightdata);

Excel.Range('F1:H1').Select();
Excel.Selection.Value = {'Mass (kg)', 'Drag (N)', 'Thrust (N)'};
[rows, ~] = size(forces);
Excel.Range(sprintf('F2:H%i', rows)).Select();
Excel.Selection.Value = num2cell(forces);

% Insert results
begin_col = 11;
[~, plusc] = insert_struct_into_excel(max, 'Maximums', Excel, [1, begin_col]);
begin_col = begin_col + plusc + 2;
[~, plusc] = insert_struct_into_excel(Prop, 'Propellants', Excel, [1, begin_col]);
begin_col = begin_col + plusc + 2;
[~, plusc] = insert_struct_into_excel(Eng, 'Engine', Excel, [1, begin_col]);
begin_col = begin_col + plusc + 2;
[~, plusc] = insert_struct_into_excel(Roc, 'Rocket', Excel, [1, begin_col]);
begin_col = begin_col + plusc + 2;

% Save
WB.Save();
% Quit Excel
Excel.Quit();
