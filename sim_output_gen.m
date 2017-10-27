function ret = sim_output_gen(Excel, flightdata, forces, propinfo, INS_data, max, Prop, Eng, Roc)
% Write the simulation and simulation input parameters described by
% flightdata, forces, propinfo, max, Prop, Eng, and Roc into the current
% active Excel sheet
Excel.Range('A1:K1').Select();
Excel.Selection.Value = {'Time (s)', 'Acceleration (m/s)', 'Velocity (m/s)',...
    'Altitude (m)', 'Mach Number', 'Total Delivered Impulse (N*s)', 'Y Acceleration (m/s^2)', 'Y Velocity (m/s',...
    'X Acceleration (m/s^2)', 'X Velocity (m/s)', 'X Position (m)'};
[rows, ~] = size(flightdata);
Excel.Range(sprintf('A2:K%i', rows)).Select();
Excel.Selection.Value = num2cell(flightdata);

Excel.Range('L1:N1').Select();
Excel.Selection.Value = {'Mass (kg)', 'Drag (N)', 'Thrust (N)'};
[rows, ~] = size(forces);
Excel.Range(sprintf('L2:N%i', rows)).Select();
Excel.Selection.Value = num2cell(forces);

Excel.Range('O1:AA1').Select();
Excel.Selection.Value = {'Remaining Oxidizer Mass (kg)', 'Oxidizer Tank Quality', 'Remaining Fuel Mass (kg)',...
    'Fuel Tank Quality', 'Chamber Pressure (Pa)', 'Mixture Ratio', 'Specific Impulse (s)',...
    'Thrust Coefficient', 'Vacuum Thrust Coefficient', 'Exit Pressure',...
    'Ambient Pressure', 'Ox Tank Pressure (Pa)', 'Fuel Tank Pressure (Pa)'};
[rows, ~] = size(propinfo);
Excel.Range(sprintf('O2:AA%i', rows)).Select();
Excel.Selection.Value = num2cell(propinfo);

Excel.Range('AC1:AG1').Select();
Excel.Selection.Value = {'Time (s)', 'Acceleration (m/s^2)', 'Velocity (m/s)', 'Altitude (m)', 'Projected Apogee (m)'};
[rows, ~] = size(INS_data);
Excel.Range(sprintf('AC2:AG%i', rows)).Select();
Excel.Selection.Value = num2cell(INS_data);

% Insert results
begin_col = 37;
[~, plusc] = insert_struct_into_excel(max, 'Maximums', Excel, [1, begin_col]);
begin_col = begin_col + plusc + 2;
[~, plusc] = insert_struct_into_excel(Prop, 'Propellants', Excel, [1, begin_col]);
begin_col = begin_col + plusc + 2;
[~, plusc] = insert_struct_into_excel(Eng, 'Engine', Excel, [1, begin_col]);
begin_col = begin_col + plusc + 2;
[~, plusc] = insert_struct_into_excel(Roc, 'Rocket', Excel, [1, begin_col]);
ret = 0;
end