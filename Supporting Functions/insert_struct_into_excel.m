function [rows, cols] = insert_struct_into_excel(struct, sname, Excel, corner)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
begin_row = corner(1);
begin_col = corner(2);
Excel.Range(sprintf('%s%i', alphabetnumbers(begin_col), begin_row)).Select();
Excel.Selection.Value = sname;
cells = struct_to_cells(struct);
[rows, cols] = size(cells);
Excel.Range(sprintf('%s%i:%s%i', alphabetnumbers(begin_col), begin_row + 1, alphabetnumbers(cols + begin_col - 1), begin_row + rows)).Select();
Excel.Selection.Value = cells;
rows = rows + 1; % Accounting for title
end

