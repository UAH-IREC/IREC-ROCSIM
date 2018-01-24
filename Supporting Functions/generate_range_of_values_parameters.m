function [ this_run_atm_conditions, this_run_prop_params, this_run_engine_params, this_run_rocket_params, this_run_avionics_params, variedtable] = generate_range_of_values_parameters(atm_conditions, prop_params, engine_params, rocket_params, avionics_params, parameter_coefficients)
%GENERATE_RANGE_OF_VALUE_PARAMETERS Summary of this function goes here
%   Detailed explanation goes here

this_run_atm_conditions = [];
this_run_prop_params = [];
this_run_engine_params = [];
this_run_rocket_params = [];
this_run_avionics_params = [];

parameter_index = 1;

fields = fieldnames(atm_conditions);
variedtable = [];
for i = 1:numel(fields)
    if ( length(atm_conditions.(fields{i})) == 1)
        this_run_atm_conditions.(fields{i}) = atm_conditions.(fields{i});
    elseif ( length(atm_conditions.(fields{i})) == 3)
        this_run_atm_conditions.(fields{i}) = interp1([0,1],[atm_conditions.(fields{i})(1),atm_conditions.(fields{i})(3)],parameter_coefficients(parameter_index));
        variedtable = [variedtable; [{fields{i}}, this_run_atm_conditions.(fields{i})]];
        
        parameter_index = parameter_index+1;
    end
end

fields = fieldnames(engine_params);
for i = 1:numel(fields)
    if ( length(engine_params.(fields{i})) == 1)
        this_run_engine_params.(fields{i}) = engine_params.(fields{i});
    elseif ( length(engine_params.(fields{i})) == 3)
        this_run_engine_params.(fields{i}) = interp1([0,1],[engine_params.(fields{i})(1),engine_params.(fields{i})(3)],parameter_coefficients(parameter_index));
        variedtable = [variedtable; [{fields{i}}, this_run_engine_params.(fields{i})]];
        
        parameter_index = parameter_index+1;
    end
end

fields = fieldnames(prop_params);
for i = 1:numel(fields)
    
    fields2 = fieldnames(prop_params.(fields{i}));
    
    for j = 1:numel(fields2)
        
        if(strcmp(fields2{j},'name'))
            this_run_prop_params.(fields{i}).(fields2{j}) = prop_params.(fields{i}).(fields2{j});
        else
            if ( length(prop_params.(fields{i}).(fields2{j})) == 1)
                this_run_prop_params.(fields{i}).(fields2{j}) = prop_params.(fields{i}).(fields2{j});
            elseif ( length(prop_params.(fields{i}).(fields2{j})) == 3)
                this_run_prop_params.(fields{i}).(fields2{j}) = interp1([0,1],[prop_params.(fields{i}).(fields2{j})(1),prop_params.(fields{i}).(fields2{j})(3)],parameter_coefficients(parameter_index));
                variedtable = [variedtable; [{strcat(fields{i}, '.', fields2{j})}, this_run_prop_params.(fields{i}).(fields2{j})]];
        
                parameter_index = parameter_index+1;
            end
        end
    end
end


fields = fieldnames(rocket_params);
for i = 1:numel(fields)
    if ( length(rocket_params.(fields{i})) == 1)
        this_run_rocket_params.(fields{i}) = rocket_params.(fields{i});
    elseif ( length(rocket_params.(fields{i})) == 3)
        this_run_rocket_params.(fields{i}) = interp1([0,1],[rocket_params.(fields{i})(1),rocket_params.(fields{i})(3)],parameter_coefficients(parameter_index));
        variedtable = [variedtable; [{fields{i}}, this_run_rocket_params.(fields{i})]];
        
        parameter_index = parameter_index+1;
    end
end

fields = fieldnames(avionics_params);
for i = 1:numel(fields)
    if ( length(avionics_params.(fields{i})) == 1)
        this_run_avionics_params.(fields{i}) = avionics_params.(fields{i});
    elseif ( length(avionics_params.(fields{i})) == 3)
        this_run_avionics_params.(fields{i}) = interp1([0,1],[avionics_params.(fields{i})(1),avionics_params.(fields{i})(3)],parameter_coefficients(parameter_index));
        variedtable = [variedtable; [{fields{i}}, this_run_avionics_params.(fields{i})]];
        
        parameter_index = parameter_index+1;
    end
end

end

