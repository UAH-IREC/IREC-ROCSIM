
pct = 300;
Tox = 300; 
Tf = 300;
epsilon = 4;
Ox = 'N2O';

% Nitrous Oxide / Ethane
Fuel = 'C2H6';
MR = 10.3;
[data] = CEA_Rocket(Ox,Fuel,pct,MR,epsilon,Tox,Tf);
Isp_Ethane = data.isp(3);

% Nitrous Oxide / Propane
Fuel = 'C3H8';
MR = 10;
[data] = CEA_Rocket(Ox,Fuel,pct,MR,epsilon,Tox,Tf);
Isp_Propane = data.isp(3);

% Nitrous Oxide / Propylene
Fuel = 'C3H6';
MR = 9.4;
[data] = CEA_Rocket(Ox,Fuel,pct,MR,epsilon,Tox,Tf);
Isp_Propylene = data.isp(3);

%% Propellant Sat Curves
psi2pa = 6894.76; % convert psi to Pa
% Nitrous Oxide / Ethane
Ox = 'NITROUSOXIDE';
Fuel = 'ETHANE';
Tox = linspace(244.15, 309.52, 100); % -20C to Tcrit [K]
Tf = linspace(244.15, 305.32, 100); % -20C to Tcrit [K]
Tlen = length(Tox);
for i = 1:Tlen
Oxp(i) = CoolProp.PropsSI('P', 'T', Tox(i), 'Q', 0, Ox)/psi2pa; % [psi]
Fp(i) = CoolProp.PropsSI('P', 'T', Tf(i), 'Q', 0, Fuel)/psi2pa; % [psi]
OxLrho(i) = CoolProp.PropsSI('D', 'T', Tox(i), 'Q', 0, Ox); % Liquid [kg/m^3]
FLrho(i) = CoolProp.PropsSI('D', 'T', Tf(i), 'Q', 0, Fuel); % Liquid [kg/m^3]
OxVrho(i) = CoolProp.PropsSI('D', 'T', Tox(i), 'Q', 1, Ox); % Gas [kg/m^3]
FVrho(i) = CoolProp.PropsSI('D', 'T', Tf(i), 'Q', 1, Fuel); % Gas [kg/m^3]
end
Tox = Tox.*9/5-459.67; % [F]
Tf = Tf.*9/5-459.67; % [F]

figure (1)
plot(Tox, Oxp, Tf, Fp)
title('NOx & Ethane Pressure vs. Temperature')
xlabel('Temperature [F]')
ylabel('Pressure [psi]')
legend('NOx','Ethane','Location','northwest')
grid on
figure (2)
plot(Tox, OxLrho, Tf, FLrho)
title('NOx & Ethane Liquid Density vs. Temperature')
xlabel('Temperature [F]')
ylabel('Density [kg/m^3]')
legend('NOx','Ethane','Location','northeast')
grid on
figure (3)
plot(Tox, OxVrho, Tf, FVrho)
title('NOx & Ethane Vapor Density vs. Temperature')
xlabel('Temperature [F]')
ylabel('Density [kg/m^3]')
legend('NOx','Ethane','Location','northwest')
grid on

%% Prop Boil Off
% Q = Cp*m*dT
Ox_cp = 0.88*1000; % [J/(kg K)]
F_cp = 1.75*1000; % [J/(kg K)]
Oxm = 14.49; % [kg]
Fm = 1.812; % [kg]
k = 200; % Thermal conductivity [W/m*K]
OxA = (pi*6*51.6 + 2*4*pi*9)*in2m^2; % Surface Area [m^2]
FA = (pi*6*16.8+ 2*4*pi*9)*in2m^2; % Surface Area [m^2]
ratio = (Ox_cp*Oxm/OxA) / (F_cp*Fm/FA)