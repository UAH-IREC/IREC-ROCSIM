classdef ParameterType
    %ParameterType describes categories of input data
    %   Input parameters (masses, dimensions, etc) can be set to a 
    %   single value, a range with a simulation run for every value, 
    %   or used in a Monte Carlo simulation with a given mean and 
    %   standard deviation
    
    enumeration
        SingleValue, RangeOfValues, MonteCarlo
    end
end

