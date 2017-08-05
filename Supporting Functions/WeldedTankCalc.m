function [ltank,tc,Wtank,Fa] = WeldedTankCalc(Vtank,pt,a,material)
% Vull: ullage volume %
% Vprop: volume of propellant [m^3]
% pt: Tank pressure [psi]
% a: Tank radius [in]
% material: Tank material choice 'string'
if strcmp('SS316',material)
    % Steel 316 Stainless
    rho = 0.289; % [lb/in^3]
    E = 28000*1000; % [ksi]
    sigma_y = 42100; % [psi]
elseif strcmp('Al6061',material)
    % Aluminum 6061
    rho = 0.0975; % [lb/in^3]
    E = 10000*1000; % [ksi]
    sigma_y = 40000; % [psi]
    sigma_u = 45000; % [psi]
else
    error('WeldedTankCalc: Not a valid material type')
end
% Calculations
FS = 2; % Factor of safety for pressure test
Sw = sigma_u/FS; % Max allowable stress [psi]
ew = 0.8; % Weld efficiency
Vs = 2/3*pi*a^3; % Spherical end Volume [in^3]
K = 0.67; % Knuckle Factor
ts = (pt*a*K+0.5)/(2*Sw); % Skin thickness spherical [in]
Ws = 2*pi*a^2*ts*rho; % Weight [lb]
Vc = Vtank - 2*Vs; % Cylindrical Tank portion size [in^3]
lc = Vc/(pi*a^2);  % Length of cylindrical section [in]
ltank = 2*a + lc; % Total length [in]
tc = pt*a/(Sw*ew); % Skind thickness cylindrical [in]
Wc = 2*pi*a*lc*tc*rho; % Weight cylindrical section [lb]
Wtank = 2*Ws + Wc; % Weight of tank [lb]
Sc = (9*(tc/a)^1.6+0.16*(tc/lc)^1.3)*E; % Critical axial stress [psi]
Fa = pi*a^2*(pt/FS); % Axial load capacity [lb]
end