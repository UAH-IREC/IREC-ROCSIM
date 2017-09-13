%% Liquid Rocket Script with Simulink
% Model LRSim1D
clc,clear
startup % run startup script for CEA and Coolprop
%runsim() % Uses default parameters
%Changes temperature (K), pressure (Pa), MR, area ratio, and chamber
%pressure (psi)

%READ THESE IN FROM EXCEL LATER
monte_carlo_iterations = 5;

%% Simulation Conditions
atm_conditions = [];
atmoptions = readtable('simconfig.xlsx', 'Sheet', 'Simulation Conditions');

atm_conditions.pamb = param_from_table(atmoptions, 'Ambient pressure', 1);


atm_conditions.Tamb = param_from_table(atmoptions, 'Ambient temperature', 1);


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

prop_params.ox.V = param_from_table(propoptions, 'Oxidizer volume', 1);

prop_params.ox.m = param_from_table(propoptions, 'Oxidizer mass', 1);

%% Rocket Options
rocket_params = [];
rocketoptions = readtable('simconfig.xlsx', 'Sheet', 'Rocket Parameters');
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
mode = 1;

fields = fieldnames(atm_conditions);
for i = 1:numel(fields)
    if ( mode ~= 1 && length(atm_conditions.(fields{i})) ~= 1 && mode ~= length(atm_conditions.(fields{i})) )
        error('You cannot have Monte Carlo and Range in the same sim run');
    elseif ( mode == 1 )
        mode = length(atm_conditions.(fields{i}));
    end
end

fields = fieldnames(engine_params);
for i = 1:numel(fields)
    if ( mode ~= 1 && length(engine_params.(fields{i})) ~= 1 && mode ~= length(engine_params.(fields{i})) )
        error('You cannot have Monte Carlo and Range in the same sim run');
    elseif ( mode == 1 )
        mode = length(engine_params.(fields{i}));
    end
end

%Kinda hacky but whatever. I'd change this later
if ( mode ~= 1 && length(prop_params.ox.V) ~= 1 & mode ~= length(prop_params.ox.V) )
    error('You cannot have Monte Carlo and Range in the same sim run');
elseif ( mode == 1 )
    mode = length(prop_params.ox.V);
end


fields = fieldnames(rocket_params);
for i = 1:numel(fields)
    if ( mode ~= 1 && length(rocket_params.(fields{i})) ~= 1 & mode ~= length(rocket_params.(fields{i})) )
        error('You cannot have Monte Carlo and Range in the same sim run');
    elseif ( mode == 1 )
        mode = length(rocket_params.(fields{i}));
    end
end


%% Simulation Execution
results = [];
startup % run startup script for CEA and Coolprop
if (mode == 1)
    [max, flightdata, forces, Roc, Eng, Prop] = runsim(atm_conditions, prop_params, engine_params, rocket_params);
elseif (mode == 2)
    for run = 1:monte_carlo_iterations
        
        this_run_atm_conditions = [];
        this_run_prop_params = [];
        this_run_engine_params = [];
        this_run_rocket_params = [];
        
        fields = fieldnames(atm_conditions);
        for i = 1:numel(fields)
            if ( length(atm_conditions.(fields{i})) == 1)
                this_run_atm_conditions.(fields{i}) = atm_conditions.(fields{i});
            elseif ( length(atm_conditions.(fields{i})) == 2)
                this_run_atm_conditions.(fields{i}) = normrnd(atm_conditions.(fields{i})(1),atm_conditions.(fields{i})(2));
            end
        end

        fields = fieldnames(engine_params);
        for i = 1:numel(fields)
            if ( length(engine_params.(fields{i})) == 1)
                this_run_engine_params.(fields{i}) = engine_params.(fields{i});
            elseif ( length(engine_params.(fields{i})) == 2)
                this_run_engine_params.(fields{i}) = normrnd(engine_params.(fields{i})(1),engine_params.(fields{i})(2));
            end
        end

        %Kinda hacky but whatever. I'd change this later
        this_run_prop_params.ox.name = prop_params.ox.name;
        this_run_prop_params.f.name = prop_params.f.name;
        
        if ( length(prop_params.ox.V) == 1)
            this_run_prop_params.ox.V = prop_params.ox.V;
        elseif ( length(prop_params.ox.V) == 2)
            this_run_prop_params.ox.V = normrnd(prop_params.ox.V(1),prop_params.ox.V(2));
        end
        


        fields = fieldnames(rocket_params);
        for i = 1:numel(fields)
            if ( length(rocket_params.(fields{i})) == 1)
                this_run_rocket_params.(fields{i}) = rocket_params.(fields{i});
            elseif ( length(rocket_params.(fields{i})) == 2)
                this_run_rocket_params.(fields{i}) = normrnd(rocket_params.(fields{i})(1),rocket_params.(fields{i})(2));
            end
        end
        
        [max, flightdata, forces, Roc, Eng, Prop] = runsim(this_run_atm_conditions, this_run_prop_params, this_run_engine_params, this_run_rocket_params)
        %%TODO: Output this somewhere besides the command window
        %results(run) = [max, flightdata, forces, Roc, Eng, Prop]
        
    end
elseif (mode == 3)
    error('Range of values is not yet implemented');
end

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
