%% Liquid Rocket Script with Simulink
% Model LRSim1D
clc,clear
startup % run startup script for CEA and Coolprop


%runsim() % Uses default parameters
%Changes temperature (K), pressure (Pa), MR, area ratio, and chamber
%pressure (psi)

%READ THESE IN FROM EXCEL LATER

%warning('off','all')

%% Simulation Conditions
atm_conditions = [];
atmoptions = readtable('simconfig.xlsx', 'Sheet', 'Simulation Conditions (Weather)');

atm_conditions.pamb = param_from_table(atmoptions, 'Ambient pressure', 1);

atm_conditions.Tamb = param_from_table(atmoptions, 'Ambient temperature', 1);

atm_conditions.launchaltitude = param_from_table(atmoptions, 'Launch Altitude', 1);

monte_carlo_iterations = param_from_table(atmoptions, '# of Monte Carlo runs', 1);

atm_conditions.rail_length = param_from_table(atmoptions, 'Rail length (effective)', 1);

atm_conditions.launch_angle = deg2rad(param_from_table(atmoptions, 'Launch angle', 1));

atm_conditions.sensors_accel_noise = param_from_table(atmoptions, 'Accelerometer stddev', 1);

atm_conditions.sensors_pressure_total_stddev = param_from_table(atmoptions, 'Total pressure sensor stddev', 1);

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

prop_params.ox.V_ullage_initial = param_from_table(propoptions, 'Oxidizer ullage volume', 1);

prop_params.ox.m = param_from_table(propoptions, 'Ox Mass', 1);

prop_params.ox.Cv_valves = param_from_table(propoptions, 'Oxidizer Valve Cv', 1);

prop_params.ox.T = param_from_table(propoptions, 'Oxidizer temperature', 1);

prop_params.f.V = param_from_table(propoptions, 'Fuel volume', 1);

prop_params.f.V_ullage_initial = param_from_table(propoptions, 'Fuel ullage volume', 1);

prop_params.f.m = param_from_table(propoptions, 'Fuel Mass', 1);

prop_params.f.Cv_valves = param_from_table(propoptions, 'Fuel Valve Cv', 1);

prop_params.f.T = param_from_table(propoptions, 'Fuel temperature', 1);

prop_params.f.filmcooling_divert = param_from_table(propoptions, 'Fuel Diverted to Film Cooling', 1);

%% Rocket Options
rocket_params = [];
rocketoptions = readtable('simconfig.xlsx', 'Sheet', 'Rocket Parameters (Mass)');
rocket_params.minert = param_from_table(rocketoptions, 'Total inert mass', 1);

rocket_params.d = param_from_table(rocketoptions, 'Largest circular diameter', 1);

%rocket_params.TW = param_from_table(rocketoptions, 'Thrust-to-weight ratio', 1);

%% Engine Options
engine_params = [];
engineoptions = readtable('simconfig.xlsx', 'Sheet', 'Engine Parameters');

engine_params.eps = param_from_table(engineoptions, 'Expansion ratio', 1);

engine_params.cstar_eta = param_from_table(engineoptions, 'C* efficiency', 1);

engine_params.m = param_from_table(engineoptions, 'Engine mass', 1);

engine_params.epsc = param_from_table(engineoptions, 'Contraction ratio', 1);

engine_params.Lstar = param_from_table(engineoptions, 'Characteristic length', 1);

%engine_params.MR = param_from_table(engineoptions, 'Mixture ratio', 1);

engine_params.thetac = param_from_table(engineoptions, 'Chamber-to-throat contraction angle', 1);

engine_params.At = param_from_table(engineoptions, 'Engine throat area', 1);

engine_params.alpn = param_from_table(engineoptions, 'Nozzle cone half angle', 1);

engine_params.injector_f_Atotal = param_from_table(engineoptions, 'Fuel Injector Area', 1);

engine_params.injector_ox_Atotal = param_from_table(engineoptions, 'Oxidizer Injector Area', 1);

engine_params.injector_f_Cd = param_from_table(engineoptions, 'Fuel Injector Cd', 1);

engine_params.injector_ox_Cd = param_from_table(engineoptions, 'Oxidizer Injector Cd', 1);

engine_params.ignition_time = param_from_table(engineoptions, 'Ignition Time', 1);

%% Mode Detection

% 1 is single
% 2 is monte carlo
% 3 is range
mode = detect_value_types(atm_conditions, prop_params, engine_params, rocket_params);

%% Simulation Execution
results = [];


startup % run startup script for CEA and Coolprop
if (mode == 1)
    [keyinfo, flightdata, forces, propinfo, INS_data, Roc, Eng, Prop] = runsim(atm_conditions, prop_params, engine_params, rocket_params);
elseif (mode == 2)
    
    fieldrecord = cell([monte_carlo_iterations, 1]);
    fullsims = cell([monte_carlo_iterations, 1]);
    
    exec_times = [0];
    for runNum = 1:monte_carlo_iterations
        fprintf('\n\nOn iteration %.0f of %.0f  ( %.1f%% )', runNum, monte_carlo_iterations, runNum/monte_carlo_iterations*100);
        
        iterations_remaining = monte_carlo_iterations - runNum;
        time_remaining = iterations_remaining * mean(exec_times);
        
        
        curr_time = clock;
        curr_hr = curr_time(4); curr_min = curr_time(5); curr_s = curr_time(6);
        
        finish_hr = floor(curr_hr + time_remaining / (60.0 * 60.0));
        finish_min = floor(curr_min + mod(time_remaining / 60.0,60));
        finish_s = floor(curr_s +  mod(time_remaining,60));
        
        finish_min = finish_min + finish_s/60;
        finish_hr = finish_hr + finish_min/60;
        
        finish_s = floor(mod(finish_s,60));
        finish_min = floor(mod(finish_min,60));
        finish_hr = floor(mod(finish_hr,24));
        
        fprintf('\nEstimated Time Remaining: %4.0f : %02.0f : %02.0f', floor(time_remaining / (60.0 * 60.0)), floor(mod(time_remaining / 60.0,60)), floor(mod(time_remaining,60)));
        fprintf('\nApproximate Time Elapsed: %4.0f : %02.0f : %02.0f', floor(sum(exec_times) / (60.0 * 60.0)), floor(mod(sum(exec_times) / 60.0,60)), floor(mod(sum(exec_times),60)));
        fprintf('\nExtrapolated Finish Time: %4.0f : %02.0f : %02.0f', finish_hr, finish_min, finish_s);
        
        [this_run_atm_conditions, this_run_prop_params, this_run_engine_params, this_run_rocket_params, varied_fields] = generate_monte_carlo_parameters(atm_conditions, prop_params, engine_params, rocket_params);
        
        [keyinfo, flightdata, forces, propinfo, INS_data, Roc, Eng, Prop, exec_time] = runsim(this_run_atm_conditions, this_run_prop_params, this_run_engine_params, this_run_rocket_params);
        
        exec_times(runNum) = exec_time * 1.125; % Multiply by 1.125 so the time estimate is conservative and we don't end up trying to make a graph out of the data in 7 minutes before a poster is due when we thought we'd have an hour
        
        fieldrecord(runNum) = {varied_fields};
        data.flightdata = flightdata;
        data.keyinfo = keyinfo;
        data.forces = forces;
        data.Roc = Roc;
        data.Eng = Eng;
        data.Prop = Prop;
        data.propinfo = propinfo;
        data.INS_data = INS_data;
        fullsims{runNum} = data;
        results(runNum,:) = [keyinfo.alt, keyinfo.mach, keyinfo.accel, keyinfo.Q, keyinfo.load, keyinfo.thrust, this_run_rocket_params.minert, (Prop.m)/(Prop.m+this_run_rocket_params.minert)];
    end
elseif (mode == 3)
    % Return [2, 5, 10] if the first parameter has 2 values, the next
    % has 5, and the 3rd has 10. Preserving order is obviously rather
    % important here
    dimensions = get_sim_dimensions(atm_conditions, prop_params, engine_params, rocket_params);
    dimensions = dimensions + 1;
    
    fprintf('\nDimension Sizes:');
    disp(dimensions);
    
    for i = 1:numel(dimensions)
        if(dimensions(i) <= 1)
            error('The %s range of values parameter has one or fewer items. Decrease the step size for the parameter.',num2ordinal(i));
        end
    end
    
    input_counts = ones([1,length(dimensions)]);
    
    input_counts(end) = 0;
    
    fieldrecord = cell([prod(dimensions), 1]);
    fullsims = cell([prod(dimensions), 1]);
    
    exec_times = [0];
    
    for i = 1:prod(dimensions)
        input_counts(end) = input_counts(end) + 1;
        for j = numel(input_counts):-1:2
            if (input_counts(j) > dimensions(j))
                input_counts(j) = 1;
                input_counts(j-1) = input_counts(j-1) + 1;
            end
        end
        
        input_coefficients = (input_counts-1) ./ (dimensions-1);
        
        fprintf('\n\nOn iteration %.0f of %.0f  ( %.1f%% )', i, prod(dimensions), i/prod(dimensions)*100);
        
        iterations_remaining = prod(dimensions) - i;
        time_remaining = iterations_remaining * mean(exec_times);
        
        
        curr_time = clock;
        curr_hr = curr_time(4); curr_min = curr_time(5); curr_s = curr_time(6);
        
        finish_hr = floor(curr_hr + time_remaining / (60.0 * 60.0));
        finish_min = floor(curr_min + mod(time_remaining / 60.0,60));
        finish_s = floor(curr_s +  mod(time_remaining,60));
        
        finish_min = finish_min + finish_s/60;
        finish_hr = finish_hr + finish_min/60;
        
        finish_s = floor(mod(finish_s,60));
        finish_min = floor(mod(finish_min,60));
        finish_hr = floor(mod(finish_hr,24));
        
        fprintf('\nEstimated Time Remaining: %4.0f : %02.0f : %02.0f', floor(time_remaining / (60.0 * 60.0)), floor(mod(time_remaining / 60.0,60)), floor(mod(time_remaining,60)));
        fprintf('\nApproximate Time Elapsed: %4.0f : %02.0f : %02.0f', floor(sum(exec_times) / (60.0 * 60.0)), floor(mod(sum(exec_times) / 60.0,60)), floor(mod(sum(exec_times),60)));
        fprintf('\nExtrapolated Finish Time: %4.0f : %02.0f : %02.0f', finish_hr, finish_min, finish_s);
        
        [this_run_atm_conditions, this_run_prop_params, this_run_engine_params, this_run_rocket_params, varied_fields] = generate_range_of_values_parameters(atm_conditions, prop_params, engine_params, rocket_params, input_coefficients);
        
        [keyinfo, flightdata, forces, propinfo, INS_data, Roc, Eng, Prop, exec_time] = runsim(this_run_atm_conditions, this_run_prop_params, this_run_engine_params, this_run_rocket_params);
        
        exec_times(i) = exec_time * 1.125;
        
        fieldrecord(i) = {varied_fields};
        data.flightdata = flightdata;
        data.keyinfo = keyinfo;
        data.forces = forces;
        data.Roc = Roc;
        data.Eng = Eng;
        data.Prop = Prop;
        data.propinfo = propinfo;
        data.INS_data = INS_data;
        fullsims{i} = data;
        results(i,:) = [keyinfo.alt, keyinfo.mach, keyinfo.accel, keyinfo.Q, keyinfo.load, keyinfo.thrust, this_run_rocket_params.minert, (Prop.m)/(Prop.m+this_run_rocket_params.minert)];
        
    end
    
    
end

fprintf('\n\nDone Simulating!\n\n');


%% Output

% From https://www.mathworks.com/matlabcentral/answers/2603-add-a-new-excel-sheet-from-matlab
% Connect to Excel
Excel = actxserver('excel.application');
% Get Workbook object
fname = ['Output/sim ' strrep(datestr(now()), ':', '-') '.xlsx'];
% https://www.mathworks.com/matlabcentral/answers/94822-are-there-any-examples-that-show-how-to-use-the-activex-automation-interface-to-connect-matlab-to-ex
Workbooks = Excel.Workbooks;
WB = invoke(Workbooks, 'Add');
% WB = Excel.Workbooks.New(fullfile(pwd, fname), 0, false);
Excel.Visible = true;
% Get Worksheets object
WS = WB.Worksheets;

if (mode == 1)
    % Add after the last sheet
    WS.Add([], WS.Item(WS.Count));
    WS.Item(WS.Count).Name = 'Output';
    % Delete default sheets
    while WS.Count > 1
        WB.Sheets.Item(WS.Count - 1).Delete();
    end
    
    % https://stackoverflow.com/questions/7636567/write-information-into-excel-after-each-loop
    WB.Sheets.Item(WS.Count).Activate();
    sim_output_gen(Excel, flightdata, forces, propinfo, INS_data, keyinfo, Prop, Eng, Roc);
    
elseif (mode == 2 || mode == 3)
    if(mode == 2)
        iteration_count = monte_carlo_iterations;
    else
        iteration_count = prod(dimensions);
    end
    
    WS.Add([], WS.Item(WS.Count));
    WS.Item(WS.Count).Name = 'Summary';
    % Delete default sheets
    while WS.Count > 1
        WB.Sheets.Item(WS.Count - 1).Delete();
    end
    WB.Sheets.Item(WS.Count).Activate();
    
    tablestart = 5;
    Excel.Range(sprintf('A%i:A%i', tablestart + 2, iteration_count + 6)).Select();
    its = 1:iteration_count;
    Excel.Selection.Value = its';
    
    % Insert input values
    [num_varied_parameters, ~] = size(fieldrecord{1});
    for i = 1:num_varied_parameters
        cur_record = fieldrecord{1};
        Excel.Range(sprintf('%s%i', alphabetnumbers(i + 1), tablestart)).Select();
        Excel.Selection.Value = 'Input';
        Excel.Range(sprintf('%s%i', alphabetnumbers(i + 1), tablestart + 1)).Select();
        Excel.Selection.Value = cur_record(i, 1);
        for j = 1:iteration_count
            Excel.Range(sprintf('%s%i', alphabetnumbers(i + 1), j + tablestart + 1)).Select();
            cur_record = fieldrecord{j};
            Excel.Selection.Value = cur_record(i, 2);
        end
    end
    
    output_headers = {'Apogee (ft)', 'Mach Number', 'Acceleration (G)', 'Drag (lbf)',...
        'Load (lbf)', 'Thrust (lbf)', 'Dry Mass (kg)', 'Mass Fraction'};
    Excel.Range(sprintf('%s%i:%s%i', alphabetnumbers(num_varied_parameters + 2),...
        tablestart + 1, alphabetnumbers(num_varied_parameters + 1 + length(output_headers)), tablestart + 1)).Select();
    Excel.Selection.Value = output_headers;
    %Insert output values
    for j = 1:length(output_headers)
        for i = 1:iteration_count
            Excel.Range(sprintf('%s%i', alphabetnumbers(num_varied_parameters + 2 + j - 1), i + tablestart + 1)).Select();
            Excel.Selection.Value = results(i, j);
        end
    end
    
    apogees = results(:,1);
    binstep = (max(apogees) - min(apogees)) / (iteration_count / 3);
    bins = (min(apogees) * 0.99):binstep:(max(apogees) * 1.01);
    [counts] = histc(apogees, bins);
    % Each entry in counts is the number of values between the
    % corresponding entry in bins and the subsequent entry in bins. This
    % means that the last entry in counts will always be zero
    counts = counts(1:end-1);
    
    % Output into Excel will contain the average bin value instead of the
    % endpoints of the bin, for easier plotting. Bin size is readily
    % calculated from the spacing between two bins
    % https://www.mathworks.com/matlabcentral/answers/89845-how-do-i-create-a-vector-of-the-average-of-consecutive-elements-of-another-vector-without-using-a-l#answer_99279
    excel_bins = mean([bins(1:end-1); bins(2:end)])';
    
    Excel.Range(sprintf('%s%i:%s%i', alphabetnumbers(num_varied_parameters ...
        + length(output_headers) + 5), tablestart + 1, ...
        alphabetnumbers(num_varied_parameters + length(output_headers) + 5),...
        tablestart + length(bins) - 1)).Select();
    Excel.Selection.Value = excel_bins;
    Excel.Range(sprintf('%s%i:%s%i', alphabetnumbers(num_varied_parameters ...
        + length(output_headers) + 6), tablestart + 1, ...
        alphabetnumbers(num_varied_parameters + length(output_headers) + 6),...
        tablestart + length(bins) - 1)).Select();
    Excel.Selection.Value = counts;
    
    for i = 1:iteration_count
        WS.Add([], WS.Item(WS.Count));
        WS.Item(WS.Count).Name = sprintf('Run #%i', i);
        WB.Sheets.Item(WS.Count).Activate();
        this_sim = fullsims(i);
        this_sim = this_sim{:};
        sim_output_gen(Excel, this_sim.flightdata, this_sim.forces,...
            this_sim.propinfo, this_sim.INS_data, this_sim.keyinfo,...
            this_sim.Prop, this_sim.Eng, this_sim.Roc);
    end
    
    results = sortrows(results);
    
elseif mode == 3
    
end

% Save
%SaveAs(Excel, 'Output/test.xlsx');
invoke(WB, 'SaveAs', fullfile(pwd, fname));
WB.Saved = 1;
%WB.Save(); %As('Output/test.xlsx');
% Quit Excel
Excel.Quit();