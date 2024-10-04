---@param value string | number
---@return boolean
return function(value)
    if (not value) then return end;

    if (type(value) == 'number') then
        return (value == 0) and false or true;
    elseif (type(value) == 'string') then
        return (value == 'false') and false or true;
    end
end