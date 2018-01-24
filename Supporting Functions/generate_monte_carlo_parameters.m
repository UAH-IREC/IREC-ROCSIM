function [ this_run_atm_conditions, this_run_prop_params, this_run_engine_params, this_run_rocket_params, this_run_avionics_params, variedtable] = generate_monte_carlo_parameters(atm_conditions, prop_params, engine_params, rocket_params, avionics_params)
%GENERATE_MONTE_CARLO_PARAMETERS Summary of this function goes here
%   Detailed explanation goes here

this_run_atm_conditions = [];
this_run_prop_params = [];
this_run_engine_params = [];
this_run_rocket_params = [];
this_run_avionics_params = [];

fields = fieldnames(atm_conditions);
variedtable = [];
for i = 1:numel(fields)
    if ( length(atm_conditions.(fields{i})) == 1)
        this_run_atm_conditions.(fields{i}) = atm_conditions.(fields{i});
    elseif ( length(atm_conditions.(fields{i})) == 2)
        this_run_atm_conditions.(fields{i}) = normrnd(atm_conditions.(fields{i})(1),atm_conditions.(fields{i})(2));
        variedtable = [variedtable; [{fields{i}}, this_run_atm_conditions.(fields{i})]];
    end
end

fields = fieldnames(engine_params);
for i = 1:numel(fields)
    if ( length(engine_params.(fields{i})) == 1)
        this_run_engine_params.(fields{i}) = engine_params.(fields{i});
    elseif ( length(engine_params.(fields{i})) == 2)
        this_run_engine_params.(fields{i}) = normrnd(engine_params.(fields{i})(1),engine_params.(fields{i})(2));
        variedtable = [variedtable; [{fields{i}}, this_run_engine_params.(fields{i})]];
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
            elseif ( length(prop_params.(fields{i}).(fields2{j})) == 2)
                this_run_prop_params.(fields{i}).(fields2{j}) = normrnd(prop_params.(fields{i}).(fields2{j})(1),prop_params.(fields{i}).(fields2{j})(2));
                variedtable = [variedtable; [{strcat(fields{i}, '.', fields2{j})}, this_run_prop_params.(fields{i}).(fields2{j})]];
            end
        end
    end
end


fields = fieldnames(rocket_params);
for i = 1:numel(fields)
    if ( length(rocket_params.(fields{i})) == 1)
        this_run_rocket_params.(fields{i}) = rocket_params.(fields{i});
    elseif ( length(rocket_params.(fields{i})) == 2)
        this_run_rocket_params.(fields{i}) = normrnd(rocket_params.(fields{i})(1),rocket_params.(fields{i})(2));
        variedtable = [variedtable; [{fields{i}}, this_run_rocket_params.(fields{i})]];
    end
end

fields = fieldnames(avionics_params);
for i = 1:numel(fields)
    if ( length(avionics_params.(fields{i})) == 1)
        this_run_avionics_params.(fields{i}) = avionics_params.(fields{i});
    elseif ( length(avionics_params.(fields{i})) == 2)
        this_run_avionics_params.(fields{i}) = normrnd(avionics_params.(fields{i})(1),avionics_params.(fields{i})(2));
        variedtable = [variedtable; [{fields{i}}, this_run_avionics_params.(fields{i})]];
    end
end

end

