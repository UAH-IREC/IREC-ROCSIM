
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