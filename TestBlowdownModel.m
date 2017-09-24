%test code
clc,clear
% This is all given in the Excel or computer before the sim runs
% All units metric unless otherwise specified
Vtank = 0.026; 
Vull = 0.15;
Vl = Vtank*(1-Vull);
Vv = Vtank*Vull;
T = 300;
rhol = CoolProp.PropsSI('D', 'T', T, 'Q', 0, 'NITROUSOXIDE');
rhov = CoolProp.PropsSI('D', 'T', T, 'Q', 1, 'NITROUSOXIDE');
ml = rhol*Vl;
mv = rhov*Vv;
mtot = ml+mv;
qual = @(x) mtot*((1-x)/rhol + x/rhov)-Vtank;
X = fzero(qual,0.5); % Beginning quality of the tank
Utot = (X*(CoolProp.PropsSI('U', 'T', T, 'Q', 1, 'NITROUSOXIDE')-...
    CoolProp.PropsSI('U', 'T', T, 'Q', 0, 'NITROUSOXIDE'))+...
    CoolProp.PropsSI('U', 'T', T, 'Q', 0, 'NITROUSOXIDE'))*mtot;
% Uconst doesn't need to be found but is shown that it does exist.
Uconst = Utot - ml*CoolProp.PropsSI('U', 'T', T, 'Q', 0, 'NITROUSOXIDE') + ...
    mv*CoolProp.PropsSI('U', 'T', T, 'Q', 1, 'NITROUSOXIDE');


mdot = -1;
dt = 0.1;
m = mtot;
U = Utot;
ET = 0;
dT = -10;
Ti = T + dT*dt;
xi = X;
iter = 0;
len = dt:dt:20;
propFlag = 1;

rhoH20 = 998;
Pc = 500*6894.76; % [Pa]
Cv = 2;
Cd = 0.8;
gal_min2m3_s = 0.00378541/60;
P2 = ((CoolProp.PropsSI('P', 'T', T, 'Q', 0, 'NITROUSOXIDE')/6894.76) - ...
    rhol/rhoH20/(Cv*rhol/abs(mdot)*gal_min2m3_s)^2)*6894.76;
A = abs(-mdot)/(Cd*sqrt(2*rhol*(P2-Pc)));
N = 19;
d = sqrt((A/N)*(4/pi))*39.3701;

for i = 1:length(len)

while iter < 50 && propFlag == 1
hi = CoolProp.PropsSI('H', 'T', Ti, 'Q', 0, 'NITROUSOXIDE');
dm = mdot*dt;
dU = dm*hi;
mi = m+dm;
Ui = U+dU;
ul = CoolProp.PropsSI('U', 'T', Ti, 'Q', 0, 'NITROUSOXIDE');
uv = CoolProp.PropsSI('U', 'T', Ti, 'Q', 1, 'NITROUSOXIDE');
xi = (Ui/mi - ul)/(uv-ul);
rhol = CoolProp.PropsSI('D', 'T', Ti, 'Q', 0, 'NITROUSOXIDE');
rhov = CoolProp.PropsSI('D', 'T', Ti, 'Q', 1, 'NITROUSOXIDE');
mchk = Vtank*((1-xi)/rhol + xi/rhov)^(-1);
ETi = mi - mchk;
dE = (ETi - ET)/(Ti-T);
Tnew = Ti - ETi/dE;
if Tnew > 309
    Tnew = 309;
end
%err = (Tnew - Ti)/Tnew; % This one is crappy 
err = ETi/mi;
if abs(err) < 0.001
    break
end
ET = ETi;
T = Ti;
Ti = Tnew;
iter = iter+1;

end
iter = 0;
m = mi;
U = Ui;
if xi >= 1
    propFlag = 0; % No more liquid
    xi = 1;
end

To(i) = Ti;
mo(i) = m;
Uo(i) = Ui;
xo(i) = xi;
mvo(i) = mi*xi;
po(i) = CoolProp.PropsSI('P', 'T', Ti, 'Q', 0, 'NITROUSOXIDE')/6894.76;
p2(i) = (po(i) - rhol/rhoH20/(Cv*rhol/abs(mdot)*gal_min2m3_s)^2);
pc(i) = (p2(i)*6894.76 - (abs(mdot)/(Cd*A))^2/(2*rhol))/6894.76;

end

%% Plots
figure(1)
plot(len,To)
figure(2)
plot(len,mo)
figure(3)
plot(len,Uo)
figure(3)
plot(len,xo)
figure(4)
yyaxis left
plot(len,To)
yyaxis right
plot(len,po)
figure(5)
yyaxis left
plot(len,mo,len,mvo)
yyaxis right
plot(len,xo)
figure(6)
plot(len,po,len,p2,len,pc)

%% mdot Calc
rhoH20 = 998;
Pc = 400*6894.76; % [Pa]
P2 = 1.2*Pc;
Ptank = CoolProp.PropsSI('P', 'T', 300, 'Q', 0, 'NITROUSOXIDE');
rho = CoolProp.PropsSI('D', 'T', 300, 'Q', 0, 'NITROUSOXIDE');
%CdA = 0.8*(8*10^-6);
oxmdot = 1;
Cv = (oxmdot/rho/gal_min2m3_s)*sqrt((rho/rhoH20)/((Ptank-P2)/6894.76))
Cd = 0.8;
A = oxmdot/(Cd*sqrt(2*rho*(P2-Pc)));
N = 19;
d = sqrt((A/N)*(4/pi))*39.3701

% errfcn = @(mdot) mdot - CdA * sqrt(2 * rho * (Ptank - mdot^2 / (Cv^2 * rho * rhoH20) - Pc));
% oxmdot = fzero(errfcn, mdot_guess)
Ptank_psi = Ptank/6894.76
P2_psi = P2/6894.76
Pc_psi = Pc/6894.76
dPt_P2 = Ptank_psi - P2_psi
dP2_Pc = P2_psi - Pc_psi

P2 = (Ptank - (rho/rhoH20)/(10*rho/oxmdot)^2)/6894.76
V = oxmdot/(rho*pi/4*(3/8*0.0254)^2)*3.28084