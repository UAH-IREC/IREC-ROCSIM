%% Liquid Rocket Script with Simulink
% Model LRSim1D
clc,clear
startup % run startup script for CEA and Coolprop
%runsim() % Uses default parameters
%Changes temperature (K), pressure (Pa), MR, area ratio, and chamber
%pressure (psi)

%READ THESE IN FROM EXCEL LATER

%% Simulation Conditions
atm_conditions = [];
atmoptions = readtable('simconfig.xlsx', 'Sheet', 'Simulation Conditions (Weather)');

atm_conditions.pamb = param_from_table(atmoptions, 'Ambient pressure', 1);


atm_conditions.Tamb = param_from_table(atmoptions, 'Ambient temperature', 1);

atm_conditions.launchaltitude = param_from_table(atmoptions, 'Launch Altitude', 1);

monte_carlo_iterations = param_from_table(atmoptions, '# of Monte Carlo runs', 1);

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

prop_params.ox.Cv_valves = param_from_table(propoptions, 'Oxidizer Valve Cv', 1);

prop_params.ox.T = param_from_table(propoptions, 'Oxidizer temperature', 1);

prop_params.f.V = param_from_table(propoptions, 'Fuel volume', 1);

prop_params.f.m = param_from_table(propoptions, 'Fuel Mass', 1);

prop_params.f.Cv_valves = param_from_table(propoptions, 'Fuel Valve Cv', 1);

prop_params.f.T = param_from_table(propoptions, 'Fuel temperature', 1);

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

engine_params.cstar_eta = param_from_table(engineoptions, 'C* efficiency', 1);

engine_params.m = param_from_table(engineoptions, 'Engine mass', 1);

engine_params.epsc = param_from_table(engineoptions, 'Contraction ratio', 1);

engine_params.Lstar = param_from_table(engineoptions, 'Characteristic length', 1);

engine_params.MR = param_from_table(engineoptions, 'Mixture ratio', 1);

engine_params.thetac = param_from_table(engineoptions, 'Chamber-to-throat contraction angle', 1);

engine_params.At = param_from_table(engineoptions, 'Engine throat area', 1);

engine_params.alpn = param_from_table(engineoptions, 'Nozzle cone half angle', 1);

engine_params.injector_f_Atotal = param_from_table(engineoptions, 'Fuel Injector Area', 1);

engine_params.injector_ox_Atotal = param_from_table(engineoptions, 'Oxidizer Injector Area', 1);

engine_params.injector_f_Cd = param_from_table(engineoptions, 'Fuel Injector Cd', 1);

engine_params.injector_ox_Cd = param_from_table(engineoptions, 'Oxidizer Injector Cd', 1);

%% Mode Detection

% 1 is single
% 2 is monte carlo
% 3 is range
mode = detect_value_types(atm_conditions, prop_params, engine_params, rocket_params);

%% Simulation Execution
results = [];


startup % run startup script for CEA and Coolprop
if (mode == 1)
    [keyinfo, flightdata, forces, propinfo, Roc, Eng, Prop] = runsim(atm_conditions, prop_params, engine_params, rocket_params);
elseif (mode == 2)
    %error('Monte Carlo isn''t quite ready yet. Check back later!');
    fieldrecord = cell([monte_carlo_iterations, 1]);
    fullsims = cell([monte_carlo_iterations, 1]);
    for runNum = 1:monte_carlo_iterations
        fprintf('\nOn iteration %.0f of %.0f', runNum, monte_carlo_iterations);
        
        [this_run_atm_conditions, this_run_prop_params, this_run_engine_params, this_run_rocket_params, varied_fields] = generate_monte_carlo_parameters(atm_conditions, prop_params, engine_params, rocket_params);
        
        [keyinfo, flightdata, forces, propinfo, Roc, Eng, Prop] = runsim(this_run_atm_conditions, this_run_prop_params, this_run_engine_params, this_run_rocket_params);
        fieldrecord(runNum) = {varied_fields};
        data.flightdata = flightdata;
        data.keyinfo = keyinfo;
        data.forces = forces;
        data.Roc = Roc;
        data.Eng = Eng;
        data.Prop = Prop;
        data.propinfo = propinfo;
        fullsims{runNum} = data;
        results(runNum,:) = [keyinfo.alt, keyinfo.mach, keyinfo.accel, keyinfo.Q, keyinfo.load, keyinfo.thrust, this_run_rocket_params.minert, (Prop.m)/(Prop.m+this_run_rocket_params.minert)];
        
    end
elseif (mode == 3)
    error('Range of values is not yet implemented');
end


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
    sim_output_gen(Excel, flightdata, forces, propinfo, keyinfo, Prop, Eng, Roc);
    
elseif (mode == 2)
    WS.Add([], WS.Item(WS.Count));
    WS.Item(WS.Count).Name = 'Summary';
    % Delete default sheets
    while WS.Count > 1
        WB.Sheets.Item(WS.Count - 1).Delete();
    end
    WB.Sheets.Item(WS.Count).Activate();
    
    tablestart = 5;
    Excel.Range(sprintf('A%i:A%i', tablestart + 2, monte_carlo_iterations + 6)).Select();
    its = 1:monte_carlo_iterations;
    Excel.Selection.Value = its';
    
    % Insert input values
    [num_varied_parameters, ~] = size(fieldrecord{1});
    for i = 1:num_varied_parameters
        cur_record = fieldrecord{1};
        Excel.Range(sprintf('%s%i', alphabetnumbers(i + 1), tablestart)).Select();
        Excel.Selection.Value = 'Input';
        Excel.Range(sprintf('%s%i', alphabetnumbers(i + 1), tablestart + 1)).Select();
        Excel.Selection.Value = cur_record(i, 1);
        for j = 1:monte_carlo_iterations
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
        for i = 1:monte_carlo_iterations
            Excel.Range(sprintf('%s%i', alphabetnumbers(num_varied_parameters + 2 + j - 1), i + tablestart + 1)).Select();
            Excel.Selection.Value = results(i, j);
        end
    end
    
    apogees = results(:,1);
    binstep = (max(apogees) - min(apogees)) / (monte_carlo_iterations / 3);
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
    
    for i = 1:monte_carlo_iterations
        WS.Add([], WS.Item(WS.Count));
        WS.Item(WS.Count).Name = sprintf('Run #%i', i);
        WB.Sheets.Item(WS.Count).Activate();
        this_sim = fullsims(i);
        this_sim = this_sim{:};
        sim_output_gen(Excel, this_sim.flightdata, this_sim.forces,...
            this_sim.propinfo, this_sim.keyinfo, this_sim.Prop,...
            this_sim.Eng, this_sim.Roc);
    end
    
    results = sortrows(results);
    
%     subplot(3,3,1);
%     % Apogee
%     plot(1:monte_carlo_iterations,results(:,1));
%     title('Altitude');
%     subplot(3,3,2);
%     plot([1:monte_carlo_iterations],results(:,2));
%     title('Mach Number');
%     subplot(3,3,3);
%     plot([1:monte_carlo_iterations],results(:,3));
%     title('Acceleration');
%     subplot(3,3,4);
%     plot([1:monte_carlo_iterations],results(:,4));
%     title('Q');
%     subplot(3,3,5);
%     plot([1:monte_carlo_iterations],results(:,5));
%     title('Load');
%     subplot(3,3,6);
%     plot([1:monte_carlo_iterations],results(:,6));
%     title('Thrust');
%     subplot(3,3,7);
%     plot([1:monte_carlo_iterations],results(:,7));
%     title('Dry Mass');
%     subplot(3,3,8);
%     plot([1:monte_carlo_iterations],results(:,8));
%     title('Mass Fraction');
    
end

% Save
%SaveAs(Excel, 'Output/test.xlsx');
invoke(WB, 'SaveAs', fullfile(pwd, fname));
WB.Saved = 1;
%WB.Save(); %As('Output/test.xlsx');
% Quit Excel
Excel.Quit();