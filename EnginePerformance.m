clc,clear
startup % run startup script for CEA and Coolprop
format shortG

% General Constans and Assumptions
g = 9.81; % m/s2
m2f = 3.28084; % convert meters to feet
psi2pa = 6894.76; % convert psi to Pa
lb2kg = 0.453592; % convert lbs to kg
lb2N = 4.448; % convert lbs to N
in2m = 0.0254; % convert in to m

%% Determine Tc for various Engine params

Tamb = 300; % Ambient Temperature [K] (305K is 90F)

% Propellant Selection & Properties
Prop.ox.name = {'NITROUSOXIDE','N2O'}; % Nitrous Oxide
Prop.f.name = {'ETHANE','C2H6'};
oxname = char(Prop.ox.name(2));
fname = char(Prop.f.name(2));
Eng.MR = 4:0.5:15;

% Assumed Engine Performance Values
Eng.pct_psi = 200:100:400; % Chamber total pressure [psia]
Eng.eps = 4; % Nozzle expansion ratio (Ae/At)

% Derived Engine Performance Values
lenMR = length(Eng.MR);
lenpct = length(Eng.pct_psi);
leneps = length(Eng.eps);
%lenMR*lenpct*leneps

Eng.Tc = zeros(lenMR,lenpct,leneps);
Eng.Cfvac = zeros(lenMR,lenpct,leneps);
Eng.Isp_vac = zeros(lenMR,lenpct,leneps);
Eng.cstar_th = zeros(lenMR,lenpct,leneps);

for i = 1:lenMR
    lenMR-i
    for j = 1:lenpct
        for k = 1:leneps
[data] = CEA_Rocket(oxname,fname,Eng.pct_psi(j),Eng.MR(i),Eng.eps(k),Tamb,Tamb);
Eng.Tc(i,j,k) = double(data.Temperature(3)); % Chamber Temperature (try to keep it low)
Eng.Cfvac(i,j,k) = data.cf(3); % Exit thrust coefficient, vacuum
Eng.Isp_vac(i,j,k) = double(data.isp(3)); % Vacuum Isp [s]
Eng.cstar_th(i,j,k) = (g*Eng.Isp_vac(i,j,k))/Eng.Cfvac(i,j,k); % Theoretical C* [m/s]
        end
    end
end

figure(1)
plot(Eng.MR(:), Eng.Tc(:,2))
figure(2)
plot(Eng.MR(:), Eng.Isp_vac(:,2))