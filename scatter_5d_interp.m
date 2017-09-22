function ret = scatter_5d_interp(X1, X2, X3, X4, X5, Y, sample)
coder.extrinsic('warning');
ret = [0 0 0 0];
x1 = sample(1);
data_4d = Y(1, :, :, :, :, :); data_3d = []; data_2d = []; data_1d = [];
if x1 < min(X1) || x1 > max(X1)
    warning('1st dimension sample point outside interpolation range');
end
for n = 1:(length(X1) - 1)
    if X1(n) <= x1 && X1(n + 1) > x1
        frac = (x1 - X1(n)) / (X1(n + 1) - X1(n));
        data_4d = Y(n, :, :, :, :, :) + frac .* (Y(n + 1, :, :, :, :, :) - Y(n, :, :, :, :, :));
    end
end

x2 = sample(2);
if x2 < min(X2) || x2 > max(X2)
    warning('2nd dimension sample point outside interpolation range');
end
for n = 1:(length(X2) - 1)
    if X2(n) <= x2 && X2(n + 1) > x2
        frac = (x2 - X2(n)) / (X2(n + 1) - X2(n));
        data_3d = data_4d(1, n, :, :, :, :) + frac .* (data_4d(1, n + 1, :, :, :, :) - data_4d(1, n, :, :, :, :));
    end
end

x3 = sample(3);
if x3 < min(X3) || x3 > max(X3)
    warning('3rd dimension sample point outside interpolation range');
end
for n = 1:(length(X3) - 1)
    if X3(n) <= x3 && X3(n + 1) > x3
        frac = (x3 - X3(n)) / (X3(n + 1) - X3(n));
        data_2d = data_3d(1, 1, n, :, :, :) + frac .* (data_3d(1, 1, n + 1, :, :, :) - data_3d(1, 1, n, :, :, :));
    end
end

x4 = sample(4);
if x4 < min(X4) || x4 > max(X4)
    warning('4th dimension sample point outside interpolation range');
end
for n = 1:(length(X4) - 1)
    if X4(n) <= x4 && X4(n + 1) > x4
        frac = (x4 - X4(n)) / (X4(n + 1) - X4(n));
        data_1d = data_2d(1, 1, 1, n, :, :) + frac .* (data_2d(1, 1, 1, n + 1, :, :) - data_2d(1, 1, 1, n, :, :));
    end
end

x5 = sample(5);
if x5 < min(X5) || x5 > max(X5)
    warning('5th dimension sample point outside interpolation range');
end
for n = 1:(length(X5) - 1)
    if X5(n) <= x5 && X5(n + 1) > x5
        frac = (x5 - X5(n)) / (X5(n + 1) - X5(n));
        ret = data_2d(1, 1, 1, 1, n, :) + frac .* (data_1d(1, 1, 1, 1, n + 1, :) - data_1d(1, 1, 1, 1, n, :));
        ret = reshape(ret, [1, 4]);
    end
end
end

% 
% function ret = CEA_interp(table, pressures, MRs, p, mr)
% coder.extrinsic('warning');
% ret = [5 5 5 5];
% if p < min(pressures) || p > max(pressures)
%     fprintf('p is %f\n', p);
%     fprintf('min press is %f, max press is %f\n', min(pressures), max(pressures));
%     warning('Sample pressure outside interpolation range');
% %     slope = (table(end, :, :) - table(end - 1, :, :)) / (pressures(end) - pressures(end - 1));
% %     newrow = 
% end
% 
% if mr < min(MRs) || mr > max(MRs)
%     warning('Sample mixture ratio outside interpolation range');
% end
% 
% for r = 1:length(pressures)
%     if p >= pressures(r) && p <= pressures(r + 1)
%     	for c = 1:length(MRs)
%             if mr >= MRs(c) && mr <= MRs(c + 1)
%                 pfrac = (p - pressures(r)) / (pressures(r + 1) - pressures(r));
%                 cfrac = (mr - MRs(r)) / (MRs(r + 1) - MRs(r));
%                 
%                 c1 = table(r, c, :) + pfrac * (table(r + 1, c, :) - table(r, c, :));
%                 c2 = table(r, c + 1, :) + pfrac * (table(r + 1, c + 1, :) - table(r, c + 1, :));
%                 ret = c1 + cfrac * (c2 - c1);
%                 break;
%             end
%         end
%         break;
%     end
% end
% end