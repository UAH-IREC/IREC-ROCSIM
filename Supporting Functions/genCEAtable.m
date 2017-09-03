function [table] = genCEAtable(pressures, MRs, Prop, epsilon, Tamb)
% Generates a table of CEA results for chamber pressure vs MR with the
% specified propellants, at the specified expansion ratio and ambient
% temperature
% Pressures: chamber pressures [Pa]
% MRs: mixture ratios
% Prop: only needs to contain Prop.ox.name and Prop.f.name, in the form
% {'NITROUS OXIDE', 'N2O'}
% epsilon: nozzle expansion ratio
% Tamb: ambient temperature [K]

% Outputs:
%   First axis is pressure
%   Second axis is MR
%   Last axis contains
%       Chamber temperature [K]
%       Exit thrust coefficient in a vacuum
%       Vacuum Isp [s]
%       Nozzle exit pressure [Pa]


table = zeros([length(pressures), length(MRs), 4]);
for r = 1:length(pressures)
    for c = 1:length(MRs)
        fprintf('%i/%i\n', (r - 1) * length(MRs) + c, length(pressures) * length(MRs));
        [data] = CEA_Rocket(char(Prop.ox.name(2)),char(Prop.f.name(2)),pressures(r),MRs(c),epsilon,Tamb,Tamb);
        table(r, c, :) = [double(data.Temperature(1)) % Chamber temp
                        double(data.cf(3)) % Exit thrust coefficient, vacuum
                        double(data.isp(3)) % Vacuum Isp [s]
                        data.Pressure(3,1).Value]; % Exit Pressure [Pa]
    end
end
end