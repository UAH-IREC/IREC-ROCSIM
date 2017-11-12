%% Nitrous Oxide

Pmax = 6894.76 * 1500; % 1500 psi
Pmin = 6894.76 * 3; % 3 psi
Tmax = 309; % K
Tmin = 269; % K
pressures_subcooled = Pmin:6894.76:Pmax;
temps_subcooled = Tmin:1:Tmax;
N2Otable = zeros([length(pressures_subcooled), length(temps_subcooled), 3]); % Includes internal energy, enthalpy, density

l = 0;
for n = 1:length(pressures_subcooled)
    for b = 1:length(temps_subcooled)
        N2Otable(n, b, 1) = CoolProp.PropsSI('U', 'T', temps_subcooled(b), 'P', pressures_subcooled(n), 'NitrousOxide');
        N2Otable(n, b, 2) = CoolProp.PropsSI('H', 'T', temps_subcooled(b), 'P', pressures_subcooled(n), 'NitrousOxide');
        N2Otable(n, b, 3) = CoolProp.PropsSI('D', 'T', temps_subcooled(b), 'P', pressures_subcooled(n), 'NitrousOxide');
    end
    msg = sprintf('%0.0f/%0.0f\n', n, length(pressures_subcooled));
    for c = 1:l
        fprintf('\b');
    end
    fprintf(msg);
    l = length(msg);
end
csvwrite('N2O_u_table.csv', N2Otable(:, :, 1));
csvwrite('N2O_h_table.csv', N2Otable(:, :, 2));
csvwrite('N2O_d_table.csv', N2Otable(:, :, 3));
csvwrite('N2O_table_pressures.csv', pressures_subcooled);
csvwrite('N2O_table_temps.csv', temps_subcooled)

%% Saturated properties
Pmin = 87837.4; % Min for saturation
Pmax = 7.245e+006; % Max for saturation
temps_sat = 269:1:309; % K
N2O_sat_l = zeros([length(temps_sat), 4]); % T, u, h, density
N2O_sat_v = zeros([length(temps_sat), 4]); % T, u, h, density
l = 0;
for n = 1:length(temps_sat)
    N2O_sat_l(n, 1) = CoolProp.PropsSI('P', 'T', temps_sat(n), 'Q', 0, 'NitrousOxide');
    N2O_sat_l(n, 2) = CoolProp.PropsSI('U', 'T', temps_sat(n), 'Q', 0, 'NitrousOxide');
    N2O_sat_l(n, 3) = CoolProp.PropsSI('H', 'T', temps_sat(n), 'Q', 0, 'NitrousOxide');
    N2O_sat_l(n, 4) = CoolProp.PropsSI('D', 'T', temps_sat(n), 'Q', 0, 'NitrousOxide');
    
    N2O_sat_v(n, 1) = CoolProp.PropsSI('P', 'T', temps_sat(n), 'Q', 1, 'NitrousOxide');
    N2O_sat_v(n, 2) = CoolProp.PropsSI('U', 'T', temps_sat(n), 'Q', 1, 'NitrousOxide');
    N2O_sat_v(n, 3) = CoolProp.PropsSI('H', 'T', temps_sat(n), 'Q', 1, 'NitrousOxide');
    N2O_sat_v(n, 4) = CoolProp.PropsSI('D', 'T', temps_sat(n), 'Q', 1, 'NitrousOxide');
    
    msg = sprintf('%0.0f/%0.0f\n', n, length(temps_sat));
    for c = 1:l
        fprintf('\b');
    end
    fprintf(msg);
    l = length(msg);
end
csvwrite('N2O_sat_l_P_table.csv', N2O_sat_l(:, 1));
csvwrite('N2O_sat_l_u_table.csv', N2O_sat_l(:, 2));
csvwrite('N2O_sat_l_h_table.csv', N2O_sat_l(:, 3));
csvwrite('N2O_sat_l_d_table.csv', N2O_sat_l(:, 4));

csvwrite('N2O_sat_v_P_table.csv', N2O_sat_v(:, 1));
csvwrite('N2O_sat_v_u_table.csv', N2O_sat_v(:, 2));
csvwrite('N2O_sat_v_h_table.csv', N2O_sat_v(:, 3));
csvwrite('N2O_sat_v_d_table.csv', N2O_sat_v(:, 4));

csvwrite('N2O_sat_temps.csv', temps_sat);