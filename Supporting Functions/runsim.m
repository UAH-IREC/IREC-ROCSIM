function [max_vals, flightdata, forces, Roc, Eng, Prop] = runsim(Conditions, Prop, Eng, Roc)
%RUNSIM Summary of this function goes here
%   Tamb:               ambient temperature (K)
%   Pamb:               ambient pressure (Pa)
%   MR:                 mixture (OF) ratio
%   expansion_ratio:    Nozzle expansion ratio (Ae/At)
%   chamber_pressure:   Chamber total pressure (psia)
%% Liquid Rocket Script with Simulink
% Model LRSim1D
%clc,clear
startup % run startup script for CEA and Coolprop
format shortG

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

if ~isfield(Conditions, 'Tamb')
    warning('Ambient temperature not provided. Defaulting to 300 K')
    Tamb = 300; % Ambient Temperature [K] (305K is 90F)
else
    Tamb = Conditions.Tamb;
end
if ~isfield(Conditions, 'pamb')
    warning('Ambient pressure not provided. Defaulting to 14.7 psi')
    pamb = 14.7*psi2pa; % Assumed ambient pressure [Pa]
else
    pamb = Conditions.pamb;
end

% Propellant Selection & Properties
if ~isfield(Prop, 'ox') || ~isfield(Prop.ox, 'name')
    warning('Oxidizer not specified. Defaulting to nitrous oxide')
    Prop.ox.name = {'NITROUSOXIDE','N2O'}; % Nitrous Oxide
end
if ~isfield(Prop, 'f') || ~isfield(Prop.f, 'name')
    warning('Fuel not specified. Defaulting to ethane')
    Prop.f.name = {'ETHANE','C2H6'};
end
if ~isfield(Eng, 'MR')
    warning('Engine mixture ratio not provided. Defaulting to 8')
    Eng.MR = 8;
end

Prop.ox.p = CoolProp.PropsSI('P', 'T', Tamb, 'Q', 0, char(Prop.ox.name(1))); % [Pa]
Prop.ox.p_psi = Prop.ox.p/psi2pa; % [psi]
Prop.f.p = CoolProp.PropsSI('P', 'T', Tamb, 'Q', 0, char(Prop.f.name(1))); % [Pa]
Prop.f.p_psi = Prop.f.p/psi2pa; % [psi]
Prop.ox.rho = CoolProp.PropsSI('D', 'T', Tamb, 'Q', 0, char(Prop.ox.name(1))); % [kg/m^3]
Prop.f.rho = CoolProp.PropsSI('D', 'T', Tamb, 'Q', 0, char(Prop.f.name(1))); % [kg/m^3]

% Assumed Engine Performance Values

if ~isfield(Eng, 'pct_psi')
    warning('Combustion chamber pressure not provided. Defaulting to 300 psi')
    Eng.pct_psi = 300; % Chamber total pressure [psia]
end
Eng.pct = Eng.pct_psi*psi2pa; % [Pa]
if ~isfield(Eng, 'eps')
    warning('Engine expansion ratio not provided. Defaulting to 4')
    Eng.eps = 4; % Nozzle expansion ratio (Ae/At)
end

if ~isfield(Eng, 'cstar_eta')
    warning('Cstar value not provided, defaulting to 0.9')
    Eng.cstar_eta = 0.9; % C* Efficiency
end

% Derived Engine Performance Values
[data] = CEA_Rocket(char(Prop.ox.name(2)),char(Prop.f.name(2)),Eng.pct_psi,Eng.MR,Eng.eps,Tamb,Tamb);
Eng.Tc = double(data.Temperature(1)); % Chamber Temperature (try to keep it low)
Eng.Cfvac = data.cf(3); % Exit thrust coefficient, vacuum
Eng.Isp_vac = double(data.isp(3)); % Vacuum Isp [s]
Eng.cstar_th = (g*Eng.Isp_vac)/Eng.Cfvac; % Theoretical C* [m/s]
Eng.cstar = Eng.cstar_th*Eng.cstar_eta; % Expected C* at efficiency determined [m/s]
Eng.pe = data.Pressure(3,1).Value; % Exit Pressure [Pa]
Eng.Cfp = Eng.eps*((Eng.pe-pamb)/Eng.pct); % Pressure term thrust coefficient
Eng.Cf = Eng.Cfvac + Eng.Cfp; % Actual thrust coefficient

% Assumed Rocket Parameters
if ~isfield(Roc, 'Cd')
    warning('Drag coefficients not provided, using CdvsM_RASAERO.csv');
    Roc.Cd = csvread('CdvsM_RASAERO.csv')'; % Courtesy Aaron Hunt
end
if ~isfield(Roc, 'd')
    warning('Maximum rocket diameter not specified, assuming 6 in');
    Roc.d = 6; % 6 diameter of 1st stage [in]
end
Roc.A = (pi/4)*Roc.d^2*0.00064516; % Used for drag calc [m^2]
if ~isfield(Roc, 'TW')
    warning('Target thrust-to-weight ratio not given, assuming 5');
    Roc.TW = 5; % Initial Thrust to Weight Ratio
end
if ~isfield(Roc, 'tanks') || ~isfield(Roc.tanks, 'Vull')
    warning('Ullage volume not given, assuming 15%');
    Vull = 0.15; % Assumed Tank Ullage %
end
if ~isfield(Eng, 'm')
    warning('Engine mass not given, assuming 3 kg');
    Eng.m = 3; % Engine Mass [kg]
end
if isfield(Prop, 'ox') && (isfield(Prop.ox, 'V') || isfield(Prop.ox, 'm'))
    if isfield(Prop.ox, 'V')
        Prop.ox.m = Prop.ox.V*Prop.ox.rho; % [kg]
    else
        Prop.ox.V = Prop.ox.m / Prop.ox.rho; % m^3
    end
else
    warning('Propellant amounts not specified, defaulting to 20 liters of oxidizer');
    Prop.ox.V = 0.02; % Volume of ox [m^3]
    Prop.ox.m = Prop.ox.V*Prop.ox.rho; % [kg]
end

% Amount of Propellants
Roc.tank.Vox = Prop.ox.V*(1+Vull); % Amount of liquid oxygen [m^3]
Prop.f.m = Prop.ox.m/Eng.MR; % [kg]
Prop.f.V = Prop.f.m/Prop.f.rho; % [m^3]
Roc.tank.Vf = Prop.f.V*(1+Vull); % [m^3]
Prop.m = Prop.ox.m + Prop.f.m; % total propellant mass [kg]
Roc.tank.Vox_in3 = Roc.tank.Vox/(1.63871*10^-5); % [in^3]
Roc.tank.Vf_in3 = Roc.tank.Vf/(1.63871*10^-5); % [in^3]

% Find mass of each tank
% Metal Tanks
[Roc.tank.lox,Roc.tank.tox,Roc.tank.Wox,Roc.tank.Fox] = WeldedTankCalc(Roc.tank.Vox_in3,Prop.ox.p_psi,Roc.d/2,'Al6061');
[Roc.tank.lf,Roc.tank.tf,Roc.tank.Wf,Roc.tank.Ff] = WeldedTankCalc(Roc.tank.Vf_in3,Prop.ox.p_psi,Roc.d/2,'Al6061'); 
Roc.tank.mox = Roc.tank.Wox*lb2kg; % [kg]
Roc.tank.mf = Roc.tank.Wf*lb2kg; % [kg]
% Carbon Fiber airframe mass
if ~isfield(Roc, 'airframe_linear_density')
    warning('Airframe linear density not given, assuming 0.6 kg/ft');
    m_6in_CF_ft = (0.6)*2.766/4; % Carbon Fiber 6 in diameter [kg/ft]
else
    m_6in_CF_ft = Roc.airframe_linear_density;
end

Roc.tank.m = Roc.tank.mox + Roc.tank.mf; % Total tank mass [kg]

% Airframe Mass Relationships
if ~isfield(Roc, 'minert')
    warning('Rocket inert mass not specified, assuming many values');
    warning('Assuming mass can affect simulated performance drastically');
    Roc.air.lbody = 1+1+2+2.5; % Estimate of body tube length sections [ft]
    Roc.air.mbody = Roc.air.lbody * m_6in_CF_ft; % [kg]
    Roc.air.mnose = 0.3; % Nose cone [kg]
    Roc.air.mfin = 0.3; % Fins [kg]
    Roc.air.mavi = 1; % Avionics [kg]
    Roc.air.mmisc = 2; % Misc mechanical [kg]
    Roc.air.mrecov = 6; % Recovery [kg]
    Roc.air.m = Roc.air.mbody + Roc.air.mnose + Roc.air.mfin + ...
          Roc.air.mavi + Roc.air.mmisc + Roc.air.mrecov;
    Roc.mpay = 9 * lb2kg; % Payload Mass [kg]
    % Fluid Tubing etc Mass Relationships
    Roc.tank.mvalves = 6*0.5 * lb2kg; % Estimate 6 valves, 0.5 lb/valve [kg]
    Roc.tank.mline = 2; % 5 ft/lb, 17 ft & fittings [kg]

    % Inert mass of Rocket [kg]
    mmarg = 0.15; % Mass margin %
    Roc.minert = (Roc.tank.m + Roc.air.m + Eng.m + Roc.tank.mvalves + ...
        Roc.tank.mline + Roc.mpay) * (1+mmarg); % Inert mass of rocket[kg]
else
    Roc.minert = Roc.minert + Eng.m;
end
    
% Wet Mass and More Derived Performance
Roc.mwet = Prop.m + Roc.minert; % Wet mass of rocket [kg]
Roc.Mprop = Prop.m/Roc.mwet; % Propellant mass ratio
Eng.thrustGL = (Roc.mwet*g)*Roc.TW; % Thrust on ground level [N]
Eng.thrustGL_lb = Eng.thrustGL / lb2N; % [lbf]
Eng.At = Eng.thrustGL/(Eng.pct*Eng.Cf); % Initial throat area [m^2]
Eng.At_in2 = Eng.At / (in2m)^2; % [in^2]
Eng.dt = (Eng.At/(pi/4))^0.5; % Initial throat diameter [m]
Eng.dt_in = Eng.dt / in2m; % [in]
Eng.mdot = Eng.pct*Eng.At/Eng.cstar; % Propellant mass flowrate [kg/s]
Eng.mdot_f = Eng.mdot/(Eng.MR+1); % [kg]
Eng.Qf = Eng.mdot_f/Prop.f.rho; % [m^3/s]
Eng.mdot_ox = Eng.mdot - Eng.mdot_f; % [kg]
Eng.Qox = Eng.mdot_ox/Prop.ox.rho; % [m^3/s]
Eng.Ae = Eng.eps*Eng.At; % Exit area [m^2]
Eng.Ae_in2 = Eng.Ae / (in2m)^2; % [in^2]
Eng.de = (Eng.Ae*4/pi)^0.5; % Exit diameter [in]
Eng.de_in = Eng.de / in2m; % [in]
Eng.tburn = Prop.m / Eng.mdot; % burn time of propellant [s]
Eng.Imp_lb = Eng.thrustGL_lb*Eng.tburn; % Calculated impulse [lb-s]
Eng.Isp = Eng.thrustGL / (g*Eng.mdot); % Specific Impulse [s]

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
Eng.Lc_in = ((Eng.Vc_in3/Eng.At_in2)-(1/3)*(Eng.At_in2/pi)^0.5 * cotd(Eng.thetac)*(Eng.epsc^1/3 - 1))/Eng.epsc; % Chamber length [in]
if ~isfield(Eng, 'alpn')
    warning('Nozzle cone angle not specified, assuming 15 degrees');
    Eng.alpn = 15; % Cone nozzle angle [deg]
end
Eng.Ln_in = ((Eng.de_in-Eng.dt_in)/2) / tand(Eng.alpn); % Cone nozzle length [in]

%% Simulation Section
options = simset('SrcWorkspace','current');

if ~isfield(Conditions, 'tend')
    tend = 90; % End time of sim in seconds
else
    tend = Conditions.tend;
end


tic % Record sim computation time
    simOut = sim('LR_Traject_Sim.slx', [], options);
    Flight.max.alt = max(flightdata(:,3))*m2f; % [ft]
    Flight.max.mach = max(flightdata(:,4)); % V/a
    Flight.max.accel = max(flightdata(:,1))/g; % [g]
    Flight.max.Q = max(forces(:,2))*0.2248; % Drag force[lb]
    Flight.max.load = max(forces(:,2)+forces(:,3))*0.2248; % Compressive load [lb]
    max_vals = Flight.max;

toc

end

