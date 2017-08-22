%% Run launch control first for now, don't need to run sim however

K2R = 1.8; % Convert Kelvin to Rankine
D_lb2kg = 16.0185; % Converts US density to SI
Cp_lb2kg = 4186.8; % Converts US Specific heat to SI
Mu_lb2kg = lb2kg/in2m; % Convert [lb/in-s] to [kg/m-s]
gUS = 32.2; % [ft/s^2]
ft2m = in2m*12;

%% Combustion
MR = 5; % MR used only in this script for row biasing
[data] = CEA_Rocket(char(Prop.ox.name(2)),char(Prop.f.name(2)),Eng.pct_psi,MR,Eng.eps,Tamb,Tamb);
Eng.Tc = double(data.Temperature(1)); % Chamber Temperature (try to keep it low)
Eng.Cfvac = data.cf(3); % Exit thrust coefficient, vacuum
Eng.Isp_vac = double(data.isp(3)); % Vacuum Isp [s]
Eng.cstar_th = (g*Eng.Isp_vac)/Eng.Cfvac; % Theoretical C* [m/s]
Eng.cstar = Eng.cstar_th*Eng.cstar_eta; % Expected C* at efficiency determined [m/s]
Eng.pe = data.Pressure(3,1).Value; % Exit Pressure [Pa]
Eng.Cfp = Eng.eps*((Eng.pe-pamb)/Eng.pct); % Pressure term thrust coefficient
Eng.Cf = Eng.Cfvac + Eng.Cfp; % Actual thrust coefficient

[data_heat] = CEA_Rocket_Heat(char(Prop.ox.name(2)),char(Prop.f.name(2)),Eng.pct_psi,MR,Eng.eps,Tamb,Tamb);
Eng.rho = double(data_heat.Density); % Chamber Density [kg/m^3]
Eng.a = double(data_heat.son); % Chamber sonic velocity [m/s]
Eng.pran = data_heat.pran; % Chamber Prandtl #
Eng.cp = double(data_heat.cp); % Specific Heat [J/kg-K]
Eng.mw = double(data_heat.MolarMass); % Molar Mass [kg/kmol]
Eng.mu = double(data_heat.vis); % Viscosity [kg/m-s]
Eng.gam = data_heat.gam; % Specific Heat Ratio

Cpg = Eng.cp./Cp_lb2kg; % Cp of combustion gas [Btu/lb-F]

%% Heat Transfer Calcs
% Length of Film Cooling
Wc = 0.25; % Coolant Flowrate, variable to iterate [lbs/s]
Coolant_per = Wc/(Eng.mdot/lb2kg); % Percentage Coolant
eta = 1;
Cp_L = 0.41; % Specific Heat Capacity at Const P [Btu/lb-F]
Per = pi*Eng.dc_in; % Perimeter of Chamber [in]
lambda = 220; % Heat of vaporization [Btu/lb]
Ts = K2R*CoolProp.PropsSI('T', 'P', Eng.pct, 'Q', 0, char(Prop.f.name(1))); % Coolant Vaporization Temp [R]
Ti = 75+459; % Coolant initial Temp [R]
Tc = Eng.Tc*K2R; % ns Temp [R]
Vg = Eng.mdot/(Eng.rho(1)*Eng.Ac); % Combustion gas velocity [m/s]
Mx = Vg/Eng.a(1);
r = Eng.pran(1)^0.33; % Recovery factor, assumed turbulent
Taw = Tc*(1+r*(Eng.gam(1)-1)/2*Mx^2)/(1+(Eng.gam(1)-1)/2*Mx^2);
hg = ((Eng.rho(1)/lb2kg*in2m^3)*(Vg/in2m))^0.8; % Heat side gas transfer [Btu/in^2-s-R]
L = eta*Wc*Cp_L*(Ts-Ti)/(Per*hg*(Taw-Ts)) + eta*Wc*lambda/(Per*hg*(Taw-Ts));

% Gas Film Cooling
K = 1.5; % Straight edged orifice head loss factor
dPblc = 0.2*Eng.pct_psi; % BLC pressure drop [psi]
rhoL = CoolProp.PropsSI('D', 'P', (Eng.pct_psi+dPblc)*psi2pa, 'Q', 0, char(Prop.f.name(1)))/D_lb2kg;
Ablc = Wc*(2.238*K/(rhoL*dPblc))^0.5; % Total area of BLC holes [in^2]
N = 40; % # of BLC holes
dblc = (3.627*K*Wc^2/(rhoL*dPblc*N^2))^0.25; % Diameter of each BLC hole [in]
Vc = (Wc*lb2kg)/(rhoL*D_lb2kg * Ablc*in2m^2);
%S = (Wc*lb2kg)/(rhoL*D_lb2kg * Vc * Per*in2m) / in2m;
S = dblc; % Coolant gas film thickness [in]
beta = Vg/Vc;
if beta <= 1
    fbeta = (1/beta)^(-1.5*(1/beta - 1));
else
    fbeta = 1 + 0.4*tan(beta-1);
end
invPhi = (S*beta)^(1/8)*fbeta;
A = Per*Eng.Lc_in; % Area to be cooled [in^2]
Cpc = CoolProp.PropsSI('C', 'P', Eng.pct, 'Q', 1, char(Prop.f.name(1)))/Cp_lb2kg; % Coolant Cp [Btu/lb-F]
mu = (46.6*10^-10)*Mx^0.5*Tc^0.6; % Viscosity [lb/in-s]
Rt_avg = (1.5*Eng.dt_in/2 + 0.382*Eng.dt_in/2)/2; % Average Radius at Throat [in]
Twg = 1400 + 459; % Max allowable gas side wall temp [R]
sigma = 1/((1/2*Twg/Tc*(1+(Eng.gam(1)-1)/2*Mx^2)+1/2)^0.68*...
        (1+(Eng.gam(1)-1)/2*Mx^2)^0.12); 
hg = (0.026/Eng.dt_in^0.2 * (mu^0.2*Cpg(2)/Eng.pran(2)^0.6)*...
        (Eng.pct_psi*gUS/(Eng.cstar/ft2m))^0.8*(Eng.dt_in/Rt_avg)^0.1)*...
        (Eng.At_in2/Eng.Ac_in2)^0.9*sigma; % Bartz Heat side gas transfer [Btu/in^2-s-R]
    
%Twg = Taw - (Taw-Ts)*exp(-hg*A*invPhi/(Cpc*Wc)) 
Teff = Taw - (Taw-Ti)*exp(-hg*A/(0.5*Cpc*Wc)); % Max allowable gas side wall temp [R]
Teff_F = Teff - 459 % [F]

%% Converging Nozzle 
pts = 10;
gami = linspace(Eng.gam(1),Eng.gam(2),pts);
Mi = linspace(Mx,1,pts);
Cpgi = linspace(Cpg(1),Cpg(2),pts);
Teff_conv = zeros(1,pts);
sigmai = zeros(1,pts);
hgi = zeros(1,pts);
Ai = zeros(1,pts);
for i = 1:pts
Ai(i) = ((gami(i)+1)/2)^(-(gami(i)+1)/(2*(gami(i)-1)))*...
        1/Mi(i)*(1+((gami(i)-1)/2)*Mi(i)^2)^((gami(i)+1)/(2*(gami(i)-1)))*Eng.At_in2;
sigmai(i) = 1/((1/2*Twg/Tc*(1+(gami(i)-1)/2*Mi(i)^2)+1/2)^0.68*...
        (1+(gami(i)-1)/2*Mi(i)^2)^0.12); 
hgi(i) = (0.026/Eng.dt_in^0.2 * (mu^0.2*Cpg(2)/Eng.pran(2)^0.6)*...
        (Eng.pct_psi*gUS/(Eng.cstar/ft2m))^0.8*(Eng.dt_in/Rt_avg)^0.1)*...
        (Eng.At_in2/Ai(i))^0.9*sigmai; % Bartz Heat side gas transfer [Btu/in^2-s-R]
Teff_conv(i) = Taw - (Taw-Ti)*exp(-hgi*A/(0.5*Cpc*Wc)) - 459; % Max allowable gas side wall temp [F]
end
plot(M,Teff_conv)