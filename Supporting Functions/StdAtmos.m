function [P,rho,T,a] = StdAtmos(alt)
%StdAtmos calulates the standard conditions of the atmosphere
% at a certain height above sea level. 
%   alt: altitude above sea level in either ft or m
%   unit: string, US or SI
%   P: pressure, PSI or Pa
%   rho: density, lb/ft^3 or kg/m^3
%   T: Temperature, F or C

h = alt;
g0 = 9.80655; %m/s^2
M = 0.0289644; %kg/mol
R = 8.31432; %N·m /(mol*K)

% based on https://en.wikipedia.org/wiki/Barometric_formula
if alt < 11000 %b=0
    Pb=101325; Tb=288.15; Lb=-0.0065; hb = 0; rhob=1.225;
    P = Pb*(Tb/(Tb+Lb*(h-hb)))^(g0*M/(R*Lb));
    rho = rhob*(Tb/(Tb+Lb*(h-hb)))^(1 + g0*M/(R*Lb));
    T = Lb*(h-hb) + Tb;
elseif alt < 20000 %b=1
    Pb=22632.1; Tb=216.65; Lb=0; hb = 11000; rhob=0.36391;
    P = Pb*exp(-g0*M*(h-hb)/(R*Tb));
    rho = rhob*exp(-g0*M*(h-hb)/(R*Tb));
    T = Lb*(h-hb) + Tb;
elseif alt < 32000 %b=2
    Pb=5474.89; Tb=216.65; Lb=0.001; hb = 20000; rhob=0.08803;
    P = Pb*(Tb/(Tb+Lb*(h-hb)))^(g0*M/(R*Lb));
    rho = rhob*(Tb/(Tb+Lb*(h-hb)))^(1 + g0*M/(R*Lb));
    T = Lb*(h-hb) + Tb;
elseif alt < 47000 %b=3
    Pb=868.02; Tb=228.65; Lb=0.0028; hb = 32000; rhob=0.01322;
    P = Pb*(Tb/(Tb+Lb*(h-hb)))^(g0*M/(R*Lb));
    rho = rhob*(Tb/(Tb+Lb*(h-hb)))^(1 + g0*M/(R*Lb));
    T = Lb*(h-hb) + Tb;
elseif alt < 51000 %b=4
    Pb=110.91; Tb=270.65; Lb=0; hb = 47000; rhob=0.00143;
    P = Pb*exp(-g0*M*(h-hb)/(R*Tb));
    rho = rhob*exp(-g0*M*(h-hb)/(R*Tb));
    T = Lb*(h-hb) + Tb;
elseif alt < 71000 %b=5
    Pb=66.94; Tb=270.65; Lb=-0.0028; hb = 51000; rhob=0.00086;
    P = Pb*(Tb/(Tb+Lb*(h-hb)))^(g0*M/(R*Lb));
    rho = rhob*(Tb/(Tb+Lb*(h-hb)))^(1 + g0*M/(R*Lb));
    T = Lb*(h-hb) + Tb;
else %b=6
    Pb=3.96; Tb=214.65; Lb=-0.002; hb = 71000; rhob=0.000064;
    P = Pb*(Tb/(Tb+Lb*(h-hb)))^(g0*M/(R*Lb));
    rho = rhob*(Tb/(Tb+Lb*(h-hb)))^(1 + g0*M/(R*Lb));
    T = Lb*(h-hb) + Tb;
end

R_air = 287.058; 
a = (1.4*R_air*T)^0.5; %speed of sound in m/s
T = T-273.15; %Kelvin to Celsius


end

