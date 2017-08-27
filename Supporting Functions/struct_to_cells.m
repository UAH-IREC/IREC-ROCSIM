function [result] = struct_to_cells(struct)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

c = struct2cell(struct);
names = fieldnames(struct);
result = cell(length(c), 2); % Minimum possible size
row_index = 1;
counter = 1;
while counter < length(c) + 1
    current = c(counter);
    if ~isstruct(current{1})
        result(row_index, 1) = names(counter);
        if iscell(current{1})
            result(row_index, 2:3) = cellstr(current{1});
        else
            result(row_index, 2) = c(counter);
        end
        row_index = row_index + 1;
    else %Recursively handle nested structs
        result(row_index, 1) = names(counter);
        row_index = row_index + 1;
        to_insert = struct_to_cells(current{1});
        [rows, cols] = size(to_insert)
        result(row_index:(row_index + rows - 1), 2:(1 + cols)) = to_insert;
        row_index = row_index + rows;
    end
    counter = counter + 1;
end
end

