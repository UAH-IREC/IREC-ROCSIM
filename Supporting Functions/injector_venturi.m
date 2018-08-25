function [mdot, cav_flag] = injector_venturi(P2, P1, T1, Cd, A2)
% This function finds mdot of the cavitaing venturi injector 
% INPUT:
%   P2: Downstream pressure (Chamber) [Pa]
%   P1: Upstream pressure [Pa]
%   T1: Upstream temperature [K]
%   Cd: Injector discharge pressure [unitless]
%   A2: Exit area of injector orifice (not throat) [m^2]
% OUTPUT:
%   mdot: Mass flow rate [kg]
%   cav_flag: 

% Constants
psi2pa = 6894.76; % convert psi to Pa

%Pv = CoolProp.PropsSI('P', 'T', T1, 'Q', 0, 'NITROUSOXIDE'); % [Pa]
%rho1l = CoolProp.PropsSI('D', 'T', T1, 'Q', 0, 'NITROUSOXIDE'); % [kg/m^3]
h1 = CoolProp.PropsSI('H', 'T', T1, 'P', P1, 'NITROUSOXIDE'); % [J/kg]
s1 = CoolProp.PropsSI('S', 'T', T1, 'P', P1, 'NITROUSOXIDE'); % [J/kg/K]
dP_in = P1 - P2;

i = 0;
mdot_old = 0; 
dp_list = (5:5:600) * psi2pa;
for dP = dp_list
    i = i + 1;
    P2 = P1-dP; % [Pa] 
    rho2l = CoolProp.PropsSI('D', 'P', P2, 'Q', 0, 'NITROUSOXIDE');
    rho2v = CoolProp.PropsSI('D', 'P', P2, 'Q', 1, 'NITROUSOXIDE');
    h2l = CoolProp.PropsSI('H', 'P', P2, 'Q', 0, 'NITROUSOXIDE');
    h2v = CoolProp.PropsSI('H', 'P', P2, 'Q', 1, 'NITROUSOXIDE');
    h2 = CoolProp.PropsSI('H', 'P', P2, 'S', s1, 'NITROUSOXIDE');
    x2 = (h2 - h2l)/(h2v-h2l); % Vapor quality
    if x2 < 0
        x2 = 0;
    elseif x2 > 1
        x2 = 1;
    end
    k = (rho2l/rho2v)^(1/3);
    %rho2 = CoolProp.PropsSI('D', 'P', P2, 'S', s1, 'NITROUSOXIDE');
    mdot_M = Cd*A2*k/(x2+k*(1-x2)*rho2v/rho2l)*rho2v*(2*(h1-h2)/...
        (x2*(k^2-1)+1))^0.5; % [kg/s]   
    if mdot_M < mdot_old
        mdot = (mdot_M + mdot_old)/2;
        cav_flag = 1;
        break
    elseif dP > dP_in
        mdot = (mdot_M + mdot_old)/2;
        cav_flag = 0;
        break             
    end
    
    mdot_old = mdot_M;
    
end


end

