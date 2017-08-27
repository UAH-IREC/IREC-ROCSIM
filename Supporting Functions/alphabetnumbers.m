function [alpha_index] = alphabetnumbers(n)
% Converts a numerical index into an Excel-style alphabetical index
%   Detailed explanation goes here
letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
if n <= 26
    alpha_index = letters(n);
else
    alpha_index = strcat(alphabetnumbers((n - mod(n, 26)) / 26), letters(mod(n, 26))); % FIXME: Breaks at 52, but we'll just ignore that for now
end
end

