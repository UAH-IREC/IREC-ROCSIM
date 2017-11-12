function [value] = interp2d(x, y, Xrange, Yrange, Ztable)
% 2d interpolation
value = 0;
coder.extrinsic('warning');
if x < min(Xrange) || x > max(Xrange)
    fprintf('Attempting to get properties at a chamber pressure of %f. Minimum is %f, maximum is %f\n', x, min(Xrange), max(Xrange));
    warning('1st dimension sample point outside interpolation range');
end
for n = 1:(length(Xrange) - 1)
    if Xrange(n) <= x && Xrange(n + 1) > x
        frac = (x - Xrange(n)) ./ (Xrange(n + 1) - Xrange(n));
        data_1d = Ztable(n, :) + frac .* (Ztable(n + 1, :) - Ztable(n, :));
    end
end

if y < min(Yrange) || y > max(Yrange)
    fprintf('Attempting to get properties at a mixture ratio of %f. Minimum is %f, maximum is %f\n', y, min(Yrange), max(Yrange));
    warning('2nd dimension sample point outside interpolation range');
end
for n = 1:(length(Yrange) - 1)
    if Yrange(n) <= y && Yrange(n + 1) > y
        frac = (y - Yrange(n)) / (Yrange(n + 1) - Yrange(n));
        value = data_1d(1, n) + frac .* (data_1d(1, n + 1) - data_1d(1, n));
    end
end
end