---@param v any
---@return 'string' | 'number' | 'nil' | 'thread' | 'function' | 'boolean' | 'userdata' | 'table' | 'float'
return function(v)
    if (not v) then return 'nil' end;
    local typeof = type(v);

    if (typeof == 'number') then
        typeof = tostring(v):find('%.') and 'float' or 'number';
    end

    return typeof;
end