function ret = CEA_5d_table_gen(pressures, MRs, eps, temp_ox, temp_f)
ret = zeros(length(pressures),...
            length(MRs),...
            length(eps),...
            length(temp_ox),...
            length(temp_f),...
            4);
total = length(pressures) * length(MRs) * length(eps) * length(temp_ox) * length(temp_f);
count = 0;
for n1 = 1:length(pressures)
    for n2 = 1:length(MRs)
        for n3 = 1:length(eps)
            for n4 = 1:length(temp_ox)
                for n5 = 1:length(temp_f)
                    P = pressures(n1);
                    MR = MRs(n2);
                    ep_r = eps(n3);
                    Tox = temp_ox(n4);
                    Tf = temp_ox(n5);
                    
                    [data] = CEA_Rocket('N2O', 'CH4', P, MR, ep_r, Tox, Tf);
                    ret(n1, n2, n3, n4, n5, :) =   [double(data.Temperature(1));
                                                data.cf(3);
                                                double(data.isp(3));
                                                data.Pressure(3,1).Value];
                    count = count + 1;
                    fprintf('Progress: %i/%i\n', count, total);
                end
            end
        end
    end
end
end