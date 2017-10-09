function [atm_conditions, prop_params, engine_params, rocket_params] = changeparameter(param_num, index, ...
    atm_conditions, prop_params, engine_params, rocket_params)
% param_num is the parameter number to change, index is the number within
% the set of values for the parameter (i.e. 3rd of 10 possible values for
% an option), and the other arguments are the original parameters and the
% resulting simulation settings
param_counter = 0;

fields = fieldnames(atm_conditions);
variedtable = [];
for i = 1:numel(fields)
    if ( length(atm_conditions.(fields{i})) == 1)
        atm_conditions.(fields{i}) = atm_conditions.(fields{i});
    elseif ( length(atm_conditions.(fields{i})) == 2)
        error('Mixing Monte Carlo and range of values is currently not supported');
    elseif ( length(atm_conditions.(fields{i})) == 3)
        param_counter = param_counter + 1;
        if param_counter == param_num
            atm_conditions.(fields{i}) = atm_conditions.(fields{i})(1) + index * atm_conditions.(fields{i})(2);
        end
    end
end

fields = fieldnames(engine_params);
for i = 1:numel(fields)
    if ( length(engine_params.(fields{i})) == 1)
        engine_params.(fields{i}) = engine_params.(fields{i});
    elseif ( length(atm_conditions.(fields{i})) == 2)
        error('Mixing Monte Carlo and range of values is currently not supported');
    elseif ( length(engine_params.(fields{i})) == 3)
        param_counter = param_counter + 1;
        if param_counter == param_num
            engine_params.(fields{i}) = engine_params.(fields{i})(1) + index * engine_params.(fields{i})(2);
        end
    end
end

fields = fieldnames(prop_params);
for i = 1:numel(fields)
    
    fields2 = fieldnames(prop_params.(fields{i}));
    
    for j = 1:numel(fields2)
        
        if(strcmp(fields2{j},'name'))
            prop_params.(fields{i}).(fields2{j}) = prop_params.(fields{i}).(fields2{j});
        else
            if ( length(prop_params.(fields{i}).(fields2{j})) == 1)
                prop_params.(fields{i}).(fields2{j}) = prop_params.(fields{i}).(fields2{j});
            elseif ( length(prop_params.(fields{i}).(fields2{j})) == 2)
                error('Mixing Monte Carlo and range of values is currently not supported');
            elseif ( length(prop_params.(fields{i}).(fields2{j})) == 3)
                param_counter = param_counter + 1;
                if param_counter == param_num
                    prop_params.(fields{i}).(fields2{j}) = prop_params.(fields{i}).(fields2{j})(1) + index * prop_params.(fields{i}).(fields2{j})(2);
                end
            end
        end
    end
end


fields = fieldnames(rocket_params);
for i = 1:numel(fields)
    if ( length(rocket_params.(fields{i})) == 1)
        rocket_params.(fields{i}) = rocket_params.(fields{i});
    elseif ( length(rocket_params.(fields{i})) == 2)
        error('Mixing Monte Carlo and range of values is currently not supported');
    elseif ( length(rocket_params.(fields{i})) == 3)
        param_counter = param_counter + 1;
        if param_counter == param_num
            rocket_params.(fields{i}) = rocket_params.(fields{i})(1) + index * rocket_params.(fields{i})(2);
        end
    end
end

end

