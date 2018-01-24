function mode = detect_value_types(atm_conditions, prop_params, engine_params, rocket_params, avionics_params)
%DETECT_VALUE_TYPES Summary of this function goes here
%   Detailed explanation goes here

mode = 1;

fields = fieldnames(atm_conditions);
for i = 1:numel(fields)
    
    if(length(atm_conditions.(fields{i})) == 0)
        error('The value for the field "%s" in atmosphere paremeters is empty. Check if the parameter name is in the first column in Excel\nAKA Someone broke the Excel file', fields{i});
    end
    
    if ( mode ~= 1 && length(atm_conditions.(fields{i})) ~= 1 && mode ~= length(atm_conditions.(fields{i})) )
        error('You cannot have Monte Carlo and Range in the same sim run');
    elseif ( mode == 1 )
        mode = length(atm_conditions.(fields{i}));
    end
end

fields = fieldnames(engine_params);
for i = 1:numel(fields)
    
    if(length(engine_params.(fields{i})) == 0)
        error('The value for the field "%s" in engine paremeters is empty. Check if the parameter name is in the first column in Excel\nAKA Someone broke the Excel file', fields{i});
    end
    
    if ( mode ~= 1 && length(engine_params.(fields{i})) ~= 1 && mode ~= length(engine_params.(fields{i})) )
        error('You cannot have Monte Carlo and Range in the same sim run');
    elseif ( mode == 1 )
        mode = length(engine_params.(fields{i}));
    end
end

fields = fieldnames(prop_params);
for i = 1:numel(fields)
    
    fields2 = fieldnames(prop_params.(fields{i}));
    
    for j = 1:numel(fields2)
        if( strcmp(fields2{j},'name'))
            %Don't ask why this has to be done this way, I don't know but
            %it doesn't work otherwise
        else
            if(length(prop_params.(fields{i}).(fields2{j})) == 0)
                error('The value for the field "%s.%s" in prop paremeters is empty. Check if the parameter name is in the first column in Excel\nAKA Someone broke the Excel file', fields{i},fields2{j});
            end
            
            if ( mode ~= 1 && length(prop_params.(fields{i}).(fields2{j})) ~= 1 && mode ~= length(prop_params.(fields{i}).(fields2{j})) )
                error('You cannot have Monte Carlo and Range in the same sim run');
            elseif ( mode == 1 )
                mode = length(prop_params.(fields{i}).(fields2{j}));
            end
        end
        
    end
end

fields = fieldnames(rocket_params);
for i = 1:numel(fields)
    
    if(length(rocket_params.(fields{i})) == 0)
        error('The value for the field "%s" in rocket paremeters is empty. Check if the parameter name is in the first column in Excel\nAKA Someone broke the Excel file', fields{i});
    end
    
    if ( mode ~= 1 && length(rocket_params.(fields{i})) ~= 1 & mode ~= length(rocket_params.(fields{i})) )
        error('You cannot have Monte Carlo and Range in the same sim run');
    elseif ( mode == 1 )
        mode = length(rocket_params.(fields{i}));
    end
end

fields = fieldnames(avionics_params);
for i = 1:numel(fields)
    
    if(length(avionics_params.(fields{i})) == 0)
        error('The value for the field "%s" in avionics paremeters is empty. Check if the parameter name is in the first column in Excel\nAKA Someone broke the Excel file', fields{i});
    end
    
    if ( mode ~= 1 && length(avionics_params.(fields{i})) ~= 1 & mode ~= length(avionics_params.(fields{i})) )
        error('You cannot have Monte Carlo and Range in the same sim run');
    elseif ( mode == 1 )
        mode = length(avionics_params.(fields{i}));
    end
end

if(mode > 3 || mode < 1)
    error('error in detecting single value/monte carlo/range of values');
end

end

