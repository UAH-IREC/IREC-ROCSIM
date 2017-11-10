%% Nitrous Oxide

Pmax = 6894.76 * 1500; % 1500 psi
Pmin = 6894.76 * 3; % 3 psi
Tmax = 309; % K
Tmin = 269; % K
pressures = Pmin:6894.76:Pmax;
temps = Tmin:1:Tmax;
N2Otable = zeros([length(pressures), length(temps), 3]); % Includes internal energy, enthalpy, density

l = 0;
for n = 1:length(pressures)
    for b = 1:length(temps)
        N2Otable(n, b, 1) = CoolProp.PropsSI('U', 'T', temps(b), 'P', pressures(n), 'NitrousOxide');
        N2Otable(n, b, 2) = CoolProp.PropsSI('H', 'T', temps(b), 'P', pressures(n), 'NitrousOxide');
        N2Otable(n, b, 3) = CoolProp.PropsSI('D', 'T', temps(b), 'P', pressures(n), 'NitrousOxide');
    end
    msg = sprintf('%0.0f/%0.0f\n', n, length(pressures));
    for c = 1:l
        fprintf('\b');
    end
    fprintf(msg);
    l = length(msg);
    %pause(0.02);
end