function [mdot, sonic_flag] = injector_orifice(P2, P1, T1, gam, Cd, A)
% This function finds mdot of the cavitaing venturi injector 
% INPUT:
%   P2: Downstream pressure (Chamber) [Pa]
%   P1: Upstream pressure [Pa]
%   T1: Upstream temperature [K]
%   gam: Specific heat ratio [unitless]
%   Cd: Injector discharge coefficient [unitless]
%   A: Area of orifice(s) [m^2]
% OUTPUT:
%   mdot: Mass flow rate [kg/s]
%   sonic_flag: 1 if sonic , 0 if not

% Constants
coder.extrinsic('CoolProp.PropsSI');
rho1 = 0;

% Check if flow is choked: https://en.wikipedia.org/wiki/Choked_flow
rho1 = CoolProp.PropsSI('D', 'T', T1, 'P', P1, 'ETHANE'); % [kg/m^3]
sonic_check  = (2/(gam+1))^(gam/(gam-1));
if (P2/P1) <= sonic_check
    % Mass flow choked: https://en.wikipedia.org/wiki/Choked_flow
    sonic_flag = 1; % Sonic condition
    mdot = Cd*A * sqrt(gam*rho1*P1 * (2/(gam+1))^((gam+1)/(gam-1)));
else
    % Mass flow unchoked: http://www.aft.com/documents/AFT-Modeling-Choked-Flow-Through-Orifice.pdf
    sonic_flag = 0;
    mdot = Cd*A*P2 * sqrt(2*rho1/P1 * (gam/(gam-1)) * (P1/P2)^((gam-1)/gam) * ...
        (1+(P2/P1)^((gam-1)/gam)));
end

end