%% Liquid Rocket Script with Simulink
% Model LRSim1D
clc,clear
startup % run startup script for CEA and Coolprop
%runsim() % Uses default parameters
%Changes temperature (K), pressure (Pa), MR, area ratio, and chamber
%pressure (psi)

%READ THESE IN FROM EXCEL LATER
monte_carlo_iterations = 190;

%% Simulation Conditions
atm_conditions = [];
atmoptions = readtable('simconfig.xlsx', 'Sheet', 'Simulation Conditions (Weather)');

atm_conditions.pamb = param_from_table(atmoptions, 'Ambient pressure', 1);


atm_conditions.Tamb = param_from_table(atmoptions, 'Ambient temperature', 1);


%% Propellant Options
prop_params = [];
% prop_params.ox.garbage = 0;
% prop_params.f.garbage = 0;
propoptions = readtable('simconfig.xlsx', 'Sheet', 'Propellant Parameters (Tanks)');
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

prop_params.ox.V = param_from_table(propoptions, 'Oxidizer volume', 1);

prop_params.ox.m = param_from_table(propoptions, 'Ox Mass', 1);

prop_params.f.V = param_from_table(propoptions, 'Fuel volume', 1);

prop_params.f.m = param_from_table(propoptions, 'Fuel Mass', 1);


%% Rocket Options
rocket_params = [];
rocketoptions = readtable('simconfig.xlsx', 'Sheet', 'Rocket Parameters (Mass)');
rocket_params.minert = param_from_table(rocketoptions, 'Total inert mass', 1);

rocket_params.d = param_from_table(rocketoptions, 'Largest circular diameter', 1);

rocket_params.TW = param_from_table(rocketoptions, 'Thrust-to-weight ratio', 1);

%% Engine Options
engine_params = [];
engineoptions = readtable('simconfig.xlsx', 'Sheet', 'Engine Parameters');
engine_params.pct_psi = param_from_table(engineoptions, 'Chamber pressure', 1);

engine_params.eps = param_from_table(engineoptions, 'Expansion ratio', 1);

engine_params.cstar_eta = param_from_table(engineoptions, 'C*', 1);

engine_params.m = param_from_table(engineoptions, 'Engine mass', 1);

engine_params.epsc = param_from_table(engineoptions, 'Contraction ratio', 1);

engine_params.Lstar = param_from_table(engineoptions, 'Characteristic length', 1);

engine_params.MR = param_from_table(engineoptions, 'Mixture ratio', 1);

engine_params.thetac = param_from_table(engineoptions, 'Chamber-to-throat contraction angle', 1);

engine_params.alpn = param_from_table(engineoptions, 'Nozzle cone half angle', 1);


%% Mode Detection

% 1 is single
% 2 is monte carlo
% 3 is range
mode = detect_value_types(atm_conditions, prop_params, engine_params, rocket_params);

%% Simulation Execution
results = [];


startup % run startup script for CEA and Coolprop
if (mode == 1)
    [max, flightdata, forces, Roc, Eng, Prop] = runsim(atm_conditions, prop_params, engine_params, rocket_params);
elseif (mode == 2)
    %error('Monte Carlo isn''t quite ready yet. Check back later!');
    for runNum = 1:monte_carlo_iterations
        fprintf('\nOn iteration %.0f of %.0f', runNum, monte_carlo_iterations);
        
        [this_run_atm_conditions, this_run_prop_params, this_run_engine_params, this_run_rocket_params] = generate_monte_carlo_parameters(atm_conditions, prop_params, engine_params, rocket_params);
        
        [max, flightdata, forces, Roc, Eng, Prop] = runsim(this_run_atm_conditions, this_run_prop_params, this_run_engine_params, this_run_rocket_params);
        
        results(runNum) = max.alt;
        
    end
elseif (mode == 3)
    error('Range of values is not yet implemented');
end




%% Output

if (mode == 1)
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
    
elseif (mode == 2)
    hist(results);
end