function [Cf] = Cf_Fun(gamma,pct,pe,pa,epsilon)
% pct: Total chamber pressure
% pe: Exit pressure
% pa: ambient pressure
% epsilon: nozzle area expansion ratio

Cf = (2*gamma^2/(gamma-1)*(2/(gamma+1))^((gamma+1)/(gamma-1))*...
    (1-(pe/pct)^((gamma-1)/gamma)))^0.5 + epsilon*((pe-pa)/pct);

end

