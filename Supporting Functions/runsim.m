function [max_vals, flightdata, forces, propinfo, INS_data, Roc, Eng, Prop, exec_time] = runsim(Conditions, Prop, Eng, Roc)
%RUNSIM Summary of this function goes here
%   Tamb:               ambient temperature (K)
%   Pamb:               ambient pressure (Pa)
%   MR:                 mixture (OF) ratio
%   expansion_ratio:    Nozzle expansion ratio (Ae/At)
%   chamber_pressure:   Chamber total pressure (psia)
%% Liquid Rocket Script with Simulink
% Model LRSim1D
%clc,clear

format shortG

global N2O_sat_v_P_table N2O_sat_v_u_table N2O_sat_v_h_table N2O_sat_v_d_table...
    N2O_sat_l_P_table N2O_sat_l_u_table N2O_sat_l_h_table N2O_sat_l_d_table N2O_sat_temprange;
PureNitrous = Simulink.Variant('OxPressurizationMode==1');
SuperchargedNitrous = Simulink.Variant('OxPressurizationMode==2');
OxPressurizationMode = 1;
% Coolprop reference
% http://www.coolprop.org/coolprop/wrappers/MATLAB/index.html#matlab

%% Initial Rocket Parameters
% General Constans and Assumptions
g = 9.81; % m/s2
m2f = 3.28084; % convert meters to feet
psi2pa = 6894.76; % convert psi to Pa
lb2kg = 0.453592; % convert lbs to kg
lb2N = 4.448; % convert lbs to N
in2m = 0.0254; % convert in to m

Prop.ox.p = CoolProp.PropsSI('P', 'T', Prop.ox.T, 'Q', 0, char(Prop.ox.name(1))); % [Pa]
Prop.ox.p_psi = Prop.ox.p/psi2pa; % [psi]
Prop.f.p = CoolProp.PropsSI('P', 'T', Prop.f.T, 'Q', 0, char(Prop.f.name(1))); % [Pa]
Prop.f.p_psi = Prop.f.p/psi2pa; % [psi]
Prop.ox.rho = CoolProp.PropsSI('D', 'T', Prop.ox.T, 'Q', 0, char(Prop.ox.name(1))); % [kg/m^3]
Prop.f.rho = CoolProp.PropsSI('D', 'T', Prop.f.T, 'Q', 0, char(Prop.f.name(1))); % [kg/m^3]

[CEAinterp.pressures, CEAinterp.MRs, CEAinterp.eps, CEAinterp.temp_ox, CEAinterp.temp_f, CEAinterp.table] = load_CEA_table();

Roc.Cd = csvread('CdvsM_RASAERO.csv')'; % Courtesy Aaron Hunt

Vull = 0; % Assumed Tank Ullage %

Prop.ox.m = Prop.ox.V*Prop.ox.rho; % [kg]

% Amount of Propellants
Roc.tank.Vox = Prop.ox.V*(1+Vull); % Amount of liquid oxygen [m^3]

Prop.f.m = Prop.f.V * Prop.f.rho; % [kg]
Prop.f.V = Prop.f.m/Prop.f.rho; % [m^3]
Roc.tank.Vf = Prop.f.V*(1+Vull); % [m^3]

Prop.m = Prop.ox.m + Prop.f.m; % total propellant mass [kg]

Roc.tank.Vox_in3 = Roc.tank.Vox/(1.63871*10^-5); % [in^3]
Roc.tank.Vf_in3 = Roc.tank.Vf/(1.63871*10^-5); % [in^3]

%% Propellant initial internal energies
% Oxidizer
Vtank = Roc.tank.Vox; 
Vl = Vtank*(1-Vull);
Vv = Vtank*Vull;
T = Conditions.Tamb;
rhol = CoolProp.PropsSI('D', 'T', T, 'Q', 0, 'NITROUSOXIDE');
rhov = CoolProp.PropsSI('D', 'T', T, 'Q', 1, 'NITROUSOXIDE');
ml = rhol*Vl;
mv = rhov*Vv;
mtot = ml+mv;
qual = @(x) mtot*((1-x)/rhol + x/rhov)-Vtank;
X = fzero(qual,0.5); % Beginning quality of the tank
Prop.ox.U_initial = (X*(CoolProp.PropsSI('U', 'T', T, 'Q', 1, 'NITROUSOXIDE')-...
    CoolProp.PropsSI('U', 'T', T, 'Q', 0, 'NITROUSOXIDE'))+...
    CoolProp.PropsSI('U', 'T', T, 'Q', 0, 'NITROUSOXIDE'))*mtot;

% Fuel
Vtank = Roc.tank.Vf; 
Vl = Vtank*(1-Vull);
Vv = Vtank*Vull;
T = Conditions.Tamb;
rhol = CoolProp.PropsSI('D', 'T', T, 'Q', 0, 'ETHANE');
rhov = CoolProp.PropsSI('D', 'T', T, 'Q', 1, 'ETHANE');
ml = rhol*Vl;
mv = rhov*Vv;
mtot = ml+mv;
qual = @(x) mtot*((1-x)/rhol + x/rhov)-Vtank;
X = fzero(qual,0.5); % Beginning quality of the tank
Prop.f.U_initial = (X*(CoolProp.PropsSI('U', 'T', T, 'Q', 1, 'ETHANE')-...
    CoolProp.PropsSI('U', 'T', T, 'Q', 0, 'ETHANE'))+...
    CoolProp.PropsSI('U', 'T', T, 'Q', 0, 'ETHANE'))*mtot;


    
% Wet Mass and More Derived Performance
Roc.mwet = Prop.m + Roc.minert; % Wet mass of rocket [kg]
Roc.Mprop = Prop.m/Roc.mwet; % Propellant mass ratio
% Eng.thrustGL = (Roc.mwet*g)*Roc.TW; % Thrust on ground level [N]
% Eng.thrustGL_lb = Eng.thrustGL / lb2N; % [lbf]
Eng.dt = (Eng.At/(pi/4))^0.5; % Initial throat diameter [m]
Eng.dt_in = Eng.dt / in2m; % [in]
Eng.Ae = Eng.eps*Eng.At; % Exit area [m^2]
Eng.Ae_in2 = Eng.Ae / (in2m)^2; % [in^2]
Eng.de = (Eng.Ae*4/pi)^0.5; % Exit diameter [in]
Eng.de_in = Eng.de / in2m; % [in]

% Non Sim Parameters
if ~isfield(Eng, 'Lstar')
    warning('Characteristic chamber length not given, assuming 45 in');
    Eng.Lstar = 45*in2m; % Characteristic chamber length [m]
end
Eng.Vc = Eng.Lstar*Eng.At;
Eng.Vc_in3 = Eng.Vc / in2m^3;
if ~isfield(Eng, 'epsc')
    warning('Chamber contraction ratio not given, assuming 7');
    Eng.epsc = 7; % Chamber contraction ratio (From LRE Book p. 73)
end
Eng.Ac = Eng.epsc * Eng.At; % Area of chamber [m^2]
Eng.Ac_in2 = Eng.Ac / in2m^2; % [in]
Eng.dc_in = (Eng.Ac_in2*4/pi)^0.5; % Chamber diameter [in]
if ~isfield(Eng, 'thetac')
    warning('Chamber-to-throat contraction angle not specified, assuming 45 degrees');
    Eng.thetac = 45; % Chamber/throat contraction angle [deg]
end
Eng.At_in2 = Eng.At * 100^2 / 2.54^2;
Eng.Lc_in = ((Eng.Vc_in3/Eng.At_in2)-(1/3)*(Eng.At_in2/pi)^0.5 * cotd(Eng.thetac)*(Eng.epsc^1/3 - 1))/Eng.epsc; % Chamber length [in]
if ~isfield(Eng, 'alpn')
    warning('Nozzle cone angle not specified, assuming 15 degrees');
    Eng.alpn = 15; % Cone nozzle angle [deg]
end
Eng.Ln_in = ((Eng.de_in-Eng.dt_in)/2) / tand(Eng.alpn); % Cone nozzle length [in]

Roc.A = pi * Roc.d^2 / 4;

%% Simulation Section
options = simset('SrcWorkspace','current');

if ~isfield(Conditions, 'tend')
    tend = 90; % End time of sim in seconds
else
    tend = Conditions.tend;
end

tic % Record sim computation time
    load_system('LR_Traject_Sim.slx');
    set_param('LR_Traject_Sim/INS Modelling/Accelerometer Noise', 'Seed', num2str(floor(mod(now * 1000, 1) * 1000000)*100)); 
    simOut = sim('LR_Traject_Sim.slx', [], options);
    Flight.max.alt = max(flightdata(:,4))*m2f; % [ft]
    Flight.max.mach = max(flightdata(:,5)); % V/a
    Flight.max.accel = max(flightdata(:,2))/g; % [g]
    Flight.max.Q = max(forces(:,2))*0.2248; % Drag force[lb]
    Flight.max.load = max(forces(:,2)+forces(:,3))*0.2248; % Compressive load [lb]
    Flight.max.thrust = max(forces(:,3))*0.2248; % Thrust force[lb]
    Flight.max.impulse = max(flightdata(:, 6)); % [N*s]
    Flight.max.Isp = Flight.max.impulse / ((max(forces(:, 1)) - min(forces(:, 1))) * g);
    temp = find(~flightdata(5:end, 3));
    Flight.max.burnout_predicted_apogee = INS_data(115, 5)*m2f;
    max_vals = Flight.max;

exec_time = toc;

end
