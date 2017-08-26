function [value, valtype] = param_from_table(T, param_name, param_col)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
valtype = [];
value = [];
for i = 1:height(T)
    if strcmp(table2cell(T(i, param_col)), param_name)
        % Found parameter area
        valtype = table2cell(T(i, param_col + 1));
        if strcmp(valtype, 'Single value')
            value = str2double(table2cell(T(i, param_col + 2)));
            valtype = ParameterType.SingleValue;
        elseif strcmp(valtype, 'Range of values')
            %Start, step, end
            value = str2double([table2cell(T(i, param_col + 2))
                table2cell(T(i, param_col + 3))
                table2cell(T(i, param_col + 4))])';
            valtype = ParameterType.RangeOfValues;
        elseif strcmp(valtype, 'Monte Carlo')
            %Mean, standard deviation
            value = str2double([table2cell(T(i, param_col + 2))
                table2cell(T(i, param_col + 3))])';
            valtype = ParameterType.MonteCarlo;
        end
    end
end
end

