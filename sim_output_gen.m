function ret = sim_output_gen(Excel, flightdata, forces, propinfo, max, Prop, Eng, Roc)
% Write the simulation and simulation input parameters described by
% flightdata, forces, propinfo, max, Prop, Eng, and Roc into the current
% active Excel sheet
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

Excel.Range('I1:S1').Select();
Excel.Selection.Value = {'Remaining Oxidizer Mass (kg)', 'Oxidizer Tank Quality', 'Remaining Fuel Mass (kg)',...
    'Fuel Tank Quality', 'Chamber Pressure (Pa)', 'Mixture Ratio', 'Specific Impulse (s)',...
    'Thrust Coefficient', 'Vacuum Thrust Coefficient', 'Exit Pressure', 'Ambient Pressure'};
[rows, ~] = size(propinfo);
Excel.Range(sprintf('I2:S%i', rows)).Select();
Excel.Selection.Value = num2cell(propinfo);

% Insert results
begin_col = 21;
[~, plusc] = insert_struct_into_excel(max, 'Maximums', Excel, [1, begin_col]);
begin_col = begin_col + plusc + 2;
[~, plusc] = insert_struct_into_excel(Prop, 'Propellants', Excel, [1, begin_col]);
begin_col = begin_col + plusc + 2;
[~, plusc] = insert_struct_into_excel(Eng, 'Engine', Excel, [1, begin_col]);
begin_col = begin_col + plusc + 2;
[~, plusc] = insert_struct_into_excel(Roc, 'Rocket', Excel, [1, begin_col]);
ret = 0;
end